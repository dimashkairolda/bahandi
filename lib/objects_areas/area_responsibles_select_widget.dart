import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class AreaResponsiblesSelectWidget extends StatefulWidget {
  const AreaResponsiblesSelectWidget({
    super.key,
    this.areaId,
    this.parentObjectId,
    this.areaTitle,
    this.initialSelectedIds,
  });

  static String routeName = 'AreaResponsiblesSelect';
  static String routePath = '/areaResponsiblesSelect';

  final int? areaId;
  final int? parentObjectId;
  final String? areaTitle;
  final List<int>? initialSelectedIds;

  @override
  State<AreaResponsiblesSelectWidget> createState() =>
      _AreaResponsiblesSelectWidgetState();
}

class _AreaResponsiblesSelectWidgetState
    extends State<AreaResponsiblesSelectWidget> {
  final _searchController = TextEditingController();
  final Set<int> _selectedIds = {};
  List<dynamic> _users = [];
  bool _loading = true;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _selectedIds.addAll(widget.initialSelectedIds ?? const <int>[]);
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final response = await GetUsersShortCall.call(access: currentAuthenticationToken);
      setState(() {
        _users = (GetUsersShortCall.data(response.jsonBody) ?? const <dynamic>[]).toList();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await UpdateAreaResponsiblesCall.call(
        access: currentAuthenticationToken,
        areaId: widget.areaId ?? 0,
        responsibleIds: _selectedIds.toList(),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(FFLocalizations.of(context).getVariableText(
            ruText: 'Ответственные обновлены',
            kkText: 'Жауаптылар жаңартылды',
          )),
        ),
      );
      context.safePop();
    } catch (e) {
      setState(() => _saving = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${FFLocalizations.of(context).getVariableText(ruText: 'Ошибка', kkText: 'Қате')}: $e',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _users.where((user) {
      final fullName = valueOrDefault<String>(
        getJsonField(user, r'''$.full_name''')?.toString(),
        '',
      );
      return fullName.toLowerCase().contains(_searchController.text.toLowerCase());
    }).toList();
    final theme = FlutterFlowTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondaryBackground,
        title: Text(
          widget.areaTitle?.isEmpty ?? true
              ? FFLocalizations.of(context).getVariableText(
                  ruText: 'Ответственные участка',
                  kkText: 'Учаске жауаптылары',
                )
              : '${FFLocalizations.of(context).getVariableText(ruText: 'Ответственные', kkText: 'Жауаптылар')}: ${widget.areaTitle}',
        ),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: Text(
              FFLocalizations.of(context)
                  .getVariableText(ruText: 'Сохранить', kkText: 'Сақтау'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextFormField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: FFLocalizations.of(context).getVariableText(
                  ruText: 'Поиск по ФИО',
                  kkText: 'Аты-жөні бойынша іздеу',
                ),
              ),
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(child: Text(_error!))
                    : filtered.isEmpty
                        ? Center(
                            child: Text(
                              FFLocalizations.of(context).getVariableText(
                                ruText: 'Нет пользователей',
                                kkText: 'Пайдаланушылар жоқ',
                              ),
                            ),
                          )
                        : ListView(
                            children: filtered.map((user) {
                              final id =
                                  castToType<int>(getJsonField(user, r'''$.id''')) ?? 0;
                              final title = valueOrDefault<String>(
                                getJsonField(user, r'''$.full_name''')?.toString(),
                                '-',
                              );
                              return CheckboxListTile(
                                value: _selectedIds.contains(id),
                                onChanged: (v) {
                                  setState(() {
                                    if (v == true) {
                                      _selectedIds.add(id);
                                    } else {
                                      _selectedIds.remove(id);
                                    }
                                  });
                                },
                                title: Text(title),
                              );
                            }).toList(),
                          ),
          ),
        ],
      ),
    );
  }
}
