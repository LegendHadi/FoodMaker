import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late List<Recipe> _data;
  // List<bool> foodsFavoriteStatus =
  //     List.generate(getRecipes().length, (index) => false);

  @override
  void initState() {
    super.initState();
    _data = getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.sort,
          color: Colors.black,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        // systemOverlayStyle: SystemUiOverlayStyle(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation1('Springy Salads'),
                  buildTextSubTitleVariation1(
                      'Healthy and nutritious food recipes'),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      option('Vegetable', 'assets/icon/salad.png', 0),
                      const SizedBox(
                        width: 8,
                      ),
                      option('Rice', 'assets/icon/rice.png', 1),
                      const SizedBox(
                        width: 8,
                      ),
                      option('Fruit', 'assets/icon/fruit.png', 2),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 350,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: buildRecipes(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            if (_data.any((recipe) => recipe.isFavorite))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    buildTextTitleVariation2('Popular', false),
                    const SizedBox(
                      width: 8,
                    ),
                    buildTextTitleVariation2('Food', true),
                  ],
                ),
              ),
            if (_data.any((recipe) => recipe.isFavorite))
              SizedBox(
                height: 190,
                child: PageView(
                  physics: const BouncingScrollPhysics(),
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
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [kBoxShadow],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
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
            const SizedBox(
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
    for (var i = 0; i < _data.length; i++) {
      list.add(buildRecipe(_data[i], i));
    }
    return list;
  }

  Widget buildRecipe(Recipe recipe, int index) {
    return GestureDetector(
      onTap: () async {
        bool resultFavorite = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(
              recipe: recipe,
            ),
          ),
        ) as bool;
        if (resultFavorite != recipe.isFavorite) {
          setState(() {
            recipe.isFavorite = resultFavorite;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [kBoxShadow],
        ),
        margin: EdgeInsets.only(
            right: 16, left: index == 0 ? 16 : 0, bottom: 16, top: 8),
        padding: const EdgeInsets.all(16),
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
            const SizedBox(
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
                      recipe.isFavorite = !recipe.isFavorite;
                      // if (recipe.isFavorite) {
                      //   recipe.isFavorite = false;
                      // } else {
                      //   recipe.isFavorite = true;
                      // }
                      // foodsFavoriteStatus[index] = !foodsFavoriteStatus[index];
                    });
                  },
                  icon: Icon(
                    recipe.isFavorite
                        // foodsFavoriteStatus[index]
                        ? Icons.favorite_rounded
                        : Icons.favorite_border,
                    color: recipe.isFavorite ? Colors.red : null,
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
    final favoriteRecipe = _data.where((recipe) => recipe.isFavorite).toList();
    final list =
        favoriteRecipe.map((favorite) => buildPopular(favorite)).toList();

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
      onTap: () async {
        bool resultFavorite = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(
              recipe: recipe,
            ),
          ),
        ) as bool;
        if (resultFavorite != recipe.isFavorite) {
          setState(() {
            recipe.isFavorite = resultFavorite;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                              recipe.isFavorite = !recipe.isFavorite;
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
