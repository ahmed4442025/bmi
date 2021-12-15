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
          child: simpleBottun(onpressed: testAll),
          // child: CircularProgressIndicator(value: .5),
        ),
      );

  int x = 0;

  void fun() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      x += 2;
    });
    print('this is fun()$x');
  }

  Future<int> wait2Sec(int k) async {
    int y = 0;
    await Future.delayed(const Duration(milliseconds: 2000), () {
      k += 2;
    });
    return k;
  }

  void testThen() {
    int j = 0;
    wait2Sec(j).then((value) {
      j = value;
    });
    print('testThen1 :  $j');
  }

  void testThen2() {
    int j = 0;
    wait2Sec(j).then((value) {
      j = value;
      print('testThen2 :  $j');
    });
  }

  void testAll() {
    testThen();
    testThen2();
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
