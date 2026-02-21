import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Створюємо екземпляри Firebase Auth та Google Sign In
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // 1. Реєстрація через Email та Пароль
  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // Тут можна додати власну обробку помилок (наприклад, "Слабкий пароль")
      rethrow;
    }
  }

  // 2. Вхід через Email та Пароль
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  // 3. Авторизація через Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Запускаємо вікно вибору акаунта Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Якщо користувач закрив вікно і не вибрав акаунт — перериваємо
      if (googleUser == null) return null;

      // Отримуємо дані авторизації від Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Створюємо облікові дані для Firebase на основі токенів Google
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Авторизуємо користувача у Firebase
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

  // 4. Вихід з акаунта
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // 5. Отримання токена для нашого Node.js сервера (ВАЖЛИВО!)
  // Цей JWT токен ми будемо відправляти в заголовках (Headers) кожного запиту,
  // щоб сервер знав, хто саме до нього звертається.
  Future<String?> getIdToken() async {
    final user = _auth.currentUser;
    if (user != null) {
      // Отримуємо токен (forceRefresh: false, щоб не навантажувати мережу без потреби)
      return await user.getIdToken();
    }
    return null;
  }

  // Повертає потік станів (чи користувач увійшов чи вийшов),
  // Зручно для автоматичного переключення екранів.
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
