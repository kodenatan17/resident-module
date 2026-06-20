import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/resident.dart';
import '../../domain/repositories/resident_repository.dart';

/// List all residents.
class ResidentListPage extends StatefulWidget {
  const ResidentListPage({super.key});

  @override
  State<ResidentListPage> createState() => _ResidentListPageState();
}

class _ResidentListPageState extends State<ResidentListPage> {
  final ResidentRepository _repository =
      GetIt.instance<ResidentRepository>();
  List<Resident> _residents = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await _repository.getAll();
    if (!mounted) return;
    setState(() {
      _residents = list;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Residents'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/resident/create'),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _residents.isEmpty
              ? const Center(child: Text('No residents yet'))
              : ListView.builder(
                  itemCount: _residents.length,
                  itemBuilder: (context, index) {
                    final resident = _residents[index];
                    return ListTile(
                      title: Text(resident.name),
                      subtitle: Text(resident.phoneNumber),
                      trailing: Chip(
                        label: Text(resident.status.name),
                      ),
                      onTap: () =>
                          context.go('/resident/${resident.id}'),
                    );
                  },
                ),
    );
  }
}
