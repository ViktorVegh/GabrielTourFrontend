// Mocks generated by Mockito 5.4.4 from annotations
// in gabriel_tour_app/test/mocks/generate_mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:gabriel_tour_app/dtos/login_request.dart' as _i11;
import 'package:gabriel_tour_app/dtos/order_dto.dart' as _i5;
import 'package:gabriel_tour_app/dtos/tee_time_dto.dart' as _i7;
import 'package:gabriel_tour_app/dtos/tee_time_request_dto.dart' as _i8;
import 'package:gabriel_tour_app/services/auth_service.dart' as _i10;
import 'package:gabriel_tour_app/services/jwt_service.dart' as _i9;
import 'package:gabriel_tour_app/services/order_service.dart' as _i2;
import 'package:gabriel_tour_app/services/tee_time_service.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [OrderService].
///
/// See the documentation for Mockito's code generation for more information.
class MockOrderService extends _i1.Mock implements _i2.OrderService {
  MockOrderService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get baseUrl => (super.noSuchMethod(
        Invocation.getter(#baseUrl),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#baseUrl),
        ),
      ) as String);

  @override
  _i4.Future<_i5.OrderDTO?> getOrderDetailsForUser() => (super.noSuchMethod(
        Invocation.method(
          #getOrderDetailsForUser,
          [],
        ),
        returnValue: _i4.Future<_i5.OrderDTO?>.value(),
      ) as _i4.Future<_i5.OrderDTO?>);
}

/// A class which mocks [TeeTimeService].
///
/// See the documentation for Mockito's code generation for more information.
class MockTeeTimeService extends _i1.Mock implements _i6.TeeTimeService {
  MockTeeTimeService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get baseUrl => (super.noSuchMethod(
        Invocation.getter(#baseUrl),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#baseUrl),
        ),
      ) as String);

  @override
  _i4.Future<List<_i7.TeeTimeDTO>?> getTeeTimesForUser() => (super.noSuchMethod(
        Invocation.method(
          #getTeeTimesForUser,
          [],
        ),
        returnValue: _i4.Future<List<_i7.TeeTimeDTO>?>.value(),
      ) as _i4.Future<List<_i7.TeeTimeDTO>?>);

  @override
  _i4.Future<_i7.TeeTimeDTO?> createTeeTime(
          _i8.TeeTimeRequestDTO? teeTimeRequest) =>
      (super.noSuchMethod(
        Invocation.method(
          #createTeeTime,
          [teeTimeRequest],
        ),
        returnValue: _i4.Future<_i7.TeeTimeDTO?>.value(),
      ) as _i4.Future<_i7.TeeTimeDTO?>);
}

/// A class which mocks [JwtService].
///
/// See the documentation for Mockito's code generation for more information.
class MockJwtService extends _i1.Mock implements _i9.JwtService {
  MockJwtService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> saveToken(String? token) => (super.noSuchMethod(
        Invocation.method(
          #saveToken,
          [token],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<String?> getToken() => (super.noSuchMethod(
        Invocation.method(
          #getToken,
          [],
        ),
        returnValue: _i4.Future<String?>.value(),
      ) as _i4.Future<String?>);

  @override
  String getRoleFromToken(String? token) => (super.noSuchMethod(
        Invocation.method(
          #getRoleFromToken,
          [token],
        ),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.method(
            #getRoleFromToken,
            [token],
          ),
        ),
      ) as String);

  @override
  _i4.Future<int?> getUserIdFromToken() => (super.noSuchMethod(
        Invocation.method(
          #getUserIdFromToken,
          [],
        ),
        returnValue: _i4.Future<int?>.value(),
      ) as _i4.Future<int?>);

  @override
  bool isTokenExpired(String? token) => (super.noSuchMethod(
        Invocation.method(
          #isTokenExpired,
          [token],
        ),
        returnValue: false,
      ) as bool);

  @override
  _i4.Future<void> clearToken() => (super.noSuchMethod(
        Invocation.method(
          #clearToken,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i1.Mock implements _i10.AuthService {
  MockAuthService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get baseUrl => (super.noSuchMethod(
        Invocation.getter(#baseUrl),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#baseUrl),
        ),
      ) as String);

  @override
  _i4.Future<String> login(_i11.LoginRequest? request) => (super.noSuchMethod(
        Invocation.method(
          #login,
          [request],
        ),
        returnValue: _i4.Future<String>.value(_i3.dummyValue<String>(
          this,
          Invocation.method(
            #login,
            [request],
          ),
        )),
      ) as _i4.Future<String>);

  @override
  _i4.Future<void> logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<String> resetPassword(String? email) => (super.noSuchMethod(
        Invocation.method(
          #resetPassword,
          [email],
        ),
        returnValue: _i4.Future<String>.value(_i3.dummyValue<String>(
          this,
          Invocation.method(
            #resetPassword,
            [email],
          ),
        )),
      ) as _i4.Future<String>);
}
