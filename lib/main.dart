import 'package:core_resources/core_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pullcounter/shared/utils.dart';

import 'shared/app_router.dart';

// ignore: avoid_void_async
void main() async {
  await setup();
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Gacha Pull Counter',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      routerConfig: AppRouter.routes,
    );
  }
}

Future<void> setup() async {
  await Dependencies.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).orNull();

  registerDependencies();
}

void registerDependencies() {}
