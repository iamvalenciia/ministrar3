// google_sign_in.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleProvider {
  static GoogleSignIn? _googleSignIn;

  static Future<GoogleSignIn> getGoogleSignIn() async {
    if (_googleSignIn == null) {
      await dotenv.load();
      // Release in the play store
      _googleSignIn = GoogleSignIn(
        clientId: dotenv.env['IOS_CLIENT_ID'],
        serverClientId: dotenv.env['WEB_CLIENT_ID'],
      );

      // // Test in the laptop
      // _googleSignIn = GoogleSignIn(
      //   clientId: dotenv.env['IOS_CLIENT_ID'],
      //   serverClientId: dotenv.env['WEB_CLIENT_ID'],
      // );
    }

    return _googleSignIn!;
  }
}
