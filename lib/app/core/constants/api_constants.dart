import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseUrl => dotenv.env['BASE_URL']!;
  static String get apiVersion => dotenv.env['API_VERSION']!;

  static const String posts = '/posts';
}
