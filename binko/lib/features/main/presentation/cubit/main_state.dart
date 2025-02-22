// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_cubit.dart';

class MainState {
  const MainState({
    this.currentIndex = 0,
  });
  final int currentIndex;

  MainState copyWith({
    int? currentIndex,
  }) {
    return MainState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
