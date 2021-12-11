import 'package:bmi_calculator/modules/bmi/bmi_result_scr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class homeScr extends StatefulWidget {
  const homeScr({Key? key}) : super(key: key);

  @override
  _homeScrState createState() => _homeScrState();
}

class _homeScrState extends State<homeScr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('BMI')),
        ),
        body: mainContainer());
  }

  //------------
  dataHomeScr data = dataHomeScr();

  //main container
  Widget mainContainer() => Container(
        color: Color(0xff202540),
        child: Column(
          children: [
            Expanded(flex: 1, child: genderChoose()),
            Expanded(flex: 1, child: heightAndBar()),
            Expanded(flex: 1, child: weightAndAge()),
            calculatorButton()
          ],
        ),
      );

  // gender
  Widget genderChoose() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
                child: genderImage(
                    icon: Icons.male, name: 'male', isMalLocal: true)),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: genderImage(
                    icon: Icons.female, name: 'female', isMalLocal: false)),
          ],
        ),
      );

  // gender image
  Widget genderImage(
          {IconData icon = Icons.star,
          String name = 'name',
          bool isMalLocal = true}) =>
      GestureDetector(
        onTap: () {
          setState(() {
            data.isMal = isMalLocal;
          });
        },
        child: Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 120,
                color: Colors.white,
              ),
              textSimmpl(txt: name)
            ],
          ),
          decoration: BoxDecoration(
              color: checkMal(isMalLocal),
              borderRadius: BorderRadius.circular(10)),
        ),
      );

  // check if press male or not
  Color checkMal(bool isMalLocal) {
    if (data.isMal) {
      return isMalLocal ? Colors.blue : data.cardsClr;
    }
    if (!data.isMal) {
      return !isMalLocal ? Colors.blue : data.cardsClr;
    }
    return data.cardsClr;
  }

  Widget textSimmpl({String txt = 'text', double size = 25}) => Text(
        txt,
        style: TextStyle(
            fontSize: size, fontWeight: FontWeight.bold, color: Colors.white),
      );

  // height
  Widget heightAndBar() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textSimmpl(txt: 'Height'.toUpperCase()),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textSimmpl(
                      txt: data.heightBarValue.toInt().toString() + ' ',
                      size: 40),
                  textSimmpl(txt: 'CM'),
                ],
              ),
              heightSlider(),
            ],
          ),
          decoration: mainCardDecoration(),
        ),
      );

  // weight Slider
  Slider heightSlider() => Slider(
      value: data.heightBarValue,
      max: 220,
      min: 80,
      onChanged: (value) {
        setState(() {
          data.heightBarValue = value.round().toDouble();
        });
      });

  // weight and age
  Widget weightAndAge() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
                child: textAndCounter(
                    txt: 'weight', cuonter: data.weight, variable: 'weight')),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: textAndCounter(
                    txt: 'age', cuonter: data.age, variable: 'age')),
          ],
        ),
      );

  // Text And counter Card
  Widget textAndCounter(
          {String txt = 'text',
          int cuonter = 25,
          String variable = 'weight'}) =>
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textSimmpl(txt: txt.toUpperCase()),
            textSimmpl(txt: cuonter.toString(), size: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                addOrRemoveButton(() {
                  addRemoveValue(operator: '+', variable: variable);
                }, icon: Icons.add, name: '$variable+'),
                addOrRemoveButton(() {
                  addRemoveValue(operator: '-', variable: variable);
                }, icon: Icons.remove, name: '$variable-'),
              ],
            )
          ],
        ),
        decoration: mainCardDecoration(),
      );

  // calculator button
  Widget calculatorButton() => Container(
        color: data.themButtonsClr,
        width: double.infinity,
        child: MaterialButton(
          onPressed: () {
            goToResultScr();
          },
          height: 60,
          child: textSimmpl(txt: 'CALCULATE'),
        ),
      );

  // add and remove button
  Widget addOrRemoveButton(fun,
          {IconData icon = Icons.add, String name = 'd'}) =>
      FloatingActionButton(
        heroTag: name,
        onPressed: fun,
        mini: true,
        child: Icon(icon),
      );

  // decoration one card
  BoxDecoration mainCardDecoration() => BoxDecoration(
      color: data.cardsClr, borderRadius: BorderRadius.circular(10));

  // -----------
  addRemoveValue({String operator = '+', String variable = 'weight'}) {
    variable == 'age' // is var == age ?
        ? operator == '+' // yes var == age  -> ok check if it + or -
            ? ++data.age // yes add
            : --data.age // no
        : operator == '+' // var == weight
            ? ++data.weight
            : --data.weight;
    data.weight = data.weight <= 0 ? 0 : data.weight;
    data.age = data.age <= 0 ? 0 : data.age;
    setState(() {});
  }

  goToResultScr() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BMIResultScr(
                  age: data.age,
                  result: 5,
                  isMale: data.isMal,
                )));
  }


}

class dataHomeScr {
  double heightBarValue = 120;
  int weight = 20;
  int age = 18;
  bool isMal = true;
  Color themButtonsClr = Color(0xffde3164);
  Color cardsClr = Color(0xff363960);
}
