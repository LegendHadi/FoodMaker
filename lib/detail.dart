import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'models/recipe.dart';
import 'shared.dart';

class Detail extends StatefulWidget {
  const Detail({
    required this.recipe,
    Key? key,
  }) : super(key: key);

  final Recipe recipe;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.recipe.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, _isFavorite);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              icon: Icon(
                _isFavorite ? Icons.favorite_rounded : Icons.favorite_border,
                color: _isFavorite ? Colors.red : Colors.black,
              ),
            ),
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation1(widget.recipe.title),
                  buildTextSubTitleVariation1(widget.recipe.description),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 310,
              padding: const EdgeInsets.only(left: 16),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildTextTitleVariation2('Nutritions', false),
                      const SizedBox(
                        height: 16,
                      ),
                      buildNutrition(
                          widget.recipe.nutrition.calorie, 'Calories', 'Kcal'),
                      const SizedBox(
                        height: 16,
                      ),
                      buildNutrition(
                          widget.recipe.nutrition.carbo, 'Carbo', 'g'),
                      const SizedBox(
                        height: 16,
                      ),
                      buildNutrition(
                          widget.recipe.nutrition.protein, 'Protein', 'g'),
                    ],
                  ),
                  Positioned(
                    right: -80,
                    child: Hero(
                      tag: widget.recipe.media.image,
                      child: Container(
                        height: 310,
                        width: 310,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(widget.recipe.media.image),
                          fit: BoxFit.fitHeight,
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation2('Ingredients', false),
                  ...widget.recipe.ingredients
                      .map((ingredient) => buildTextSubTitleVariation1(
                          '${ingredient.amount.toString().replaceAll(regexToRemoveZeroDecimal, '')} ${ingredient.unit ?? ''} ${ingredient.title}'))
                      .toList(),
                  const SizedBox(
                    height: 16,
                  ),
                  buildTextTitleVariation2('Recipe preparation', false),
                  ...widget.recipe.instructions.map(
                    (instruction) => buildTextSubTitleVariation1(instruction),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        icon: const Icon(
          Icons.play_circle_fill,
          size: 32,
          color: Colors.white,
        ),
        label: const Text(
          'Watch video',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildNutrition(double value, String title, String subtitle) {
    return Container(
      height: 60,
      width: 150,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        boxShadow: [kBoxShadow],
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [kBoxShadow],
            ),
            child: Center(
              child: Text(
                value.toString().replaceAll(regexToRemoveZeroDecimal, ''),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
