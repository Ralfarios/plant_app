import 'package:flutter/material.dart';

import '../../../core/consts/path/image.dart' as images;
import '../../../core/consts/style/color.dart';
import '../../../core/consts/style/theme.dart';

class LandingCategory {
  final String name, image;
  final int prodSum;

  LandingCategory({this.name, this.prodSum, this.image});
}

List<LandingCategory> categories = [
  LandingCategory(
    name: "Plants",
    prodSum: 147,
    image: images.imPlant,
  ),
  LandingCategory(
    name: "Seeds",
    prodSum: 16,
    image: images.imFlower,
  ),
  LandingCategory(
    name: "Flowers",
    prodSum: 68,
    image: images.imFlower,
  ),
  LandingCategory(
    name: "Sprayers",
    prodSum: 17,
    image: images.imSprayer,
  ),
  LandingCategory(
    name: "Pots",
    prodSum: 47,
    image: images.imPot,
  ),
  LandingCategory(
    name: "Fertilizers",
    prodSum: 9,
    image: images.imFertilizer,
  ),
];

class ElCarde extends StatelessWidget {
  final LandingCategory landingCategory;
  final Function press;
  const ElCarde({
    Key key,
    this.landingCategory,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //borderRadius: BorderRadius.circular(16),
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(landingCategory.image),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 4),
              child: Text(landingCategory.name,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: cBlack, fontWeight: FontLight, fontSize: 14)),
            ),
            Text(landingCategory.prodSum.toString() + " products",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: cDGray, fontWeight: FontRegular, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
