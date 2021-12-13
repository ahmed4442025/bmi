import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/modules/counter_scr/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit() : super(CounterInitState());

  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 1;

  void minus(){
    counter--;
    emit(CounterMinusState(counter));
  }

  void add(){
    counter++;
    emit(CounterPlusState(counter));
  }

}