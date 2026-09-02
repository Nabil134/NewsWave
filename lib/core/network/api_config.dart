import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig{
  ApiConfig._();
  static String get apiKey{
    return dotenv.env["NEWS_API_KEY"]??"";
  }
}