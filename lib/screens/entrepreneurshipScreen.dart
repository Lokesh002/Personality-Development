import 'package:flutter/material.dart';
import 'package:self_improvement/components/sizeConfig.dart';
import 'package:self_improvement/components/reusable_card.dart';
import 'package:self_improvement/components/networking.dart';

class EntrepreneurshipScreen extends StatefulWidget {
  static String id = 'entrepreneurship';
  @override
  _EntrepreneurshipScreenState createState() => _EntrepreneurshipScreenState();
}

class _EntrepreneurshipScreenState extends State<EntrepreneurshipScreen> {
  SizeConfig size2;
  String imageUrl;
  @override
  void initState() {
    super.initState();
    getEntrepreneurshipImage();
  }

  void getEntrepreneurshipImage() async {
    var url = 'http://35.232.91.244/api/get_entrepreneurship';
    Networking networking = Networking(url);
    var decodedData = await networking.getImage();
    imageUrl = decodedData['image'];
    print(imageUrl);
    updateImage();
  }

  var image = Image.asset('images/Logo.png');
  void updateImage() {
    setState(() {
      image = Image.network(
        'http://35.232.91.244/storage/images/entrepreneurship/$imageUrl',
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
                'Startup World',
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
