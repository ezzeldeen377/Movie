import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCubit extends Cubit<String> {
  AppCubit({String initialLanguage = 'en'}) : super(initialLanguage);

  Future<void> initCubit() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final language = prefs.getString('language') ?? state;
      emit(language);
    } catch (e) {
      print(e.toString());
    }
  }

  void changeLanguage(String newLanguage) async {
    if (state == newLanguage) {
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', newLanguage);
    emit(newLanguage);
  }
}

