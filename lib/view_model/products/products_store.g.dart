// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductsStore on ProductsStoreBase, Store {
  late final _$stateAtom =
      Atom(name: 'ProductsStoreBase.state', context: context);

  @override
  ProductsState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ProductsState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$ProductsStoreBaseActionController =
      ActionController(name: 'ProductsStoreBase', context: context);

  @override
  void _setLoadingState() {
    final _$actionInfo = _$ProductsStoreBaseActionController.startAction(
        name: 'ProductsStoreBase._setLoadingState');
    try {
      return super._setLoadingState();
    } finally {
      _$ProductsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setSuccessState(List<Product> products) {
    final _$actionInfo = _$ProductsStoreBaseActionController.startAction(
        name: 'ProductsStoreBase._setSuccessState');
    try {
      return super._setSuccessState(products);
    } finally {
      _$ProductsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setErrorState(Exception e) {
    final _$actionInfo = _$ProductsStoreBaseActionController.startAction(
        name: 'ProductsStoreBase._setErrorState');
    try {
      return super._setErrorState(e);
    } finally {
      _$ProductsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setEmptyState() {
    final _$actionInfo = _$ProductsStoreBaseActionController.startAction(
        name: 'ProductsStoreBase._setEmptyState');
    try {
      return super._setEmptyState();
    } finally {
      _$ProductsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
