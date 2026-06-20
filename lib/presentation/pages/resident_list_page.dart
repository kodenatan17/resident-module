import 'package:flutter/material.dart';

/// Displays a list of residents.
class ResidentListPage extends StatelessWidget {
  const ResidentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Residents')),
      body: const Center(
        child: Text('Resident list — coming soon'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('resident.create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
