
import 'dart:io';

import 'package:dp_stopwatch/dp_stopwatch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:marquee_text/marquee_direction.dart';
import 'package:marquee_text/marquee_text.dart';
import 'dart:async';

import 'package:openvpn_flutter/openvpn_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late OpenVPN engine;
  VpnStatus? status;
  VPNStage? stage;
  bool _granted = false;
  var selectvpn;
  var seciliindex;
  var stageisim;
  late BannerAd staticbannerAd;
  late BannerAd inlenebannerAd;
  bool staticadloaded = false;
  bool inleneadloaded = false;

  loadbanner() {
    staticbannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      
    //  ca-app-pub-3940256099942544/6300978111
    //gerçek
    //ca-app-pub-3904218274935641/9221799881
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            staticadloaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint("banner hata   :   ${error.message}");
        },
      ),
      request: const AdRequest(),
    );
    staticbannerAd.load();
  }

  final List flags = [
    "assets/flag/1140047.png",
    "assets/flag/329980.png",
    "assets/flag/330442.png",
    "assets/flag/940156.png",
    "assets/flag/317215.png",
  ];

  final List countryname = [
    "USA",
    "FRANCE",
    "CANADA",
    "UNİTED KİNGDOM",
    "JAPAN",
  ];
  final stopwatchViewModel = DPStopwatchViewModel(
    clockTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 32,
    ),
  );

  @override
  void initState() {
    engine = OpenVPN(
      onVpnStatusChanged: (data) {
        setState(() {
          status = data;
        });
      },
      onVpnStageChanged: (data, raw) {
        setState(() {
          stage = data;
        });
      },
    );

    engine.initialize(
      groupIdentifier: "group.com.laskarmedia.vpn",
      providerBundleIdentifier:
          "id.laskarmedia.openvpnFlutterExample.VPNExtension",
      localizedDescription: "VPN by Nizwar",
      lastStage: (stage) {
        setState(() {
          this.stage = stage;
        });
      },
      lastStatus: (status) {
        setState(() {
          this.status = status;
        });
      },
    );
    super.initState();
    loadbanner();
  }

  Future<void> initPlatformState0() async {
    engine.connect(await rootBundle.loadString("assets/vpn/vpngate_vpn998612762.opengw.net_udp_1873.ovpn"), "USA",
        username: "", password: "", certIsRequired: true);
        
        
        
    if (!mounted) return;
  }

  Future<void> initPlatformState1() async {
    engine.connect(
        await rootBundle.loadString("assets/vpn/frans.ovpn"), "FRANCE",
        username: "", password: "", certIsRequired: true);
    if (!mounted) return;
  }

  Future<void> initPlatformState2() async {
    engine.connect(
        await rootBundle.loadString("assets/vpn/canada.ovpn"), "CANADA",
        username: "", password: "", certIsRequired: true);
    if (!mounted) return;
  }

  Future<void> initPlatformState3() async {
    engine.connect(await rootBundle.loadString("assets/vpn/un.ovpn"), "UNİTED",
        username: "", password: "", certIsRequired: true);
    if (!mounted) return;
  }

  Future<void> initPlatformState4() async {
    engine.connect(
        await rootBundle.loadString("assets/vpn/japanss.ovpn"), "JAPAN",
        username: "", password: "", certIsRequired: true);
    if (!mounted) return;
  }

  TextStyle stagedurumicin() {
    return const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w600,
    );
  }

  Widget stagedurumwidget() {
    switch (stage) {
      case VPNStage.prepare:
        return Text(
          "Hazırlanıyor",
          style: stagedurumicin(),
        );
        break;
      case VPNStage.authenticating:
        return Text(
          "Doğrulanıyor",
          style: stagedurumicin(),
        );
        break;
      case VPNStage.connecting:
        return Text(
          "Bağlanıyor",
          style: stagedurumicin(),
        );
        break;
      case VPNStage.authentication:
        return Text(
          "Doğrulanıyor",
          style: stagedurumicin(),
        );
        break;
      case VPNStage.disconnecting:
        return Text(
          "Bağlantı Kesiliyor",
          style: stagedurumicin(),
        );
        break;
      case VPNStage.denied:
        return Text(
          "Reddedildi",
          style: stagedurumicin(),
        );
        break;
      case VPNStage.error:
        return Text(
          "Şuan bir problem var",
          style: stagedurumicin(),
        );
        break;
      case VPNStage.wait_connection:
        return Text(
          "Bağlantı Bekleniyor",
          style: stagedurumicin(),
        );
        break;
      case VPNStage.vpn_generate_config:
        return Text(
          "VPN yapılandırılması oluşturuluyor",
          style: stagedurumicin(),
        );
        break;
      case VPNStage.get_config:
        return Text(
          "Yapılandırma alınıyor",
          style: stagedurumicin(),
        );
        break;

      case VPNStage.udp_connect:
        return Text(
          "udp_connect",
          style: stagedurumicin(),
        );
        break;
      case VPNStage.assign_ip:
        return Text(
          "IP atanıyor",
          style: stagedurumicin(),
        );
        break;
      case VPNStage.resolve:
        return Text(
          "Çözümleniyor",
          style: stagedurumicin(),
        );
        break;
      case VPNStage.exiting:
        return Text(
          "Çıkılıyor",
          style: stagedurumicin(),
        );
        break;
      case VPNStage.unknown:
        return Text(
          "Bilinmiyor",
          style: stagedurumicin(),
        );
        break;
      case VPNStage.connected:
        stopwatchViewModel.start?.call();
        return Column(
          children: [
            Text(
              "Bağlandı",
              style: stagedurumicin(),
            ),
            DPStopWatchWidget(
              stopwatchViewModel,
            ),
          ],
        );
        break;
      case VPNStage.disconnected:
        return Text(
          "Bağlı Değil",
          style: stagedurumicin(),
        );
        break;
      default:
        {
          return Text(
            "Hızlı ve Güvenli VPN ",
            style: stagedurumicin(),
          );
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue.shade200,
        appBar: AppBar(
          title: const MarqueeText(
            alwaysScroll: true,
            textDirection: TextDirection.rtl,
            text: TextSpan(
              text: '         Hızlı ve Güvenli VPN Sizin İçin Hazır    ',
            ),
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
            speed: 20,
            marqueeDirection: MarqueeDirection.rtl,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                stagedurumwidget(),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        //width: 5,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint(
                                "seçilmiş olan index    :   $seciliindex");

                            var secim = seciliindex;
                            switch (secim)  {
                              case 0:
                                {
                                  initPlatformState0();
                                }
                                break;

                              case 1:
                                {
                                  initPlatformState1();
                                }
                                break;

                              case 2:
                                {
                                  initPlatformState2();
                                }
                                break;

                              case 3:
                                {
                                  initPlatformState3();
                                }
                                break;
                              case 4:
                                {
                                  initPlatformState4();
                                }
                                break;

                              default:
                                {
                                  print("Geçersiz Seçim");
                                }
                                break;
                            }
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(10),
                            shadowColor: MaterialStateProperty.all(Colors.red),
                            side: MaterialStateProperty.all(
                              const BorderSide(
                                width: 3,
                                color: Colors.red,
                              ),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          child: const Text(
                            "BAŞLAT",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: SizedBox(
                        //width: 5,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                          
                            stopwatchViewModel.stop?.call();
                           
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(10),
                            shadowColor: MaterialStateProperty.all(Colors.red),
                            side: MaterialStateProperty.all(
                              const BorderSide(
                                width: 3,
                                color: Colors.red,
                              ),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          child: const Text(
                            "DURDUR",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                if (Platform.isAndroid)
                  TextButton(
                    child: Text(
                      _granted ? "Granted" : "Request Permission",
                      style: const TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      engine.requestPermissionAndroid().then((value) {
                        setState(() {
                          _granted = value;
                        });
                      });
                    },
                  ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: flags.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(countryname[index].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width / 20)),
                      leading: SizedBox(
                        height: 20,
                        width: 20,
                        child: Center(
                            child: selectvpn == index
                                ? const CircleAvatar(
                                    backgroundColor: Colors.green)
                                : const CircleAvatar(
                                    backgroundColor: Colors.grey)),
                      ),
                      trailing: Image.asset(
                        flags[index],
                        width: MediaQuery.of(context).size.width / 8,
                        height: MediaQuery.of(context).size.height / 8,
                      ),
                      onTap: () {
                        if (selectvpn == index) return;
                        debugPrint("seçildi   :   ${countryname[index]}");
                        //  NizVpn.stopVpn();
                        setState(() {
                          selectvpn = index;
                          seciliindex = index;
                          debugPrint("seçili indeximiz   :    $seciliindex");
                        });
                      },
                    );
                  },
                ),
             


                Container(
                  child: AdWidget(ad: staticbannerAd),
                  width: staticbannerAd.size.width.toDouble(),
                  height: staticbannerAd.size.height.toDouble(),
                  alignment: Alignment.bottomCenter,
                ),




              ],
            ),
          ),
        ),
      ),
    );
  }
}
