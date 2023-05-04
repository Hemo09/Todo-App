import 'package:flutter/material.dart';
import 'package:inkaz/home_layouts/home_layouts.dart';

class getStarted extends StatelessWidget {
  const getStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Padding(
               padding: const EdgeInsets.only(top: 200),
               child: Image.asset('images/car.png'),
             ),
              SizedBox(
                height: 200,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepPurple
                ),
                child: MaterialButton(
                  splashColor: Colors.deepPurple,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  home_layouts(),));
                  },
                  child: Text(
                    'Get Started With Todo App',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white ,),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
