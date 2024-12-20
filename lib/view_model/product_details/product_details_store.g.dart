// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductDetailsStore on ProductDetailsStoreBase, Store {
  late final _$stateAtom =
      Atom(name: 'ProductDetailsStoreBase.state', context: context);

  @override
  ProductDetailsState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ProductDetailsState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$ProductDetailsStoreBaseActionController =
      ActionController(name: 'ProductDetailsStoreBase', context: context);

  @override
  void _setLoadingState() {
    final _$actionInfo = _$ProductDetailsStoreBaseActionController.startAction(
        name: 'ProductDetailsStoreBase._setLoadingState');
    try {
      return super._setLoadingState();
    } finally {
      _$ProductDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setSuccessState(Product product) {
    final _$actionInfo = _$ProductDetailsStoreBaseActionController.startAction(
        name: 'ProductDetailsStoreBase._setSuccessState');
    try {
      return super._setSuccessState(product);
    } finally {
      _$ProductDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setErrorState(Exception e) {
    final _$actionInfo = _$ProductDetailsStoreBaseActionController.startAction(
        name: 'ProductDetailsStoreBase._setErrorState');
    try {
      return super._setErrorState(e);
    } finally {
      _$ProductDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
