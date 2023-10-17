import 'package:flutter/material.dart';
import 'package:trader/gen/assets.gen.dart';
import 'package:trader/screens/homeScreen/home.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xffF3F5F8),
      body: Stack(
        children: [
          Positioned.fill(
              child: Assets.image.splash.splash.image(fit: BoxFit.cover)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100,),

              Center(
                
                child: Assets.image.splash.splashIcon
                    .image(height: 400  , width: 400),
              ),
              

              Text(
                'Remember Why You Started...',
                style: themeData.textTheme.bodyLarge!.copyWith(fontSize: 28 ,fontFamily:'BebasNeue' , color: Colors.black),
              )
            ],
          ),
        ],
      ),
    );
  }
}
