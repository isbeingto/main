// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required String id,
    required String title,
    String? description,
    @Default(0.0) double price,
    required String category,
    @JsonKey(name: 'image_url') String? imageUrl,
    @Default(0) int stock,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
