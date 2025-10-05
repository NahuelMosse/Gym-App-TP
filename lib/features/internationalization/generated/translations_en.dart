// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'translations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class TranslationsEn extends Translations {
  TranslationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Gym App';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'your@email.com';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Your password';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signOut => 'Sign Out';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get forgotPassword => 'Forgot your password?';

  @override
  String get welcomeToGymApp => 'Welcome to Gym App!';

  @override
  String get mainContentHere => 'Here will be the main content of your app';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get homeTitle => 'Home';

  @override
  String get loading => 'Loading...';

  @override
  String get verifyingAuth => 'Verifying authentication...';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String languageChangedTo(String language) {
    return 'Language changed to $language';
  }

  @override
  String get languageLoadFailed => 'Failed to load saved language preference';

  @override
  String get languageSaveFailed => 'Failed to save language preference';

  @override
  String get pleaseEnterEmail => 'Please enter your email';

  @override
  String get pleaseEnterValidEmail => 'Please enter a valid email';

  @override
  String get pleaseEnterPassword => 'Please enter your password';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get connectionError => 'Connection error. Check your internet.';

  @override
  String get incorrectCredentials => 'Incorrect email or password';

  @override
  String get sessionExpired => 'Session expired. Please sign in again';

  @override
  String get noPermission =>
      'You do not have permission to perform this action';

  @override
  String get serverError => 'Server error. Please try again later.';

  @override
  String get unexpectedError => 'Unexpected error. Please try again.';
}
