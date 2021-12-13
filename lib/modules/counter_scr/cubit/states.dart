abstract class CounterStates {}

class CounterInitState extends CounterStates {}

class CounterMinusState extends CounterStates {
  int counter;

  CounterMinusState(this.counter);
}

class CounterPlusState extends CounterStates {
  int counter;

  CounterPlusState(this.counter);
}
