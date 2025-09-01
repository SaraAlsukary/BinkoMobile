import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'main_state.dart';

@lazySingleton
class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState());

  changeIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
