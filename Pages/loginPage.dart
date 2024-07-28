import 'package:flutter/material.dart';
import 'package:new_app/homePage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Green Theme Login UI',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade800, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[

                SizedBox(height: 30),
                reusableTextField("Enter Email", Icons.email_outlined, false,
                    _emailController),
                SizedBox(height: 20),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordController),
                SizedBox(height: 20),
                forgetPassword(context),
                loginButton(context, _emailController, _passwordController),
                signUpOption(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logoWidget(String imageName) {
    return Image.asset(
      imageName,
      height: 100,
      width: 100,
    );
  }

  Widget reusableTextField(String hint, IconData icon, bool isPasswordType,
      TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: isPasswordType,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black54),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.black54),
        ),
        onPressed: () {
          // Implement forgot password functionality here
        },
      ),
    );
  }

  Widget loginButton(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
      ),
      child: Text(
        "Login",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );// Implement login functionality here
      },
    );
  }

  Widget signUpOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.black54),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpPage()),
            );
          },
          child: Text(
            "Sign Up",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Sign Up"),
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade800, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/logo1.png"),
                SizedBox(height: 30),
                reusableTextField("Enter Email", Icons.email_outlined, false,
                    _emailController),
                SizedBox(height: 20),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordController),
                SizedBox(height: 20),
                reusableTextField("Confirm Password", Icons.lock_outline, true,
                    _confirmPasswordController),
                SizedBox(height: 20),
                signUpButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logoWidget(String imageName) {
    return Image.asset(
      imageName,
      height: 100,
      width: 100,
    );
  }

  Widget reusableTextField(String hint, IconData icon, bool isPasswordType,
      TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: isPasswordType,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black54),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }

  Widget signUpButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
      ),
      child: Text(
        "Sign Up",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      onPressed: () {
        // Implement sign-up functionality here
      },
    );
  }
}
