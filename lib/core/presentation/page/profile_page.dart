import 'package:flutter/material.dart';
import '../../../features/internationalization/generated/translations.dart';
import '../../../features/internationalization/presentation/widgets/language_picker.dart';
import '../widgets/main_navigation.dart';
import '../widgets/logout_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          const LanguagePicker(),
          const LogoutButton(),
        ],
      ),
      body: Center(child: Text(translations.profilePage)),
      bottomNavigationBar: const MainNavigation(),
    );
  }
}
