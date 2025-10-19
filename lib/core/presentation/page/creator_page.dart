import 'package:flutter/material.dart';
import '../../../features/internationalization/generated/translations.dart';
import '../widgets/main_navigation.dart';

class CreatorPage extends StatefulWidget {
  const CreatorPage({super.key});

  @override
  State<CreatorPage> createState() => CreatorPageState();
}

class CreatorPageState extends State<CreatorPage> {
  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(translations.creatorPage)),
      bottomNavigationBar: const MainNavigation(),
    );
  }
}
