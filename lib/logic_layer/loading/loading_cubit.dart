import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingState());
  bool isloading = true;
  bool unloading = false;

 
  void loadingActive() {
    emit(LoadingActive());
  }

  void loadingInactive() => emit(LoadingInActive());
}
