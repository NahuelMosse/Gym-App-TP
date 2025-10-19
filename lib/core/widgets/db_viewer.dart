import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import '../database/app_database.dart';
import '../../injection_container.dart';

class DbViewer extends StatefulWidget {
  const DbViewer({super.key});

  @override
  State<DbViewer> createState() => _DbViewerState();
}

class _DbViewerState extends State<DbViewer> {
  int _selectedTableIndex = 0;
  List<Map<String, dynamic>> _tableData = [];
  bool _loading = true;
  late AppDatabase _db;
  late List<drift.TableInfo<drift.Table, dynamic>> _tables;

  @override
  void initState() {
    super.initState();
    _db = serviceLocator<AppDatabase>();
    _tables = _db.allTables.toList();
    _loadTableData();
  }

  Future<void> _loadTableData() async {
    setState(() => _loading = true);
    try {
      final table = _tables[_selectedTableIndex];
      final results = await _db.customSelect(
        'SELECT * FROM ${table.actualTableName}',
        readsFrom: {table},
      ).get();
      
      setState(() {
        _tableData = results.map((row) => row.data).toList();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _tableData = [];
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Viewer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadTableData,
          ),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedTableIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedTableIndex = index;
              });
              _loadTableData();
            },
            labelType: NavigationRailLabelType.all,
            destinations: _tables.map((table) {
              return NavigationRailDestination(
                icon: const Icon(Icons.table_chart),
                selectedIcon: const Icon(Icons.table_chart),
                label: Text(table.actualTableName),
              );
            }).toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Row(
                    children: [
                      Icon(
                        Icons.table_chart,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _tables[_selectedTableIndex].actualTableName.toUpperCase(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      Chip(
                        label: Text('${_tableData.length} rows'),
                        avatar: const Icon(Icons.list, size: 16),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _loading
                      ? const Center(child: CircularProgressIndicator())
                      : _tableData.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.inbox,
                                    size: 64,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No data in ${_tables[_selectedTableIndex].actualTableName}',
                                    style: TextStyle(color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: _tableData.length,
                              padding: const EdgeInsets.all(16),
                              itemBuilder: (context, index) {
                                final row = _tableData[index];
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: ExpansionTile(
                                    leading: CircleAvatar(
                                      child: Text('${index + 1}'),
                                    ),
                                    title: Text(_getRowTitle(row)),
                                    subtitle: Text(_getRowSubtitle(row)),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: row.entries.map((entry) {
                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: 8),
                                              child: _buildDetailRow(
                                                entry.key,
                                                entry.value?.toString() ?? 'null',
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getRowTitle(Map<String, dynamic> row) {
    if (row.containsKey('name')) return row['name']?.toString() ?? 'No name';
    if (row.containsKey('title')) return row['title']?.toString() ?? 'No title';
    if (row.containsKey('email')) return row['email']?.toString() ?? 'No email';
    if (row.containsKey('id')) return 'ID: ${row['id']}';
    return 'Row';
  }

  String _getRowSubtitle(Map<String, dynamic> row) {
    if (row.containsKey('email') && row.containsKey('name')) {
      return row['email']?.toString() ?? '';
    }
    if (row.containsKey('description')) {
      return row['description']?.toString() ?? '';
    }
    if (row.containsKey('createdAt')) {
      return 'Created: ${row['createdAt']}';
    }
    return '${row.length} fields';
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.blueGrey,
            ),
          ),
        ),
        Expanded(
          child: SelectableText(
            value,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
