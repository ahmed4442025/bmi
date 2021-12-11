import 'package:flutter/material.dart';

class testFun extends StatefulWidget {
  const testFun({Key? key}) : super(key: key);

  @override
  _testFunState createState() => _testFunState();
}

class _testFunState extends State<testFun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainContainer(),
    );
  }

  //==============
  Widget mainContainer() => Container(
        child: Center(
          child: simpleBottun(onpressed:fun),
        ),
      );


  void fun(){
    print('this is fun()');
  }

  Widget simpleBottun(
          {Function()? onpressed,
          String txt = 'Log in',
          bool upercase = true,
          double hight = 40,
          Color clr = Colors.blue,
          double borderR = 10}) =>
      Container(
        width: double.infinity,
        height: 40,
        child: MaterialButton(
          onPressed: onpressed,
          child: Text(
            upercase ? txt.toUpperCase() : txt,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: clr,
        ),
      );
}
