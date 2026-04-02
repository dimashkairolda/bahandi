import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

class AreaEquipmentsSelectWidget extends StatefulWidget {
  const AreaEquipmentsSelectWidget({
    super.key,
    this.areaId,
    this.parentObjectId,
    this.areaTitle,
    this.initialSelectedIds,
  });

  static String routeName = 'AreaEquipmentsSelect';
  static String routePath = '/areaEquipmentsSelect';

  final int? areaId;
  final int? parentObjectId;
  final String? areaTitle;
  final List<int>? initialSelectedIds;

  @override
  State<AreaEquipmentsSelectWidget> createState() =>
      _AreaEquipmentsSelectWidgetState();
}

class _AreaEquipmentsSelectWidgetState extends State<AreaEquipmentsSelectWidget> {
  final _searchController = TextEditingController();
  final Set<int> _selectedIds = {};
  final List<dynamic> _items = [];
  bool _loading = true;
  bool _saving = false;
  String? _error;
  int _page = 1;
  int _numPages = 1;

  @override
  void initState() {
    super.initState();
    _selectedIds.addAll(widget.initialSelectedIds ?? const <int>[]);
    _load(reset: true);
  }

  Future<void> _load({required bool reset}) async {
    setState(() {
      _loading = true;
      _error = null;
      if (reset) {
        _items.clear();
        _page = 1;
      }
    });
    try {
      final response = await GetEquipmentsForAreaSelectCall.call(
        access: currentAuthenticationToken,
        areaId: widget.areaId ?? 0,
        page: _page,
        search: _searchController.text.trim().isNotEmpty
            ? '&search=${_searchController.text.trim()}'
            : '',
      );
      final data =
          (GetEquipmentsForAreaSelectCall.data(response.jsonBody) ?? const <dynamic>[])
              .toList();
      setState(() {
        _items.addAll(data);
        _numPages = GetEquipmentsForAreaSelectCall.numPages(response.jsonBody) ?? 1;
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
      await UpdateAreaEquipmentsCall.call(
        access: currentAuthenticationToken,
        areaId: widget.areaId ?? 0,
        equipmentIds: _selectedIds.toList(),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(FFLocalizations.of(context).getVariableText(
            ruText: 'Оборудование обновлено',
            kkText: 'Жабдық жаңартылды',
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
    final theme = FlutterFlowTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondaryBackground,
        title: Text(
          widget.areaTitle?.isEmpty ?? true
              ? FFLocalizations.of(context).getVariableText(
                  ruText: 'Оборудование участка',
                  kkText: 'Учаске жабдығы',
                )
              : '${FFLocalizations.of(context).getVariableText(ruText: 'Оборудование', kkText: 'Жабдық')}: ${widget.areaTitle}',
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
              onChanged: (_) => EasyDebounce.debounce(
                '_searchController',
                const Duration(milliseconds: 400),
                () => _load(reset: true),
              ),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: FFLocalizations.of(context).getVariableText(
                  ruText: 'Поиск по названию или типу',
                  kkText: 'Атауы немесе түрі бойынша іздеу',
                ),
              ),
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(child: Text(_error!))
                    : _items.isEmpty
                        ? Center(
                            child: Text(
                              FFLocalizations.of(context).getVariableText(
                                ruText: 'Нет оборудования',
                                kkText: 'Жабдық жоқ',
                              ),
                            ),
                          )
                        : ListView(
                            children: [
                              ..._items.map((item) {
                                final id =
                                    castToType<int>(getJsonField(item, r'''$.id''')) ?? 0;
                                final title = valueOrDefault<String>(
                                  getJsonField(item, r'''$.title''')?.toString(),
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
                              }),
                              if (_page < _numPages)
                                TextButton(
                                  onPressed: () {
                                    setState(() => _page += 1);
                                    _load(reset: false);
                                  },
                                  child: Text(FFLocalizations.of(context).getVariableText(
                                    ruText: 'Показать ещё',
                                    kkText: 'Тағы көрсету',
                                  )),
                                ),
                            ],
                          ),
          ),
        ],
      ),
    );
  }
}
