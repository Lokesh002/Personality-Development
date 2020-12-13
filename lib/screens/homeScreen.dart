import 'package:flutter/material.dart';
import 'package:self_improvement/components/sizeConfig.dart';
import 'dart:ui';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cron/cron.dart';
import 'dart:async';

const String testDevice = 'MobileId';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String _timeString;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    childDirected: true,
    keywords: <String>['Game', 'Technology'],
  );
  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: 'ca-app-pub-8907590532350141/2590689886',
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print('BannerAd $event');
        });
  }

  double bigCircleFraction = 0.0;
  double smallCircleFraction = 0.0;
  SizeConfig size2;
  Animation<double> bigCircleAnimation, smallCircleAnimation;
  AnimationController controller;
  @override
  void initState() {
    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-8907590532350141~4892090609');
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    if (DateTime.now().hour > 5) {
      _timeString =
          "${29 - DateTime.now().hour} : ${59 - DateTime.now().minute} :${60 - DateTime.now().second}";
    } else {
      _timeString =
          "${5 - DateTime.now().hour} : ${59 - DateTime.now().minute} :${60 - DateTime.now().second}";
    }
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getCurrentTime());
    super.initState();

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('logo');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    bigCircleAnimation = Tween(begin: 1600.0, end: 900.0).animate(controller)
      ..addListener(() {
        setState(() {
          bigCircleFraction = bigCircleAnimation.value;
        });
      });
    smallCircleAnimation = Tween(begin: 1300.0, end: 900.0).animate(controller)
      ..addListener(() {
        setState(() {
          smallCircleFraction = smallCircleAnimation.value;
        });
      });
    controller.forward();

    var cron = new Cron();
    cron.schedule(new Schedule.parse('0 6 * * *'), () async {
      _showNotificationWithDefaultSound();
    });
  }

  void _getCurrentTime() {
    setState(() {
      if (DateTime.now().hour > 5) {
        _timeString =
            "${29 - DateTime.now().hour} : ${59 - DateTime.now().minute} :${60 - DateTime.now().second}";
      } else {
        _timeString =
            "${5 - DateTime.now().hour} : ${59 - DateTime.now().minute} :${60 - DateTime.now().second}";
      }
    });
  }

  Future selectNotification(String payload) async {
    debugPrint('payload: $payload');
    await Navigator.pushReplacementNamed(context, '/home');
  }

  Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'Learn',
        'Personality Development',
        'A simple app for learning and being better everyday.',
        importance: Importance.Max,
        priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Check Out Today\'s post',
      'Check all three posts for today and try to implement that.',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  @override
  Widget build(BuildContext context) {
    size2 = SizeConfig(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0x44999999),
          child: CustomPaint(
            painter: MyPainter(bigCircleFraction, smallCircleFraction),
            size: Size.infinite,
            child: ListView(
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: size2.screenHeight * 9,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: <Widget>[
                            Hero(
                              tag: 'logo',
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(
                                              size2.screenHeight * 10),
                                          topRight: Radius.circular(
                                              size2.screenHeight * 10)),
                                      color: Color(0xff545454)),
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: size2.screenWidth * 9,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Color(0xff444444),
                                        radius: size2.screenHeight * 10,
                                        backgroundImage:
                                            AssetImage('images/Logo.png'),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size2.screenHeight * 10,
                      ),
                      Material(
                        color: Color(0xbb444444),
                        borderRadius: BorderRadius.circular(10.0),
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/selfImp');
                          },
                          minWidth: 340.0,
                          height: 70.0,
                          child: Text(
                            'Self Improvement Today',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size2.screenHeight * 3,
                      ),
                      Material(
                        color: Color(0xbb444444),
                        borderRadius: BorderRadius.circular(10.0),
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/lifeHack');
                          },
                          minWidth: 340.0,
                          height: 70.0,
                          child: Text(
                            'Today\'s Life Hack',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size2.screenHeight * 3,
                      ),
                      Material(
                        color: Color(0xbb444444),
                        borderRadius: BorderRadius.circular(10.0),
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/entrepreneurship');
                          },
                          minWidth: 340.0,
                          height: 70.0,
                          child: Text(
                            'Entrepreneurship',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size2.screenHeight * 2,
                      ),
                      Center(
                        child: Container(
                          child: Text(
                            'New Day, New Learnings. ',
                            style: TextStyle(
                                fontSize: size2.screenHeight * 3,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size2.screenHeight * 2,
                      ),
                      Center(
                        child: Container(
                          child: Text(
                            'Time Left: $_timeString',
                            style: TextStyle(
                                fontSize: size2.screenHeight * 3,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _bannerAd.dispose();
    super.dispose();
  }
}

class MyPainter extends CustomPainter {
  double bigCircleAnimation, smallCircleAnimation;
  MyPainter(this.bigCircleAnimation, this.smallCircleAnimation);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xff2222222);
    Paint paint1 = Paint()..color = Color(0x99222222);

    canvas.drawCircle(Offset(300, smallCircleAnimation), 500, paint);
    canvas.drawCircle(Offset(100, bigCircleAnimation), 600, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
