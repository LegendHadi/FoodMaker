import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:FoodMaker/constants.dart';
import 'package:FoodMaker/models/food_category.dart';
import 'package:FoodMaker/shared.dart';
import 'data.dart';
import 'detail.dart';
import 'models/recipe.dart';
import 'models/texts.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late List<Recipe> _recipe;
  late List<FoodCategory> _categories;
  late Texts _titles;
  final List<Recipe> _recipesWithSelectedCategory = [];

  @override
  void initState() {
    super.initState();
    _recipe = getRecipes();
    _categories = getCategories();
    _titles = getTexts();
  }

  @override
  Widget build(BuildContext context) {
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
                  buildTextTitleVariation1(_titles.exploreTextTitle),
                  buildTextSubTitleVariation1(_titles.exploreTextSubTitle),
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
                itemCount: _categories[0].isSelected
                    ? _recipe.length
                    : _recipesWithSelectedCategory.length,
                itemBuilder: (context, index) {
                  return buildFood(
                    (_categories[0].isSelected
                        ? _recipe
                        : _recipesWithSelectedCategory)[index],
                    index == 0,
                    _titles,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            _buildFavorite(_titles),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryItem(FoodCategory category, bool isFirst) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isFirst) {
            category.isSelected = true;
            _recipesWithSelectedCategory.clear();
            for (var i = 0; i < _categories.length; i++) {
              if (i == 0) {
                continue;
              }
              _categories[i].isSelected = false;
            }
            // for (var category in _categories) {
            //   if (_categories.indexOf(category) != 0) {
            //     category.isSelected = false;
            //   }
            // }
          } else {
            category.isSelected = !category.isSelected;
            if (!_categories.any((c) => c.isSelected)) {
              _categories.first.isSelected = true;
            } else {
              _categories.first.isSelected = false;
            }
            if (category.isSelected) {
              _recipesWithSelectedCategory.addAll(
                  _recipe.where((r) => r.categoryId == category.id).toList());
            } else {
              _recipesWithSelectedCategory
                  .removeWhere((r) => r.categoryId == category.id);
            }
          }
        });
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: category.isSelected ? kPrimaryColor : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [kBoxShadow],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            if (isFirst == false)
              SizedBox(
                height: 32,
                width: 32,
                child: Image.asset(
                  category.image!,
                  color: category.isSelected ? Colors.white : Colors.black,
                ),
              ),
            if (isFirst == false)
              const SizedBox(
                width: 8,
              ),
            Text(
              category.title,
              style: TextStyle(
                fontSize: 14,
                color: category.isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFood(Recipe recipe, bool isFirst, Texts texts) {
    return GestureDetector(
      onTap: () => _navigateToDetail(recipe, texts),
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
                      image: AssetImage(recipe.media.image),
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

  Widget buildPopularCard(Recipe recipe, Texts texts) {
    return GestureDetector(
      onTap: () => _navigateToDetail(recipe, texts),
      child: Container(
        width: 385,
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
                  image: AssetImage(recipe.media.image),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
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
      scrolledUnderElevation: 0,
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
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return buildCategoryItem(_categories[index], index == 0);
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 15,
        ),
      ),
    );
  }

  Widget _buildFavorite(Texts texts) {
    final favoriteRecipes =
        _recipe.where((recipe) => recipe.isFavorite).toList();
    return Column(
      children: [
        if (favoriteRecipes.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                buildTextTitleVariation2(_titles.explorePopularPart1),
                const SizedBox(
                  width: 8,
                ),
                buildTextTitleVariation2(_titles.explorePopularPart2,
                    opacity: _titles.exploreIsBoldPopularPart2),
              ],
            ),
          ),
        if (favoriteRecipes.isNotEmpty)
          SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                return buildPopularCard(favoriteRecipes[index], texts);
              },
            ),
          ),
      ],
    );
  }

  void _navigateToDetail(Recipe recipe, Texts texts) async {
    final isFavorite = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail(
          recipe: recipe,
          texts: texts,
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
