import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie/my_theme.dart';
import 'package:movie/pages/home_screen/home_screen.dart';
import 'package:movie/pages/home_screen/my_bloc_observer.dart';
import 'package:movie/pages/init_route/init_route.dart';

void main (){
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.enableNetwork();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale('en'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      initialRoute: InitRoute.routeName,
      routes: {
        InitRoute.routeName:(context)=>InitRoute(),
      },
      theme: MyTheme.myTheme,
    );
  }

}