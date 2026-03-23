import 'package:local_auth/local_auth.dart';

class AuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      bool canCheck = await auth.canCheckBiometrics;

      if (!canCheck) return false;

      return await auth.authenticate(
        localizedReason: 'Authenticate to access the app',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}