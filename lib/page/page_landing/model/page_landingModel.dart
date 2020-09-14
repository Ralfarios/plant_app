import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:plant_app/core/consts/path/image.dart';

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
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.transparent,
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
                      color: cBlack, fontWeight: FontMedium, fontSize: 14)),
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

class BrowseTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        itemCount: categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) => ElCarde(
          landingCategory: categories[index],
          press: () {},
        ),
      ),
    );
  }
}

List<String> imageList = [
  imExp1,
  imExp2,
  imExp3,
  imExp4,
  imExp5,
  imExp6,
  imExp7,
];

class ExploreTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: StaggeredGridView.countBuilder(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageList[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
        },
      ),
    );
  }
}
