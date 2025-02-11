import 'dart:convert';

import 'package:equatable/equatable.dart';

class GenericItemModel<T, A, C> extends Equatable {
  final int quantity;
  final T model;
  final List<A> options;
  final List<C> attributes;
  final bool isSample;

  const GenericItemModel({
    this.quantity = 1,
    required this.model,
    this.options = const [],
    this.attributes = const [],
    this.isSample = false,
  });

  @override
  List<Object?> get props => [model, options, attributes.toString(), isSample];

  void printDifference(GenericItemModel<T, A, C> other) {
    print(other == this);

    if (quantity != other.quantity) {
      print("Difference in quantity: $quantity vs ${other.quantity}");
    }
    if (model != other.model) {
      print("Difference in model: $model vs ${other.model}");
    }
    if (options != other.options) {
      print("Difference in options: $options vs ${other.options}");
    }
    if (attributes != other.attributes) {
      print("Difference in attributes: $attributes vs ${other.attributes}");
    }
    if (isSample != other.isSample) {
      print("Difference in isSample: $isSample vs ${other.isSample}");
    }
  }

  GenericItemModel<T, A, C> increaseQuantity() => GenericItemModel(
        attributes: attributes,
        isSample: isSample,
        options: options,
        model: model,
        quantity: quantity + 1,
      );

  GenericItemModel<T, A, C> changeQuantity(int q) => GenericItemModel(
        model: model,
        isSample: isSample,
        attributes: attributes,
        quantity: q,
        options: options,
      );

  GenericItemModel<T, A, C> decreaseQuantity() => GenericItemModel(
        model: model,
        isSample: isSample,
        attributes: attributes,
        quantity: quantity - 1,
        options: options,
      );

  Map<String, dynamic> toMap({
    required Map<String, dynamic> Function(T) modelToMap,
    required Map<String, dynamic> Function(A) optionToMap,
    required Map<String, dynamic> Function(C) attributeToMap,
  }) {
    return {
      'quantity': quantity,
      'model': modelToMap(model),
      'options': options.map(optionToMap).toList(),
      'attributes': attributes.map(attributeToMap).toList(),
      'isSample': isSample,
    };
  }

  factory GenericItemModel.fromMap(
    Map<String, dynamic> map, {
    required T Function(Map<String, dynamic>) modelFromMap,
    required A Function(Map<String, dynamic>) optionFromMap,
    required C Function(Map<String, dynamic>) attributeFromMap,
  }) {
    return GenericItemModel<T, A, C>(
      quantity: map['quantity']?.toInt() ?? 1,
      model: modelFromMap(map['model']),
      options: List<A>.from(map['options']?.map((x) => optionFromMap(x)) ?? []),
      attributes: List<C>.from(
          map['attributes']?.map((x) => attributeFromMap(x)) ?? []),
      isSample: map['isSample'] ?? false,
    );
  }

  String toJson({
    required Map<String, dynamic> Function(T) modelToMap,
    required Map<String, dynamic> Function(A) optionToMap,
    required Map<String, dynamic> Function(C) attributeToMap,
  }) =>
      json.encode(toMap(
        modelToMap: modelToMap,
        optionToMap: optionToMap,
        attributeToMap: attributeToMap,
      ));

  factory GenericItemModel.fromJson(
    String source, {
    required T Function(Map<String, dynamic>) modelFromMap,
    required A Function(Map<String, dynamic>) optionFromMap,
    required C Function(Map<String, dynamic>) attributeFromMap,
  }) =>
      GenericItemModel.fromMap(
        json.decode(source),
        modelFromMap: modelFromMap,
        optionFromMap: optionFromMap,
        attributeFromMap: attributeFromMap,
      );
}
