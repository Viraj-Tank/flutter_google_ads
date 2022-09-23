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
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();

    _createBannerAd();
    _createInterstitialAd();
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

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdMobService.interstitialAdId!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
    }
    _interstitialAd!.show();
    _interstitialAd = null;
  }
}
