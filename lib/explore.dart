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

  @override
  void initState() {
    super.initState();
    _data = getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    // favoriteFood = _data.where((recipe) => recipe.isFavorite).toList();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppbar(),
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
                  _buildCategory(),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 350,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                // children: showFood(),
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  return buildFood(_data[index], index == 0);
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            _buildFavorite(),
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

  Widget buildFood(Recipe recipe, bool isFirst) {
    return GestureDetector(
      onTap: () => _navigateToDetail(recipe),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [kBoxShadow],
        ),
        margin: EdgeInsets.only(
            right: 16, left: isFirst ? 16 : 0, bottom: 16, top: 8),
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
                IconButton(
                  onPressed: () {
                    setState(() {
                      recipe.isFavorite = !recipe.isFavorite;
                    });
                  },
                  icon: Icon(
                    recipe.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border,
                    color: recipe.isFavorite ? Colors.red : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPopularCard(Recipe recipe) {
    return GestureDetector(
      onTap: () => _navigateToDetail(recipe),
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

  PreferredSizeWidget _buildAppbar() {
    return AppBar(
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
    );
  }

  Widget _buildCategory() {
    return Row(
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
    );
  }

  Widget _buildFavorite() {
    final favoriteRecipes = _data.where((recipe) => recipe.isFavorite).toList();
    return Column(
      children: [
        if (favoriteRecipes.isNotEmpty)
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
        if (favoriteRecipes.isNotEmpty)
          SizedBox(
            height: 190,
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                return buildPopularCard(favoriteRecipes[index]);
              },
            ),
          ),
      ],
    );
  }

  void _navigateToDetail(Recipe recipe) async {
    final isFavorite = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail(
          recipe: recipe,
        ),
      ),
    ) as bool;
    if (isFavorite != recipe.isFavorite) {
      setState(() {
        recipe.isFavorite = isFavorite;
      });
    }
  }
}
