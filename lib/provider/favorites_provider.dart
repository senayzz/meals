import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

/// Riverpod, Flutter'da state yönetimi için kullanılan güçlü ve esnek bir kütüphanedir.
/// Bu dosyada, favori yemeklerin yönetimi için bir StateNotifier ve ona bağlı bir provider tanımlanmıştır.
/// Böylece uygulamanın farklı yerlerinde favori yemek listesine erişim ve güncelleme kolayca sağlanabilir.

/// FavoriteMealsNotifier sınıfı, favori yemek listesini yönetmek için StateNotifier'dan türetilmiştir.
/// StateNotifier, state yönetimini kolaylaştıran ve state değiştiğinde dinleyicilere bildirim gönderen bir yapıdır.
/// Burada state, List<Meal> tipindedir ve favori yemeklerin listesini tutar.
/// State değiştiğinde, Riverpod otomatik olarak bu değişikliği dinleyen widget'ları yeniden oluşturur.
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  /// Başlangıçta favori yemek listesi boş bir liste olarak atanır.
  FavoriteMealsNotifier() : super([]);

  /// toggleMealFavoriteStatus metodu, verilen yemeğin favori listesindeki durumunu değiştirir.
  /// Eğer yemek zaten favorilerdeyse, listeden çıkarılır.
  /// Değilse, favorilere eklenir.
  bool toggleMealFavoriteStatus(Meal meal) {
    /// state.contains(meal) ifadesi, yemeğin şu an favorilerde olup olmadığını kontrol eder.
    /// Burada Meal sınıfının eşitlik karşılaştırması id'ye göre yapılmalıdır (Meal modelinde override edilmiş olabilir).
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      /// Eğer yemek favorilerdeyse, onu listeden çıkarıyoruz.
      /// Bunu yapmak için state listesini filtreleyip, meal.id'si farklı olanları yeni listeye alıyoruz.
      /// Sonra state'i bu yeni liste olarak güncelliyoruz.
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      /// Eğer yemek favorilerde değilse, mevcut favori listesine bu yemeği ekliyoruz.
      /// Burada spread operator (...) ile mevcut liste açılır ve sonuna yeni yemek eklenir.
      /// Böylece state yeni bir liste olarak güncellenmiş olur.
      state = [...state, meal];
      return true;
    }
  }
}

/// favoriteMealsProvider, FavoriteMealsNotifier'ı sağlayan bir StateNotifierProvider'dır.
/// Bu provider, uygulamanın herhangi bir yerinde favori yemek listesini okuyup değiştirmeye olanak tanır.
/// Tip parametreleri <FavoriteMealsNotifier, List<Meal>> şu anlama gelir:
/// - FavoriteMealsNotifier: StateNotifier'ın tipi (state'i yöneten sınıf)
/// - List<Meal>: State'in tipi (yani favori yemeklerin listesi)
///
/// Kullanım örneği:
/// final favoriteMeals = ref.watch(favoriteMealsProvider); // Favori yemek listesine erişim
/// ref.read(favoriteMealsProvider.notifier).toggleMealFavoriteStatus(meal); // Favori durumunu değiştirme
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
      return FavoriteMealsNotifier();
    });
