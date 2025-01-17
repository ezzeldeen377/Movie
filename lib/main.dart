import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_hero_transform/local_hero_transform.dart';
import 'package:movie/app_provider/app_provider.dart';
import 'package:movie/core/di/di.dart';
import 'package:movie/features/watch_list/presentation/bloc/watch_list_view_model.dart';
import 'package:movie/firebase_options.dart';
import 'package:movie/my_bloc_observer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie/my_theme.dart';
import 'package:movie/pages/init_route/init_route.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeFirestore();
  await FirebaseFirestore.instance.disableNetwork();

  runApp(
    BlocProvider(
      create: (context) =>
          getIt<WatchListViewModel>()..getAllMoviesFromFireStore(),
      child: ChangeNotifierProvider(
          create: (context) => AppProvider(), child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(412, 892),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          locale: Locale(provider.appLanguage),
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          initialRoute: InitRoute.routeName,
          routes: {
            InitRoute.routeName: (context) => const InitRoute(),
          },
          theme: MyTheme.myTheme,
        );
      },
    );
  }
}

void initializeFirestore() {
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true, // Enable offline persistence
    cacheSizeBytes:
        Settings.CACHE_SIZE_UNLIMITED, // Adjust cache size as needed
  );
}
