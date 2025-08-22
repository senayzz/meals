//giriş yaptığımızda karşımıza çıkaca grid kısmı
import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals_view.dart';
import 'package:meals/widgets/category_grid_item.dart';

//Bu bir screen olduğu için screen olarak adlandırıyoruz.
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.avaliableMeals});

  // final void Function(Meal meal) onToggleFavorite;
  final List<Meal> avaliableMeals;
  //Seçilen kategoriyi meals sayfasında göstermek için yazacağımız bir fonksiyon
  //ilk defa stateless widgete fonksiyon ekledik
  //Statefullda context globally idi ancak statelessda değil tanımlalamamız lazım fonksiyona girdi olarak vermemiz lazım.
  void _selectCategory(BuildContext context, Category category) {
    //Seçilen kategoriye (category.id) ait olan tüm yemekleri filteredMeals listesine ekle.
    final filteredMeals =
        avaliableMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();
    //  Navigator.push(context, route); ikiside aynı eyi yapıyor.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(title: category.title, meals: filteredMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(24),
      //Bir satırda ne kadar element listeleneceğini söyledik.
      //horizontally 2 column
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        //colonlar arası boşluk horizontally
        crossAxisSpacing: 20,
        //vertically boşluk
        mainAxisSpacing: 20,
      ),
      children: [
        // avaliableCateries.map((category) => CategoryGridItem(category: category)).toList
        //for loopun alternatifi
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          ),
      ],
    );
  }
}
