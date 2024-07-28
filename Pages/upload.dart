import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Submit Report',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ReportFormScreen(),
    );
  }
}

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({Key? key}) : super(key: key);

  @override
  _ReportFormScreenState createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String _userName = '';
  int _age = 0;
  String _docName = '';
  File? _reportImage;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _reportImage = File(pickedFile.path);
          print("Selected file path: ${_reportImage?.path}");
        });
      } else {
        print("No image selected");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      if (_reportImage != null) {
        if (!_reportImage!.existsSync()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('The selected file does not exist')),
          );
          return;
        }

        setState(() {
          _isLoading = true;
        });

        String fileName = 'reports/${DateTime.now().millisecondsSinceEpoch}.jpg';
        try {
          // Upload image to Firebase Storage
          UploadTask task = _storage.ref(fileName).putFile(_reportImage!);
          TaskSnapshot snapshot = await task;

          if (snapshot.state == TaskState.success) {
            String downloadUrl = await snapshot.ref.getDownloadURL();

            // Save data to Firestore
            await _firestore.collection('reports').add({
              'userName': _userName,
              'age': _age,
              'docName': _docName,
              'reportUrl': downloadUrl,
              'timestamp': FieldValue.serverTimestamp(),
            });

            // Clear form
            _formKey.currentState?.reset();
            setState(() {
              _reportImage = null;
              _isLoading = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Report submitted successfully'),
            ));
          } else {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Failed to upload report image'),
            ));
          }
        } catch (error) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to upload report: $error'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select a report image'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'User Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userName = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _age = int.tryParse(value ?? '') ?? 0;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Doctor Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter doctor\'s name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _docName = value ?? '';
                  },
                ),
                const SizedBox(height: 16.0),
                if (_reportImage != null)
                  Center(
                    child: Container(
                      height: 200.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Image.file(
                        _reportImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  const Text('No image selected.'),
                const SizedBox(height: 16.0),
                if (_isLoading)
                  Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 16.0),
                        Text('Uploading... Please wait'),
                      ],
                    ),
                  )
                else ...[
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Pick Report Image'),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit Report'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}