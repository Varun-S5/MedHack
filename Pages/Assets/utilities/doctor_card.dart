import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String doctorImagePath;
  final String doctorName;

  DoctorCard({
    required this.doctorImagePath,
    required this.doctorName,
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0,),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
        padding:EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.green[200],),

          child:Column(
            children: [
              //picture of doctor
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(doctorImagePath,
                  height: 100,
                ),
              ),


              SizedBox(height:10),

              Row(
                children: [
                  Icon(
                      Icons.star,
                  color: Colors.yellow[600],),
                ],
              ),


              SizedBox(
                height: 10,
              ),
              //doctor name
              Text(doctorName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),),

            ],

          )
      ),
    );
  }
}
