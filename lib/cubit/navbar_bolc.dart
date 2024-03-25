
import 'package:flutter_bloc/flutter_bloc.dart';

import 'naverbar_states.dart';

class NavbarCubit extends Cubit<NavbarStates>{
  NavbarCubit():super(InitialState());
  static NavbarCubit get(context)=>BlocProvider.of(context);
  int counter=0;

void getCounter(int index){
  counter=index;
  emit(ChangeIndex());
}

}