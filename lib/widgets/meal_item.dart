import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      //bunu yapmazsak stack ignoreluyor shape kısmını o yüzden clipliyoruz.
      //Card’ın köşe şeklinin içeriğe de uygulanmasını sağlar.
      //Özellikle Stack + Image kullanımında, köşe taşmalarını engellemek için şarttır.
      clipBehavior: Clip.hardEdge,
      //3 boyutlu hissiyat veriyor.
      //elevation, Flutter’da bir widget’ın yüksekliğini temsil eder.
      //Bu yükseklik, aslında bir gölge (shadow) derinliğidir.
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        //Stack, aynı alanın içine birden fazla öğeyi üst üste koymak için kullanılır.
        //Arka plan resmi, üzerine yazı, onun da üzerine buton eklemek gibi senaryolarda idealdir.
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                //Görseli 200 px yüksekliğe ve ekran genişliğine göre tam genişliğe sabitler.
                //fit: BoxFit.cover sayesinde görsel tam alanı kaplar, ama taşma durumunda kenarları kırpılabilir.
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    Text(
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      //Uzun metinler otomatik olarak alt satıra geçebilir.Yani kelime kesilmeden alt satıra sarkabilir.
                      softWrap: true,
                      //Eğer metin 2 satıra sığmazsa, sonuna ... eklenir.
                      overflow: TextOverflow.ellipsis, // Very long text ...
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //label : meal.duration.toString() şeklinde de yazılabilir.
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(icon: Icons.work, label: complexityText),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
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
