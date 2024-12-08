import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_tour_app/services/order_service.dart';
import 'package:gabriel_tour_app/services/jwt_service.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

// Mock dependencies
class MockJwtService extends Mock implements JwtService {}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late OrderService orderService;
  late MockJwtService mockJwtService;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockJwtService = MockJwtService();
    mockHttpClient = MockHttpClient();
    orderService = OrderService(mockJwtService);
  });

  test('fetch order details successfully', () async {
    // Arrange
    const mockToken = 'mockToken';
    const mockUserId =
        123; // Ensure this matches the return type of `getUserIdFromToken`
    const mockResponse = '''
      {
        "orderDetail": {
          "id": 1,
          "name": "Test Order",
          "startDate": "2023-12-01T00:00:00",
          "endDate": "2023-12-10T00:00:00",
          "accommodationReservations": [],
          "transportationReservations": [],
          "prices": []
        }
      }
    ''';

    when(mockJwtService.getUserIdFromToken())
        .thenAnswer((_) async => mockUserId);
    when(mockJwtService.getToken()).thenAnswer((_) async => mockToken);
    when(mockHttpClient.get(
      Uri.parse('http://localhost:9090/order/get-orderDetails?id=$mockUserId'),
      headers: anyNamed('headers'),
    )).thenAnswer((_) async => http.Response(mockResponse, 200));

    // Act
    final orderDetails = await orderService.getOrderDetailsForUser();

    // Assert
    expect(orderDetails, isNotNull);
    expect(orderDetails!.id, 1);
    expect(orderDetails.name, 'Test Order');
  });

  test('fail to fetch order details when token is null', () async {
    when(mockJwtService.getToken()).thenAnswer((_) async => null);

    final result = await orderService.getOrderDetailsForUser();

    expect(result, isNull);
  });
}
