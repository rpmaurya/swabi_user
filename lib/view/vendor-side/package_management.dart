import 'package:flutter/material.dart';

class PackageManagementScreen extends StatefulWidget {
  const PackageManagementScreen({super.key});

  @override
  State<PackageManagementScreen> createState() =>
      _PackageManagementScreenState();
}

class _PackageManagementScreenState extends State<PackageManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Packagr Management'),
      ),
    );
  }
}
