import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../../core/utils.dart';
import '../../data/repositories/auth_repository.dart';

const _secretKey = 'your_secret_key'; // TODO(mastersam07): Replace with a secure key

Future<Response> onRequest(RequestContext context) async {
  final repository = context.read<AuthRepository>();

  if (context.request.method != HttpMethod.post) {
    return Response.json(body: {'error': 'Method not allowed'}, statusCode: 405);
  }

  final body = await context.request.body();
  final data = jsonDecode(body) as Map<String, dynamic>;

  final username = data['username'] as String?;
  final password = data['password'] as String?;

  if (username == null || password == null) {
    return Response.json(body: {'error': 'Username and password are required'}, statusCode: 400);
  }

  final user = repository.getUserByUsername(username);
  if (user == null) {
    return Response.json(body: {'error': 'Invalid credentials'}, statusCode: 401);
  }

  final hashedPassword = hashPassword(password);
  if (user.passwordHash != hashedPassword) {
    return Response.json(body: {'error': 'Invalid credentials'}, statusCode: 401);
  }

  final jwt = JWT({'username': user.username});
  final token = jwt.sign(SecretKey(_secretKey));

  return Response.json(body: {'token': token});
}
