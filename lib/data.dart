import 'package:foodager/models/food_category.dart';
import 'package:foodager/models/ingredient.dart';
import 'package:foodager/models/media.dart';
import 'package:foodager/models/nutrition.dart';
import 'models/recipe.dart';

List<Recipe> getRecipes() {
  return <Recipe>[
    Recipe(
      id: 1,
      media: Media(
        id: 11,
        image: 'assets/image/chicken-fried.png',
      ),
      title: 'Chicken Fried Rice',
      description: 'So irresistibly',
      ingredients: [
        Ingredient(
          id: 111,
          title: 'pecans, divided',
          amount: 2.0,
          unit: 'cups',
        ),
        Ingredient(
          id: 1111,
          title: 'unsalted butter, melted',
          amount: 1,
          unit: 'tablespoon',
        ),
        Ingredient(
          id: 11111,
          title: 'kosher salt, plus more',
          amount: 1 / 4,
          unit: 'teaspoon',
        ),
        Ingredient(
          id: 111111,
          title: 'fresh lemon juice',
          amount: 3,
          unit: 'tablespoons',
        ),
        Ingredient(
          id: 1111111,
          title: 'olive oil',
          amount: 2,
          unit: 'tablespoons',
        ),
        Ingredient(
          id: 11111111,
          title: 'honey',
          amount: 1 / 2,
          unit: 'teaspoon',
        ),
      ],
      nutrition: Nutrition(
        id: 111111111,
        calorie: 250,
        carbo: 35,
        protein: 6,
      ),
      instructions: [
        'Step1\n In a medium bowl, mix all the marinade ingredients with some seasoning. Chop the chicken into bite-sized pieces and toss with the marinade. Cover and chill in the fridge for 1 hr or overnight.',
        'Step2\n In a large, heavy saucepan, heat the oil. add the onion, garlic, green chilli, ginger and some seasoning. Fry on a medium heat for 10 mins or until soft.',
        'Step3\n Add the spices with the tomato puree, cook for a further 2 mins until fragrant, then add the stock and marinated chicken. Cook for 15 mins, then add any remaining marinade left in the bowl. Simmer for 5 mins, then sprinkle with the toasted almonds. Serv with rice, naan bread, chutney, coriander and lime wedges, if you like.',
      ],
      category: FoodCategory(
        title: 'Vegetable',
        id: 1,
        image: 'assets/icon/salad.png',
      ),
    ),
    Recipe(
      id: 2,
      media: Media(id: 22, image: 'assets/image/pasta-bolognese.png'),
      title: 'Pasta Bolognese',
      description: 'True italian classic with a meaty, chilli sauce',
      ingredients: [
        Ingredient(
          id: 222,
          title: 'pasta',
          amount: 1,
          unit: 'box',
        ),
        Ingredient(
          id: 2222,
          title: 'bolognese',
          amount: 1,
        ),
        Ingredient(
          id: 22222,
          title: 'potato',
          amount: 0.5,
          unit: 'kg',
        ),
        Ingredient(
          id: 222222,
          title: 'soya',
          amount: 300,
          unit: 'g',
        ),
      ],
      nutrition: Nutrition(id: 2222222, calorie: 200, carbo: 45, protein: 10),
      instructions: [
        'Step1\n fuyghhfsihojhoipojgyredyghmjuccvimlnhut',
        'Step2\n dtrdftyghujkp;,mnbfrxryghimnhftrdtgyuik',
        'Step3\n wedrttyvuno,p,mjnhgtryun;omb',
      ],
      category: FoodCategory(
        title: 'Vegetable',
        id: 1,
        image: 'assets/icon/salad.png',
      ),
    ),
    Recipe(
      id: 3,
      media: Media(id: 33, image: 'assets/image/garlic-potatoes.png'),
      title: 'Garlic Potatoes',
      description: 'Crispy Garlic Roasted Potatoes',
      ingredients: [
        Ingredient(
          id: 333,
          title: 'garlic',
          amount: 200,
          unit: 'g',
        ),
        Ingredient(
          id: 3333,
          title: 'potato',
          amount: 1,
          unit: 'kg',
        ),
        Ingredient(
          id: 33333,
          title: 'sauce ketchup',
          amount: 1,
        ),
        Ingredient(
          id: 333333,
          title: 'salt',
          amount: 50,
          unit: 'g',
        ),
      ],
      nutrition: Nutrition(
        id: 3333333,
        calorie: 150,
        carbo: 30,
        protein: 8,
      ),
      instructions: [
        'Step1\n faehfjojechifjyrtuoaewjcyhtekciujc',
        'Step2\n jafjoijncnbewjicnuhewicnnwabfeoai',
        'Step3\n jalfjiehfnadncieoijecnija',
      ],
      category: FoodCategory(
        title: 'Vegetable',
        id: 1,
        image: 'assets/icon/salad.png',
      ),
    ),
    Recipe(
      id: 4,
      media: Media(id: 44, image: 'assets/image/asparagus.png'),
      title: 'Asparagus',
      description: 'White Onion, Fennel, and watercress Salad',
      ingredients: [
        Ingredient(
          id: 444,
          title: 'asparagus',
          amount: 3,
        ),
        Ingredient(
          id: 4444,
          title: 'fish',
          amount: 1,
        ),
        Ingredient(
          id: 44444,
          title: 'tomato',
          amount: 0.5,
          unit: 'kg',
        ),
        Ingredient(
          id: 444444,
          title: 'cucumber',
          amount: 0.5,
          unit: 'kg',
        ),
        Ingredient(
          id: 4444444,
          title: 'pepper',
          amount: 50,
          unit: 'g',
        ),
      ],
      nutrition: Nutrition(
        id: 44444444,
        calorie: 190,
        carbo: 35,
        protein: 12,
      ),
      instructions: [
        'Step1\n falkjfiurihtejfnvjkfacnfhwe',
        'Step2\n lfjaofjkheiutuoiuteihj',
        'Step3\n fjaljfiajfklajfeoiajfkljawefijdfa',
      ],
      category: FoodCategory(
        title: 'Vegetable',
        id: 1,
        image: 'assets/icon/salad.png',
      ),
    ),
    Recipe(
      id: 5,
      media: Media(id: 55, image: 'assets/image/filet mignon.png'),
      title: 'Filet Mignon',
      description: 'Bacon-Wrapped Filet Mignon',
      ingredients: [
        Ingredient(
          id: 555,
          title: 'filet mignon',
          amount: 1,
          unit: 'kg',
        ),
        Ingredient(
          id: 5555,
          title: 'olive oil',
          amount: 1,
        ),
        Ingredient(
          id: 55555,
          title: 'lemon juice',
          amount: 1,
        ),
      ],
      nutrition: Nutrition(
        id: 555555,
        calorie: 250,
        carbo: 55,
        protein: 20,
      ),
      instructions: [
        'Step1\n fjasdfjijehiutiweutqoijoija',
        'Step2\n aiurwiooejakncbegwehebwaij',
        'Step3\n ;falskjoiuerouwifiuheaijf',
      ],
      category: FoodCategory(
        title: 'Vegetable',
        id: 1,
        image: 'assets/icon/salad.png',
      ),
    ),
  ];
}

List<FoodCategory> getCategories() {
  return [
    FoodCategory(
      title: 'Vegetable',
      id: 1,
      image: 'assets/icon/salad.png',
    ),
    FoodCategory(
      title: 'Rice',
      id: 2,
      image: 'assets/icon/rice.png',
    ),
    FoodCategory(
      title: 'Fruit',
      id: 3,
      image: 'assets/icon/fruit.png',
    ),
  ];
}
