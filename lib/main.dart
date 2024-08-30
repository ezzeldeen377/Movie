import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/app_provider/app_provider.dart';
import 'package:movie/firebase_options.dart';
import 'package:movie/my_bloc_observer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie/my_theme.dart';
import 'package:movie/pages/init_route/init_route.dart';
import 'package:movie/pages/search/Cubit/search_View_Model.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.enableNetwork();
  runApp( ChangeNotifierProvider(
    create: (context)=>AppProvider(),
      child: MyApp()),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppProvider>(context);
    
    return ScreenUtilInit(
      designSize: const Size(412, 892),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
          useInheritedMediaQuery: true,
          locale: Locale(provider.appLanguage),
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          initialRoute: InitRoute.routeName,
          routes: {
            InitRoute.routeName: (context) => InitRoute(),
          },
          theme: MyTheme.myTheme,
        );
      },
    );
  }

}