import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
setState(() {
  loadAd();
});
  }
  BannerAd?_bannerAd;
  bool isTesting = true;

  adUnitId(){
    if(Platform.isAndroid){
      if(isTesting==true){
        return 'ca-app-pub-3940256099942544/6300978111';
      }
      else{
        return 'ca-app-pub-5547654790591890/4449491911';
      }
    }

  }

  void loadAd() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: adUnitId(),
        listener: BannerAdListener(
          onAdLoaded: (ad){
            debugPrint('adLoaded');
            setState(() {
            });
          },
            onAdFailedToLoad: (ad, err) {
    debugPrint('BannerAd failed to load: $err');
    ad.dispose();
    },
        ),
        request: const AdRequest()
    )..load();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
        _bannerAd != null ?
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: SizedBox(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!..load()),
            ),
          ),

      ):Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
Text('No google Ads')
            ],

          ),
        ),


    );
  }
}
