import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sneakers_app/theme/custom_app_theme.dart';

import '../../../animation/fadeanimation.dart';
import '../../../utils/constants.dart';
import '../../../models/shoe_model.dart';
import '../../detail/detail_screen.dart';
import '../../../data/dummy_data.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedIndexOfCategory = 0;
  int selectedIndexOfFeatured = 1;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          topCategoriesWidget(width, height),
          SizedBox(height: height * 0.01), // Responsive spacing
          middleCategoriesWidget(width, height),
          SizedBox(height: height * 0.005), // Responsive spacing
          moreTextWidget(),
          lastCategoriesWidget(width, height),
        ],
      ),
    );
  }

  // Top Categories Widget Components
  Widget topCategoriesWidget(double width, double height) {
    return SizedBox(
      height: height * 0.055,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndexOfCategory = index;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontSize: selectedIndexOfCategory == index ? width * 0.055 : width * 0.045,
                  color: selectedIndexOfCategory == index
                      ? AppConstantsColor.darkTextColor
                      : AppConstantsColor.unSelectedTextColor,
                  fontWeight: selectedIndexOfCategory == index
                      ? FontWeight.bold
                      : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Middle Categories Widget Components
  Widget middleCategoriesWidget(double width, double height) {
    return Row(
      children: [
        SizedBox(
          width: width * 0.1,
          height: height * 0.37,
          child: RotatedBox(
            quarterTurns: -1,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: featured.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndexOfFeatured = index;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: Text(
                      featured[index],
                      style: TextStyle(
                        fontSize: selectedIndexOfFeatured == index ? width * 0.05 : width * 0.045,
                        color: selectedIndexOfFeatured == index
                            ? AppConstantsColor.darkTextColor
                            : AppConstantsColor.unSelectedTextColor,
                        fontWeight: selectedIndexOfFeatured == index
                            ? FontWeight.bold
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: width * 0.8,
          height: height * 0.4,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: availableShoes.length,
            itemBuilder: (ctx, index) {
              ShoeModel model = availableShoes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => DetailScreen(
                        model: model,
                        isComeFromMoreSection: false,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(width * 0.04),
                  width: width * 0.7,
                  child: Stack(
                    children: [
                      Container(
                        width: width * 0.6,
                        decoration: BoxDecoration(
                          color: model.modelColor,
                          borderRadius: BorderRadius.circular(width * 0.08),
                        ),
                      ),
                      Positioned(
                        left: width * 0.02,
                        child: FadeAnimation(
                          delay: 1,
                          child: Row(
                            children: [
                              Text(model.name, style: AppThemes.homeProductName),
                              SizedBox(width: width * 0.3),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: height * 0.06,
                        left: width * 0.02,
                        child: FadeAnimation(
                          delay: 1.5,
                          child: Text(model.model, style: AppThemes.homeProductModel),
                        ),
                      ),
                      Positioned(
                        top: height * 0.12,
                        left: width * 0.02,
                        child: FadeAnimation(
                          delay: 2,
                          child: Text(
                            "\$${model.price.toStringAsFixed(2)}",
                            style: AppThemes.homeProductPrice,
                          ),
                        ),
                      ),
                      Positioned(
                        left: width * 0.05,
                        top: height * 0.1,
                        child: FadeAnimation(
                          delay: 2,
                          child: Hero(
                            tag: model.imgAddress,
                            child: RotationTransition(
                              turns: const AlwaysStoppedAnimation(-30 / 360),
                              child: SizedBox(
                                width: width * 0.7,
                                height: height * 0.35,
                                child: Image(
                                  image: AssetImage(model.imgAddress),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: height * 0.02,
                        left: width * 0.6,
                        child: IconButton(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.arrowCircleRight,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  // More Text Widget Components
  Widget moreTextWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text("More", style: AppThemes.homeMoreText),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              CupertinoIcons.arrow_right,
              size: 27,
            ),
          ),
        ],
      ),
    );
  }

  // Last Categories Widget Components
  Widget lastCategoriesWidget(double width, double height) {
    return SizedBox(
      height: height * 0.25,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: availableShoes.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          ShoeModel model = availableShoes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => DetailScreen(
                    model: model,
                    isComeFromMoreSection: true,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(width * 0.03),
              width: width * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.03),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: width * 0.015,
                    child: FadeAnimation(
                      delay: 1,
                      child: Container(
                        width: width * 0.07,
                        height: height * 0.1,
                        color: Colors.red,
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: Center(
                            child: FadeAnimation(
                              delay: 1.5,
                              child: Text("NEW", style: AppThemes.homeGridNewText),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: width * 0.35,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border,
                        color: AppConstantsColor.darkTextColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.05,
                    left: width * 0.06,
                    child: FadeAnimation(
                      delay: 1.5,
                      child: Hero(
                        tag: model.imgAddress,
                        child: SizedBox(
                          width: width * 0.3,
                          height: height * 0.15,
                          child: Image(
                            image: AssetImage(model.imgAddress),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.15,
                    left: width * 0.06,
                    child: FadeAnimation(
                      delay: 2,
                      child: Text(model.name, style: AppThemes.homeProductName),
                    ),
                  ),
                  Positioned(
                    top: height * 0.19,
                    left: width * 0.06,
                    child: FadeAnimation(
                      delay: 2.5,
                      child: Text("\$${model.price.toStringAsFixed(2)}", style: AppThemes.homeGridPrice),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
