import 'package:flutter/material.dart';
import 'package:flutter_google_ads/utils/ad_mob_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();

    _createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mob Ads'),
      ),
      bottomNavigationBar: _bannerAd == null
          ? Container()
          : Container(
              margin: const EdgeInsets.all(8),
              height: 52,
              child: AdWidget(ad: _bannerAd!),
            ),
    );
  }

  void _createBannerAd() {
    _bannerAd = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdMobService.bannerAdId!,
        listener: AdMobService.bannerAdListener,
        request: const AdRequest())
      ..load();
  }
}
