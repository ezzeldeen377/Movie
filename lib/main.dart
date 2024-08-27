import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/firebase_options.dart';
import 'package:movie/my_bloc_observer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie/my_theme.dart';
import 'package:movie/pages/init_route/init_route.dart';
import 'package:movie/pages/search/Cubit/search_cubit.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.enableNetwork();
  FirebaseFirestore.instance.enableNetwork();
  FirebaseFirestore.instance.enableNetwork();
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseFirestore.instance.enableNetwork();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        initialRoute: InitRoute.routeName,
        routes: {
          InitRoute.routeName: (context) => InitRoute(),
        },
        theme: MyTheme.myTheme,
      ),
    );
  }

}