import 'package:flutter/material.dart';

import '../../core/consts/element/widget.dart';
import 'model/page_landingModel.dart';

class PageLandingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context, null, withButton(context, "Browse", Icon(Icons.settings))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) => ElCarde(
            landingCategory: categories[index],
            press: () {},
          ),
        ),
      ),
    );
  }
}
