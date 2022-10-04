import 'package:flutter/material.dart';
import 'package:foodager/constants.dart';
import 'package:foodager/shared.dart';
import 'data.dart';
import 'detail.dart';
import 'models/recipe.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<bool> optionSelected = [true, false, false];
  // List<bool> foodsFavoriteStatus =
  //     List.generate(getRecipes().length, (index) => false);
  List<int> favoriteRecipeIds = [];

  @override
  Widget build(BuildContext context) {
    debugPrint('explor ${favoriteRecipeIds.length}');
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0,
        leading: Icon(
          Icons.sort,
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
        // systemOverlayStyle: SystemUiOverlayStyle(),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation1('Springy Salads'),
                  buildTextSubTitleVariation1(
                      'Healthy and nutritious food recipes'),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      option('Vegetable', 'assets/icon/salad.png', 0),
                      SizedBox(
                        width: 8,
                      ),
                      option('Rice', 'assets/icon/rice.png', 1),
                      SizedBox(
                        width: 8,
                      ),
                      option('Fruit', 'assets/icon/fruit.png', 2),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              height: 350,
              // color: Colors.blue,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: buildRecipes(),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            if (favoriteRecipeIds.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    buildTextTitleVariation2('Popular', false),
                    SizedBox(
                      width: 8,
                    ),
                    buildTextTitleVariation2('Food', true),
                  ],
                ),
              ),
            if (favoriteRecipeIds.isNotEmpty)
              Container(
                height: 190,
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  children: buildPopulars(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget option(String text, String image, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          optionSelected[index] = !optionSelected[index];
        });
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: optionSelected[index] ? kPrimaryColor : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [kBoxShadow],
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            SizedBox(
              height: 32,
              width: 32,
              child: Image.asset(
                image,
                color: optionSelected[index] ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: optionSelected[index] ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildRecipes() {
    List<Widget> list = [];
    for (var i = 0; i < getRecipes().length; i++) {
      list.add(buildRecipe(getRecipes()[i], i));
    }
    return list;
  }

  Widget buildRecipe(Recipe recipe, int index) {
    return GestureDetector(
      onTap: () async{
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(
              recipe: recipe,
              favoriteIds: favoriteRecipeIds,
            ),
          ),
        );
        setState(() {
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [kBoxShadow],
        ),
        margin: EdgeInsets.only(
            right: 16, left: index == 0 ? 16 : 0, bottom: 16, top: 8),
        padding: EdgeInsets.all(16),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Hero(
                tag: recipe.media.image,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image/${recipe.media.image}'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            buildRecipeTitle(recipe.title),
            buildTextSubTitleVariation2(recipe.description),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCalories(recipe.nutrition.calorie
                        .toString()
                        .replaceAll(regexToRemoveZeroDecimal, '') +
                    'Kcal'),
                // Icon(Icons.favorite_border),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (favoriteRecipeIds
                          .any((favoriteId) => favoriteId == recipe.id)) {
                        favoriteRecipeIds.remove(recipe.id);
                      } else {
                        favoriteRecipeIds.add(recipe.id);
                      }
                      // foodsFavoriteStatus[index] = !foodsFavoriteStatus[index];
                    });
                  },
                  icon: Icon(
                    favoriteRecipeIds.any((element) => element == recipe.id)
                        // foodsFavoriteStatus[index]
                        ? Icons.favorite_rounded
                        : Icons.favorite_border,
                    color:
                        favoriteRecipeIds.any((element) => element == recipe.id)
                            ? Colors.red
                            : null,
                    // foodsFavoriteStatus[index] ? Colors.red : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildPopulars() {
    List<Widget> list = [];
    for (var i = 0; i < favoriteRecipeIds.length; i++) {
      final favoriteRecipe = getRecipes()
          .firstWhere((recipe) => recipe.id == favoriteRecipeIds[i]);
      list.add(buildPopular(favoriteRecipe));
    }
    // if(favoriteRecipeIds.isEmpty){
    //   list.add(Container(
    //     margin: EdgeInsets.all(16),
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.all(Radius.circular(20)),
    //       boxShadow: [kBoxShadow],
    //     ),
    //     child: Center(
    //         child: Text(
    //           'No favorite food',
    //           style: TextStyle(
    //             fontSize: 40,
    //           ),
    //         ),
    //     ),
    //   ));
    // }
    return list;
  }

  Widget buildPopular(Recipe recipe) {
    return GestureDetector(
      onTap: () async{
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(
              recipe: recipe,
              favoriteIds: favoriteRecipeIds,
            ),
          ),
        );
        setState(() {

        });
      },
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [kBoxShadow],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/${recipe.media.image}'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildRecipeTitle(recipe.title),
                    buildRecipeSubTitle(recipe.description),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildCalories(recipe.nutrition.calorie
                                .toString()
                                .replaceAll(regexToRemoveZeroDecimal, '') +
                            'Kcal'),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              favoriteRecipeIds.remove(recipe.id);
                            });
                          },
                          icon: const Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
