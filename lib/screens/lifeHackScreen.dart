import 'package:flutter/material.dart';
import 'package:self_improvement/components/sizeConfig.dart';
import 'package:self_improvement/components/reusable_card.dart';
import 'package:self_improvement/components/networking.dart';

class LifeHackScreen extends StatefulWidget {
  static String id = 'selfimprovement';
  @override
  _LifeHackScreenState createState() => _LifeHackScreenState();
}

class _LifeHackScreenState extends State<LifeHackScreen> {
  SizeConfig size2;
  String imageUrl;
  @override
  void initState() {
    super.initState();
    getSelfImprovementImage();
  }

  var image = Image.asset('images/Logo.png');
  void updateImage() {
    setState(() {
      image = Image.network(
        'http://35.232.91.244/storage/images/life_hack/$imageUrl',
        fit: BoxFit.fill,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes
                  : null,
            ),
          );
        },
      );
    });
  }

  void getSelfImprovementImage() async {
    var url = 'http://35.232.91.244/api/get_life_hack';
    Networking networking = Networking(url);
    var decodedData = await networking.getImage();
    imageUrl = decodedData['image'];
    print(imageUrl);
    updateImage();
  }

  @override
  Widget build(BuildContext context) {
    size2 = SizeConfig(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Color(0xff222222),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: SizedBox(
                height: size2.screenHeight * 10,
              ),
            ),
            Center(
              child: Text(
                'Life Hack',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: size2.screenHeight * 3.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffdddddd)),
              ),
            ),
//            Center(
//              child: SizedBox(
//                height: size2.screenHeight * 1,
//              ),
//            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ReusableCard(
                colour: Color(0xff222222),
                onPress: () {},
                cardChild: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: image,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
