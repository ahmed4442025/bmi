import 'package:bmi_calculator/modules/counter_scr/cubit/cibit.dart';
import 'package:bmi_calculator/modules/counter_scr/cubit/states.dart';
import 'package:bmi_calculator/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScr extends StatelessWidget {
  CounterScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          if(state is CounterPlusState){
            print(state.counter);
          }
        },
        builder: (context, state){
          if(state is CounterPlusState){
            print(state.counter);
          }
          return myScaffold(context);
        },
      ),
    );
  }

  // ==========
  Components comp = Components();

  // scaffold
  myScaffold(context) => Scaffold(
        appBar: appbar(),
        body: mainContainer(context),
      );

  // app Bar
  AppBar appbar() => AppBar(
        title: const Center(
          child: Text('Counter '),
        ),
      );

  mainContainer(context) => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            comp.simpleButton(
                onpressed: () {
                  CounterCubit.get(context).add();
                },
                txt: '+',
                w: 50),
            comp.box(),
            comp.simpleText(txt: CounterCubit.get(context).counter.toString()),
            comp.box(),
            comp.simpleButton(
                onpressed: () {
                  CounterCubit.get(context).minus();
                },
                txt: '-',
                w: 50),
          ],
        ),
      );
}
