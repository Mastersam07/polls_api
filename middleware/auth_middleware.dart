import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

const _secretKey = 'your_secret_key'; // TODO(mastersam07): Replace with a secure key

Middleware authMiddleware() {
  return (handler) {
    return (context) async {
      final authHeader = context.request.headers['Authorization'];
      if (authHeader == null || !authHeader.startsWith('Bearer ')) {
        return Response.json(
          body: {'error': 'Unauthorized'},
          statusCode: 401,
        );
      }

      final token = authHeader.split(' ')[1];
      try {
        final jwt = JWT.verify(token, SecretKey(_secretKey));
        return handler(context.provide(() => jwt.payload));
      } catch (e) {
        return Response.json(
          body: {'error': 'Invalid token'},
          statusCode: 401,
        );
      }
    };
  };
}
