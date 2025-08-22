//giriş yaptığımızda karşımıza çıkaca grid kısmı
import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals_view.dart';
import 'package:meals/widgets/category_grid_item.dart';

//Bu bir screen olduğu için screen olarak adlandırıyoruz.
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.avaliableMeals});

  // final void Function(Meal meal) onToggleFavorite;
  final List<Meal> avaliableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  //Seçilen kategoriyi meals sayfasında göstermek için yazacağımız bir fonksiyon
  void _selectCategory(BuildContext context, Category category) {
    //Seçilen kategoriye (category.id) ait olan tüm yemekleri filteredMeals listesine ekle.
    final filteredMeals =
        widget.avaliableMeals
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
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      builder:
          (context, child) => SlideTransition(
            position: _animationController.drive(
              Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          ),
    );
  }
}
