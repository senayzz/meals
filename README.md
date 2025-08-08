# 📱 Meals App

A simple Flutter app for browsing and filtering meals. Built for learning purposes and practicing key Flutter concepts such as routing, state management, and UI building.

---

## 🚀 Features

- 🍽 Browse meals by category
- ✅ Filter meals based on dietary preferences:
  - Gluten-free
  - Lactose-free
  - Vegetarian
  - Vegan
- ⭐ Mark/unmark meals as favorites
- 🧭 Navigate between tabs (Categories & Favorites)
- 🛠 Custom drawer with filter navigation
- 🧪 State management via `setState()`

---

## 🖼 Screens

- **Categories Screen**: Browse meal categories.
- **Meals Screen**: View meals in a selected category.
- **Meal Detail Screen**: View details of a meal and mark as favorite.
- **Favorites Screen**: Shows all meals you've favorited.
- **Filters Screen**: Set dietary preferences using toggle switches.

---

## 📂 Project Structure
lib/
│
├── data/
│   └── dummy_data.dart       # Sample meal and category data
│
├── models/
│   ├── category.dart         # Category model
│   └── meal.dart             # Meal model
│
├── screens/
│   ├── categories_view.dart
│   ├── meals_view.dart
│   ├── meal_detail_view.dart
│   ├── favorites_view.dart
│   └── filters_view.dart
│
├── widgets/
│   ├── category_grid_item.dart
│   ├── meal_item.dart
│   └── main_drawer.dart
│
└── main.dart                 # App entry point

---

---

## 👨‍💻 Getting Started

### 1. **Clone the repo:**

```bash
git clone https://github.com/senayzz/meals.git
```
### 2. **Install dependencies:**
```bash
flutter pub get
```
### 3. **Run the app:**
```bash
flutter run
```
---

## 💡 Tech Stack

- **Flutter** (with `MaterialApp`)
- Stateful widgets and `setState()`
- Navigator API (`push`, `pop`, `pushReplacement`)
- Custom widget composition
- Dart enums & collections

---

