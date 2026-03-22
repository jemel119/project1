import 'package:local_auth/local_auth.dart';

class AuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      bool canCheck = await auth.canCheckBiometrics;

      if (!canCheck) return false;

      bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to access the app',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );

      return didAuthenticate;
    } catch (e) {
      return false;
    }
  }
}