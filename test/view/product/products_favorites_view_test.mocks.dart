// Mocks generated by Mockito 5.4.5 from annotations
// in products_challenge/test/view/product/products_favorites_view_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:mobx/mobx.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:products_challenge/model/product/product_model.dart' as _i6;
import 'package:products_challenge/service/product_local/product_local_service.dart'
    as _i2;
import 'package:products_challenge/view_model/products_local/products_local_state.dart'
    as _i3;
import 'package:products_challenge/view_model/products_local/products_local_store.dart'
    as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeProductLocalService_0 extends _i1.SmartFake
    implements _i2.ProductLocalService {
  _FakeProductLocalService_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeProductsLocalState_1 extends _i1.SmartFake
    implements _i3.ProductsLocalState {
  _FakeProductsLocalState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeReactiveContext_2 extends _i1.SmartFake
    implements _i4.ReactiveContext {
  _FakeReactiveContext_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ProductsLocalStore].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductsLocalStore extends _i1.Mock
    implements _i5.ProductsLocalStore {
  @override
  _i2.ProductLocalService get service => (super.noSuchMethod(
        Invocation.getter(#service),
        returnValue: _FakeProductLocalService_0(
          this,
          Invocation.getter(#service),
        ),
        returnValueForMissingStub: _FakeProductLocalService_0(
          this,
          Invocation.getter(#service),
        ),
      ) as _i2.ProductLocalService);

  @override
  set service(_i2.ProductLocalService? _service) => super.noSuchMethod(
        Invocation.setter(
          #service,
          _service,
        ),
        returnValueForMissingStub: null,
      );

  @override
  List<_i6.Product> get products => (super.noSuchMethod(
        Invocation.getter(#products),
        returnValue: <_i6.Product>[],
        returnValueForMissingStub: <_i6.Product>[],
      ) as List<_i6.Product>);

  @override
  set products(List<_i6.Product>? _products) => super.noSuchMethod(
        Invocation.setter(
          #products,
          _products,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.ProductsLocalState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeProductsLocalState_1(
          this,
          Invocation.getter(#state),
        ),
        returnValueForMissingStub: _FakeProductsLocalState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.ProductsLocalState);

  @override
  set state(_i3.ProductsLocalState? value) => super.noSuchMethod(
        Invocation.setter(
          #state,
          value,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.ReactiveContext get context => (super.noSuchMethod(
        Invocation.getter(#context),
        returnValue: _FakeReactiveContext_2(
          this,
          Invocation.getter(#context),
        ),
        returnValueForMissingStub: _FakeReactiveContext_2(
          this,
          Invocation.getter(#context),
        ),
      ) as _i4.ReactiveContext);

  @override
  _i7.Future<void> addProductFavorite(_i6.Product? product) =>
      (super.noSuchMethod(
        Invocation.method(
          #addProductFavorite,
          [product],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  _i7.Future<void> findAllFavorites() => (super.noSuchMethod(
        Invocation.method(
          #findAllFavorites,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  bool isFavorite(_i6.Product? product) => (super.noSuchMethod(
        Invocation.method(
          #isFavorite,
          [product],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
}
