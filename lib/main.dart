import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/route/route.dart';
import 'core/config/route/route_name.dart';
import 'core/config/theme/app_theme.dart';
import 'features/load_rqm/repo_and_bloc_provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: Repository.all,
      child: MultiBlocProvider(
        providers: BlocProviderData.all,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Diote',
          theme: AppTheme.lightTheme(),
          initialRoute: AppRouteName.loadRQM,
          onGenerateRoute: AppRoute.onGenerateRoute,
        ),
      ),
    );
  }
}
