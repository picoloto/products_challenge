// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductsDetailsStore on ProductsDetailsStoreBase, Store {
  late final _$stateAtom =
      Atom(name: 'ProductsDetailsStoreBase.state', context: context);

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

  late final _$ProductsDetailsStoreBaseActionController =
      ActionController(name: 'ProductsDetailsStoreBase', context: context);

  @override
  void _loadState() {
    final _$actionInfo = _$ProductsDetailsStoreBaseActionController.startAction(
        name: 'ProductsDetailsStoreBase._loadState');
    try {
      return super._loadState();
    } finally {
      _$ProductsDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _successState(Product product) {
    final _$actionInfo = _$ProductsDetailsStoreBaseActionController.startAction(
        name: 'ProductsDetailsStoreBase._successState');
    try {
      return super._successState(product);
    } finally {
      _$ProductsDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _errorState(Exception e) {
    final _$actionInfo = _$ProductsDetailsStoreBaseActionController.startAction(
        name: 'ProductsDetailsStoreBase._errorState');
    try {
      return super._errorState(e);
    } finally {
      _$ProductsDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
