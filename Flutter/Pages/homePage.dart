import 'package:flutter/material.dart';
import 'package:new_app/utilities/category_card.dart';
import 'package:new_app/utilities/doctor_card.dart';
import 'package:lottie/lottie.dart';
import 'upload.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Med App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
  }

class HomeScreen extends StatelessWidget{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body:SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:25.0),
              child: Row(
                children: [
                  Column(

                    children: [
                      Text('Hello',
                      style:TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                      Text(
                        'User',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,

                        ),
                      )
                    ],
                  ),

                  Expanded(
                    flex:1,
                    child: SizedBox(),
                  ),

                  Container(
                    padding:EdgeInsets.all(12),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color:Colors.green[100],
                      borderRadius: BorderRadius.circular(12),

                    ),

                    child:Icon(Icons.person)
                  )
                ],
              ),
            ),

            SizedBox(height:25),

            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 25.0),
              child:Container(
                padding:EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color:Colors.pink[100],
                borderRadius: BorderRadius.circular(12),
                ),
                child:Row(
                  children: [
                    Container(
                      height:125,
                      width:125,
                      child:Lottie.asset('lib/images/Animation - 1720797176819.json',),
                    ),

                    SizedBox(
                      width:20,
                    ),

                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('How do you feel?',
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:18,
                            )
                            ),
                            SizedBox(height:12,),
                            Text('Fill your medical card right now',
                            style:TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                              
                            SizedBox(height:8),
                            Container(
                              padding:EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:Colors.green[400],
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Center(
                                child: Text('Get started',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),)
                              ),

                            )
                          ],
                        )
                    )
                  ],
                )
              )
            ),

            SizedBox(height:25),

            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 25.0),
              child:(
              Container(
                decoration: BoxDecoration(
                  color:Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),

                child:TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border:InputBorder.none,
                    hintText: 'How can we help you?',
                  ),
                )
              )
              )
            ),

            SizedBox(height:25),

            Container(
              height:80,
              child:ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReportFormScreen()),
                      );
                    },
                    child: CategoryCard(
                      categoryName: 'Upload',
                      iconImagePath: 'lib/icons/cloud-computing.png',
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReportFormScreen()),
                      );
                    },
                    child: CategoryCard(
                      categoryName: 'Analyse',
                      iconImagePath: 'lib/icons/analysing.png',
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReportFormScreen()),
                      );
                    },
                    child: CategoryCard(
                      categoryName: 'Settings',
                      iconImagePath: 'lib/icons/setting.png',
                    ),
                  ),
                ],
              )
            ),

            SizedBox(height:25),

            //News

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text('Doctors',
                  style:TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )
                  ),
                  Text('See all',
                  style:TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
    ]
              ),
            ),

            SizedBox(height:25),

            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  DoctorCard(
                    doctorImagePath: 'lib/images/doctorm.png',
                    doctorName: 'Dr. Doctor1',
                  ),

                  DoctorCard(
                    doctorImagePath: 'lib/images/doctorf.png',
                    doctorName: 'Dr. Doctor2',
                  ),

                  DoctorCard(
                    doctorImagePath: 'lib/images/doctorm.png',
                    doctorName: 'Dr. Doctor3',
                  ),

                  DoctorCard(
                    doctorImagePath: 'lib/images/doctorf.png',
                    doctorName: 'Dr. Doctor4',
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
