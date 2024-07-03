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
  late List<Recipe> favoriteFood;

  @override
  void initState() {
    super.initState();
    _data = getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    favoriteFood = _data.where((recipe) => recipe.isFavorite).toList();
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

  Widget buildFood(Recipe data, bool isFirst) {
    return GestureDetector(
      onTap: () async {
        bool resultFavorite = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(
              recipe: data,
            ),
          ),
        ) as bool;
        if (resultFavorite != data.isFavorite) {
          setState(() {
            data.isFavorite = resultFavorite;
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
            right: 16, left: isFirst ? 16 : 0, bottom: 16, top: 8),
        padding: const EdgeInsets.all(16),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Hero(
                tag: data.media.image,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image/${data.media.image}'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            buildRecipeTitle(data.title),
            buildTextSubTitleVariation2(data.description),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCalories(data.nutrition.calorie
                        .toString()
                        .replaceAll(regexToRemoveZeroDecimal, '') +
                    'Kcal'),
                // Icon(Icons.favorite_border),
                IconButton(
                  onPressed: () {
                    setState(() {
                      data.isFavorite = !data.isFavorite;
                      // if (recipe.isFavorite) {
                      //   recipe.isFavorite = false;
                      // } else {
                      //   recipe.isFavorite = true;
                      // }
                      // foodsFavoriteStatus[index] = !foodsFavoriteStatus[index];
                    });
                  },
                  icon: Icon(
                    data.isFavorite
                        // foodsFavoriteStatus[index]
                        ? Icons.favorite_rounded
                        : Icons.favorite_border,
                    color: data.isFavorite ? Colors.red : null,
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

  Widget buildPopular(int index) {
    return GestureDetector(
      onTap: () async {
        bool resultFavorite = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(
              recipe: favoriteFood[index],
            ),
          ),
        ) as bool;
        if (resultFavorite != favoriteFood[index].isFavorite) {
          setState(() {
            favoriteFood[index].isFavorite = resultFavorite;
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
                  image: AssetImage(
                      'assets/image/${favoriteFood[index].media.image}'),
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
                    buildRecipeTitle(favoriteFood[index].title),
                    buildRecipeSubTitle(favoriteFood[index].description),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildCalories(favoriteFood[index]
                                .nutrition
                                .calorie
                                .toString()
                                .replaceAll(regexToRemoveZeroDecimal, '') +
                            'Kcal'),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              favoriteFood[index].isFavorite =
                                  !favoriteFood[index].isFavorite;
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
    return Column(
      children: [
        if (favoriteFood.isNotEmpty)
          // if (_data.any((recipe) => recipe.isFavorite))
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
        if (favoriteFood.isNotEmpty)
          // if (_data.any((recipe) => recipe.isFavorite))
          SizedBox(
            height: 190,
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: favoriteFood.length,
              itemBuilder: (context, index) {
                return buildPopular(index);
              },
            ),
          ),
      ],
    );
  }
}
