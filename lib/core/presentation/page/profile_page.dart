import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  void refreshData() {
    // lógica para recargar la data
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Page'));
  }
}
