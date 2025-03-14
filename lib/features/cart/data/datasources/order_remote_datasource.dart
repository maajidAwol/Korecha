import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop/core/error/exceptions.dart';
import 'package:shop/core/services/storage_service.dart';
import 'package:shop/core/usecases/usecase.dart';
import 'package:shop/features/authentication/data/models/user_model.dart';
import 'package:shop/features/authentication/domain/entities/user.dart';
import 'package:shop/features/authentication/domain/usecases/get_profile.dart';
import 'package:shop/features/cart/data/models/cod_order_request_model.dart';
import 'package:shop/features/cart/data/models/cod_order_response.dart';
import '../models/chapa_order_request_model.dart';
import '../models/chapa_order_response_model.dart';

abstract class OrderRemoteDataSource {
  /// Creates an order with Chapa payment
  /// Throws a [ServerException] for all error codes.
  Future<ChapaOrderResponse> createChapaOrder(ChapaOrderModel order);

  /// Creates an order with Cash on Delivery
  /// Throws a [ServerException] for all error codes.
  Future<CashOnDeliveryResponse> createCashOnDeliveryOrder(
      CashOnDeliveryOrder order);

  /// Gets all orders for the current user
  /// Throws a [ServerException] for all error codes.
  // Future<List<dynamic>> getUserOrders();

  /// Gets the current user's profile
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> getUserProfile();
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;
  final StorageService storageService;

  OrderRemoteDataSourceImpl({
    required this.client,
    required this.storageService,
  });

  @override
  Future<ChapaOrderResponse> createChapaOrder(ChapaOrderModel order) async {
    final token = storageService.getAccessToken();
    if (token == null) {
      throw ServerException('Authentication token not found');
    }

    final response = await client.post(
      Uri.parse(
          'https://api.korecha.com.et/api/flutter/chapa/verify-and-create-order'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(order),
    );

    if (response.statusCode == 201) {
      return ChapaOrderResponse.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(
          'Failed to create order with Chapa: ${response.body}');
    }
  }

  @override
  Future<CashOnDeliveryResponse> createCashOnDeliveryOrder(
      CashOnDeliveryOrder order) async {
    final token = storageService.getAccessToken();
    if (token == null) {
      throw ServerException('Authentication token not found');
    }

    final response = await client.post(
      Uri.parse('https://api.korecha.com.et/api/checkout/order'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(order),
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return CashOnDeliveryResponse.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(
          'Failed to create order with Cash on Delivery: ${response.body}');
    }
  }

  // @override
  // Future<List<dynamic>> getUserOrders() async {
  //   final token = storageService.getAccessToken();
  //   // final user = storageService.getUser();
  //      final user = await getUserProfile();

  //   if (token == null) {
  //     throw ServerException('Authentication token not found');
  //   }

  //   if ( user.id == null) {
  //     throw ServerException('User ID not found');
  //   }

  //   final response = await client.get(
  //     Uri.parse('https://api.korecha.com.et/api/orders/user/${user.id}'),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final jsonResponse = jsonDecode(response.body);
  //     if (jsonResponse is List) {
  //       return jsonResponse;
  //     } else if (jsonResponse is Map && jsonResponse.containsKey('data')) {
  //       final data = jsonResponse['data'];
  //       if (data is List) {
  //         return data;
  //       }
  //     }
  //     return [];
  //   } else {
  //     throw ServerException('Failed to get user orders: ${response.body}');
  //   }
  // }
  //
  @override
  Future<UserModel> getUserProfile() async {
    final token = storageService.getAccessToken();

    final response = await client.get(
      Uri.parse('https://api.korecha.com.et/api/auth/me'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      final error = json.decode(response.body);
      throw ValidationException(error['error'] ?? 'Failed to get user profile');
    }
    return UserModel.fromJson(json.decode(response.body));
  }
}
