import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const WristSync());
}

class WristSync extends StatelessWidget {
  const WristSync({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wrist Sync',
      debugShowCheckedModeBanner: false,
      defaultTransition: .cupertino,
    );
  }
}
