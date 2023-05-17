import 'package:jwt_decode/jwt_decode.dart';

abstract class JwtUtils {
  static bool isTokenExpired({required String token}) {
    return Jwt.isExpired(token);
  }

  static String getEmailFromToken({required String token}) {
    final parsedToken = Jwt.parseJwt(token);
    return parsedToken['email'] as String;
  }

  static String getNameFromUserToken({required String token}) {
    final parsedToken = Jwt.parseJwt(token);
    return parsedToken['given_name'] as String;
  }

  static String getSurnameFromUserToken({required String token}) {
    final parsedToken = Jwt.parseJwt(token);
    return parsedToken['family_name'] as String;
  }
}
