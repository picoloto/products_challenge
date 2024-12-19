// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductStore on ProductStoreBase, Store {
  late final _$stateAtom =
      Atom(name: 'ProductStoreBase.state', context: context);

  @override
  ProductState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ProductState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$ProductStoreBaseActionController =
      ActionController(name: 'ProductStoreBase', context: context);

  @override
  void _loadState() {
    final _$actionInfo = _$ProductStoreBaseActionController.startAction(
        name: 'ProductStoreBase._loadState');
    try {
      return super._loadState();
    } finally {
      _$ProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _successState(List<Product> products) {
    final _$actionInfo = _$ProductStoreBaseActionController.startAction(
        name: 'ProductStoreBase._successState');
    try {
      return super._successState(products);
    } finally {
      _$ProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _errorState(Exception e) {
    final _$actionInfo = _$ProductStoreBaseActionController.startAction(
        name: 'ProductStoreBase._errorState');
    try {
      return super._errorState(e);
    } finally {
      _$ProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
