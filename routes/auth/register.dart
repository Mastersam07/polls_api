import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import '../../core/utils.dart';
import '../../data/repositories/auth_repository.dart';

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

  final hashedPassword = hashPassword(password);
  repository.registerUser(username, hashedPassword);

  return Response.json(body: {'message': 'User registered successfully'});
}
