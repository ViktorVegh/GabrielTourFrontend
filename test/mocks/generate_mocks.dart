import 'package:mockito/annotations.dart';
import 'package:gabriel_tour_app/services/order_service.dart';
import 'package:gabriel_tour_app/services/tee_time_service.dart';
import 'package:gabriel_tour_app/services/jwt_service.dart';
import 'package:gabriel_tour_app/services/auth_service.dart';

@GenerateMocks([OrderService, TeeTimeService, JwtService, AuthService])
void main() {}
