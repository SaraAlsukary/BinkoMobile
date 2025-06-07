import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../services/shared_preferences_service.dart';

part 'theme_state.dart';

@lazySingleton
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(LightTheme()) {
    getTheme();
  }

  Future<void> getTheme() async {
    final theme = SharedPreferencesService.getTheme();
    if (theme == 'dark') {
      emit(DarkTheme());
    } else {
      emit(LightTheme());
    }
  }

  Future<void> toggleTheme() async {
    if (state is LightTheme) {
      await SharedPreferencesService.storeTheme('dark');
      emit(DarkTheme());
    } else {
      await SharedPreferencesService.storeTheme('light');
      emit(LightTheme());
    }
  }
}
