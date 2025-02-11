import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../services/shared_preferences_service.dart';

part 'theme_state.dart';

@lazySingleton
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(LightTheme());
  getTheme() async {
    final theme = SharedPreferencesService.getTheme();
    if (theme == 'dark') {
      emit(DarkTheme());
    }
  }

  setTheme(String theme) async {
    await SharedPreferencesService.storeTheme(theme);
  }
}
