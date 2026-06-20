import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/resident.dart';
import '../../domain/repositories/resident_repository.dart';

/// View a single resident's details.
class ResidentDetailPage extends StatefulWidget {
  final String id;

  const ResidentDetailPage({super.key, required this.id});

  @override
  State<ResidentDetailPage> createState() => _ResidentDetailPageState();
}

class _ResidentDetailPageState extends State<ResidentDetailPage> {
  final ResidentRepository _repository =
      GetIt.instance<ResidentRepository>();
  Resident? _resident;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final resident = await _repository.getById(widget.id);
    if (!mounted) return;
    setState(() {
      _resident = resident;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_resident?.name ?? 'Resident'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _resident == null
              ? const Center(child: Text('Resident not found'))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow('Name', _resident!.name),
                      _infoRow('Phone', _resident!.phoneNumber),
                      _infoRow('Email', _resident!.email),
                      _infoRow('Address', _resident!.address ?? '-'),
                      _infoRow('Status', _resident!.status.name),
                      _infoRow(
                        'Created',
                        _resident!.createdAt.toIso8601String(),
                      ),
                      _infoRow(
                        'Updated',
                        _resident!.updatedAt.toIso8601String(),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
