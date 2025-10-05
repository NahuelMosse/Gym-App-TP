// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'translations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class TranslationsEs extends Translations {
  TranslationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Gym App';

  @override
  String get signInToContinue => 'Inicia sesión para continuar';

  @override
  String get email => 'Correo electrónico';

  @override
  String get emailHint => 'tu@email.com';

  @override
  String get password => 'Contraseña';

  @override
  String get passwordHint => 'Tu contraseña';

  @override
  String get signIn => 'Iniciar Sesión';

  @override
  String get signUp => 'Registrarse';

  @override
  String get signOut => 'Cerrar Sesión';

  @override
  String get dontHaveAccount => '¿No tienes cuenta?';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get welcomeToGymApp => '¡Bienvenido a Gym App!';

  @override
  String get mainContentHere => 'Aquí irá el contenido principal de tu app';

  @override
  String get backToLogin => 'Volver al Login';

  @override
  String get homeTitle => 'Inicio';

  @override
  String get loading => 'Cargando...';

  @override
  String get verifyingAuth => 'Verificando autenticación...';

  @override
  String get changeLanguage => 'Cambiar Idioma';

  @override
  String languageChangedTo(String language) {
    return 'Idioma cambiado a $language';
  }

  @override
  String get languageLoadFailed =>
      'Error al cargar la preferencia de idioma guardada';

  @override
  String get languageSaveFailed => 'Error al guardar la preferencia de idioma';

  @override
  String get pleaseEnterEmail => 'Por favor ingresa tu email';

  @override
  String get pleaseEnterValidEmail => 'Por favor ingresa un email válido';

  @override
  String get pleaseEnterPassword => 'Por favor ingresa tu contraseña';

  @override
  String get passwordMinLength =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get connectionError => 'Error de conexión. Verifica tu internet.';

  @override
  String get incorrectCredentials => 'Email o contraseña incorrectos';

  @override
  String get sessionExpired => 'Sesión expirada. Inicia sesión nuevamente';

  @override
  String get noPermission => 'No tienes permisos para realizar esta acción';

  @override
  String get serverError => 'Error del servidor. Intenta más tarde.';

  @override
  String get unexpectedError => 'Error inesperado. Intenta nuevamente.';
}
