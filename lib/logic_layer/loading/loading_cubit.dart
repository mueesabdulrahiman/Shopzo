import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingState());
  bool isloading = true;
  bool unloading = false;

  // void load(bool flag) {
  //   if (flag) {
  //     log('loading--state: $flag');
  //     isloading = true;
  //     emit(LoadingActive());
  //     //isloading = false;
  //   } else {
  //     isloading = false;
  //     log('loading--in--state: $flag');
  //     emit(LoadingInActive());
  //     //isloading = null;
  //   }
  // }
  void loadingActive() {
    emit(LoadingActive());
  }

  void loadingInactive() => emit(LoadingInActive());
}
