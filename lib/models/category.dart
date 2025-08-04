import 'package:flutter/material.dart';

//widget değil sadece nesne için bir taslak.
// kategori nasıl yapılandırılmalı.

class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });

  final String id;
  final String title;
  final Color color;
}
