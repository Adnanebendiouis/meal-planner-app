import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Meal.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final Function() onDeleteMeal;
  final Icon cardIcon;

  const MealCard({
    super.key,
    required this.meal,
    required this.onDeleteMeal,
    required this.cardIcon,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (meal.imgPath.isNotEmpty)
            meal.imgPath.startsWith('http')
                ? Image.network(
                    meal.imgPath,
                    height: screenHeight * 0.12,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => SizedBox(
                      height: screenHeight * 0.12,
                      child: const Icon(Icons.broken_image, size: 40),
                    ),
                  )
                : Image.asset(
                    meal.imgPath,
                    height: screenHeight * 0.12,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                meal.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.visibility),
                iconSize: 20,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    "IngredientsOfAMealScreen",
                    arguments: meal,
                  );
                },
              ),
              IconButton(
                icon: cardIcon,
                iconSize: 20,
                onPressed: onDeleteMeal,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
