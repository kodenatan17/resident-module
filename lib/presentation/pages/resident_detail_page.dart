import 'package:flutter/material.dart';

/// Displays details for a single resident.
class ResidentDetailPage extends StatelessWidget {
  final String id;

  const ResidentDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resident Detail')),
      body: Center(
        child: Text('Resident detail — ID: $id'),
      ),
    );
  }
}
