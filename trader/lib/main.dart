import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trader/data/data.dart';
import 'package:trader/data/repo/repository.dart';
import 'package:trader/data/source/hive_history_source.dart';
import 'package:trader/provider/provider.dart';
import 'package:trader/screens/splashScreen/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const historyBoxName = 'box';
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryAdapter());
  await Hive.openBox<History>(historyBoxName);
  runApp(ChangeNotifierProvider<Repository<History>>(
      create: (context) =>
          Repository<History>(hiveHistoryDataSource(Hive.box(historyBoxName))),
      child: const MyApp()));
}

String defaultFontFamiy = 'CrimsonText';
Color primaryTextColor = Colors.white;
Color secondaryTextColor = Colors.white38;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ProviderLoc(),
        builder: (context, child) {
          final provider = Provider.of<ProviderLoc>(context);
          return MaterialApp(
            title: 'Flutter Demo',
            
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: provider.locale,
            theme: ThemeData(
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                backgroundColor: Color(0xffbcf246),
                foregroundColor: Colors.black,
                splashColor: Color(0xff252728),
              ),
              appBarTheme: const AppBarTheme(
                color: Color(0xffbcf246),
                centerTitle: true,
                elevation: 1,
              ),
              scaffoldBackgroundColor: const Color(0xff151718),
              textTheme: provider.locale == Locale('en')
                  ? enPrimaryTextTheme
                  : faPrimaryTextTheme,
              inputDecorationTheme: InputDecorationTheme(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  iconColor: Theme.of(context).colorScheme.secondary,
                  prefixIconColor: primaryTextColor),
              colorScheme: const ColorScheme.dark(
                onPrimary: Colors.white,
                primary: Color.fromARGB(255, 89, 124, 14),
                secondary: Color(0xffbcf246),
                surface: Color(0xff151718),
                onSurface: Colors.white,
                onSecondary: Color(0xff252728),
              ),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
        },
      );
}

TextTheme get enPrimaryTextTheme => TextTheme(
    headlineSmall: TextStyle(
      fontFamily: defaultFontFamiy,
    ),
    bodyLarge: TextStyle(
        fontSize: 32,
        fontFamily: defaultFontFamiy,
        fontWeight: FontWeight.normal,
        color: primaryTextColor),
    bodyMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        fontFamily: defaultFontFamiy,
        color: primaryTextColor),
    bodySmall: TextStyle(
        fontSize: 14, fontFamily: defaultFontFamiy, color: secondaryTextColor));

TextTheme get faPrimaryTextTheme => TextTheme(
    headlineSmall: const TextStyle(
      fontFamily: 'Badr',
    ),
    bodyLarge: TextStyle(
        fontSize: 32,
        fontFamily: 'Badr',
        fontWeight: FontWeight.normal,
        color: primaryTextColor),
    bodyMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        fontFamily: 'Badr',
        color: primaryTextColor),
    bodySmall:
        TextStyle(fontSize: 14, fontFamily: 'Badr', color: secondaryTextColor));
