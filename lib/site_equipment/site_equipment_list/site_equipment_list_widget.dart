import 'package:flutter/material.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_manager.dart';
import '/backend/api_requests/api_calls.dart';
import '/site_equipment/edit_equipment/edit_equipment_widget.dart';
import '/site_equipment/equipment_add_onboarding/equipment_add_onboarding_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

import '/site_equipment/add_equipment/add_equipment_widget.dart';

class SiteEquipmentListWidget extends StatefulWidget {
  const SiteEquipmentListWidget({
    super.key,
    this.areaId,
    this.areaTitle,
    this.objectTitle,
  });

  final int? areaId;
  final String? areaTitle;
  final String? objectTitle;

  static String routeName = 'SiteEquipmentList';
  static String routePath = '/siteEquipmentList';

  @override
  State<SiteEquipmentListWidget> createState() => _SiteEquipmentListWidgetState();
}

class _SiteEquipmentListWidgetState extends State<SiteEquipmentListWidget>
    with SingleTickerProviderStateMixin {
  static const _siteEquipmentFields =
      '&fields=id,title,area,category,category_code,files,img,barcode,inventory_number,dispatch_number,status,comment,type,type_info,manufacturer,manufacturer_info,model,model_info,draft_info,criticality,power,operational_date,provider';
  late Future<ApiCallResponse> _equipmentsFuture;
  bool _isReloading = false;
  late AnimationController _refreshAnimationController;

  String get _userRole => valueOrDefault<String>(
        getJsonField(
          FFAppState().account,
          r'''$.role''',
        )?.toString(),
        '',
      );

  bool get _isCashierRole {
    // В старых требованиях "кассир" соответствовал роли director.
    return _userRole == 'director' ||
        _userRole == '"director"' ||
        _userRole == 'cashier' ||
        _userRole == '"cashier"';
  }

  @override
  void initState() {
    super.initState();
    _refreshAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    final token = authManager.authenticationToken;
    _equipmentsFuture = GetEquipmentsPaginationCall.call(
      access: token,
      page: 1,
      area: widget.areaId != null ? '&area=${widget.areaId}' : '',
      fields: _siteEquipmentFields,
    );
  }

  @override
  void dispose() {
    _refreshAnimationController.dispose();
    super.dispose();
  }

  Future<void> _reloadEquipments() async {
    if (_isReloading) return;
    final token = authManager.authenticationToken;
    final future = GetEquipmentsPaginationCall.call(
      access: token,
      page: 1,
      area: widget.areaId != null ? '&area=${widget.areaId}' : '',
      fields: _siteEquipmentFields,
    );
    setState(() {
      _equipmentsFuture = future;
      _isReloading = true;
      _refreshAnimationController.repeat();
    });
    await future;
    if (mounted) {
      setState(() {
        _isReloading = false;
        _refreshAnimationController.stop();
        _refreshAnimationController.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: theme.primaryBackground,
        appBar: AppBar(
          backgroundColor: theme.secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 20.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            icon: Icon(
              Icons.chevron_left_rounded,
              color: theme.primaryText,
              size: 24.0,
            ),
            onPressed: () {
              context.safePop();
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                FFLocalizations.of(context).getVariableText(
                  ruText: 'Оборудование на участке',
                  kkText: 'Учаскедегі жабдық',
                ),
                style: theme.bodyMedium.override(
                  fontFamily: 'SFProText',
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (widget.areaTitle != null)
                Text(
                  widget.areaTitle!,
                  style: theme.bodySmall.override(
                    fontFamily: 'SFProText',
                    fontSize: 12.0,
                    letterSpacing: 0.0,
                    color: theme.secondaryText,
                  ),
                ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        const EquipmentAddOnboardingWidget(openSitesListAfter: false),
                  ),
                );
              },
              icon: Icon(
                Icons.help_outline_rounded,
                color: theme.primaryText,
                size: 24.0,
              ),
              tooltip: FFLocalizations.of(context).getVariableText(
                ruText: 'Инструкция',
                kkText: 'Нұсқаулық',
              ),
            ),
            IconButton(
              onPressed: _isReloading ? null : () async {
                await _reloadEquipments();
              },
              icon: RotationTransition(
                turns: _refreshAnimationController,
                child: Icon(
                  Icons.refresh_rounded,
                  color: _isReloading
                      ? theme.primaryText.withOpacity(0.6)
                      : theme.primaryText,
                  size: 24.0,
                ),
              ),
              tooltip: 'Обновить',
            ),
          ],
          elevation: 0.0,
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    await context.pushNamed(
                      AddEquipmentSimpleWidget.routeName,
                      queryParameters: {
                        'areaId': serializeParam(
                          widget.areaId,
                          ParamType.int,
                        ),
                        'areaTitle': serializeParam(
                          widget.areaTitle,
                          ParamType.String,
                        ),
                        'objectTitle': serializeParam(
                          widget.objectTitle,
                          ParamType.String,
                        ),
                      }.withoutNulls,
                    );
                    await _reloadEquipments();
                  },
                  text: FFLocalizations.of(context).getVariableText(
                    ruText: 'Добавить оборудование',
                    kkText: 'Жабдық қосу',
                  ),
                  icon: const Icon(
                    Icons.add_rounded,
                    size: 20.0,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 48.0,
                    color: theme.primary,
                    textStyle: theme.titleSmall.override(
                      fontFamily: 'SFProText',
                      letterSpacing: 0.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<ApiCallResponse>(
                  future: _equipmentsFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.primary,
                            ),
                          ),
                        ),
                      );
                    }

                    final response = snapshot.data!;
                    final items =
                        (GetEquipmentsPaginationCall.data(response.jsonBody) ??
                                [])
                            .toList();

                    if (items.isEmpty) {
                      return Center(
                        child: Text(
                          FFLocalizations.of(context).getVariableText(
                            ruText: 'Оборудование на участке пока отсутствует',
                            kkText: 'Учаскеде жабдық әзірге жоқ',
                          ),
                          style: theme.bodyMedium.override(
                            fontFamily: 'SFProText',
                            letterSpacing: 0.0,
                            color: theme.secondaryText,
                          ),
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: _reloadEquipments,
                      color: theme.primary,
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8.0),
                      itemBuilder: (context, index) {
                        final item = items[index] as Map<String, dynamic>;

                        final title = (item['title'] ?? '').toString();
                        final code = (item['inventory_number'] ??
                                item['dispatch_number'] ??
                                item['barcode'] ??
                                '')
                            .toString();
                        final typeInfo =
                            (item['type_info'] as Map<String, dynamic>?) ?? {};
                        final typeTitle =
                            (typeInfo['title'] ?? '').toString().trim();
                        final imgPath = item['img'];
                        final status = (item['status'] ?? '').toString();
                        final comment = (item['comment'] ?? '').toString();

                        Widget trailing;
                        if (status == 'draft') {
                          trailing = IconButton(
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: const Text('Удалить оборудование'),
                                        content: Text(
                                          'Вы уверены, что хотите удалить "$title"?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(ctx, false),
                                            child: const Text('Отмена'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(ctx, true),
                                            child: const Text('Удалить'),
                                          ),
                                        ],
                                      );
                                    },
                                  ) ??
                                  false;
                              if (!confirm) return;
                              final token = authManager.authenticationToken;
                              final deleteResponse =
                                  await ApiManager.instance.makeApiCall(
                                callName: 'DeleteEquipment',
                                apiUrl:
                                    'https://app.etry.kz/api/v1/equipment/${item['id']}',
                                callType: ApiCallType.DELETE,
                                headers: {'Authorization': 'JWT $token'},
                                params: {},
                                returnBody: true,
                                encodeBodyUtf8: true,
                                decodeUtf8: true,
                                cache: false,
                                isStreamingApi: false,
                                alwaysAllowBody: false,
                              );
                              if (deleteResponse.succeeded) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Оборудование удалено',
                                      style: theme.bodyMedium.override(
                                        fontFamily: 'SFProText',
                                        letterSpacing: 0.0,
                                        color: theme.primaryBackground,
                                      ),
                                    ),
                                    backgroundColor: theme.error,
                                  ),
                                );
                                await _reloadEquipments();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Не удалось удалить оборудование',
                                      style: theme.bodyMedium.override(
                                        fontFamily: 'SFProText',
                                        letterSpacing: 0.0,
                                        color: theme.primaryBackground,
                                      ),
                                    ),
                                    backgroundColor: theme.error,
                                  ),
                                );
                              }
                            },
                            icon: Icon(
                              Icons.delete_outline_rounded,
                              color: theme.error,
                            ),
                          );
                        } else if (status == 'draft_reject') {
                          trailing = Icon(
                            Icons.cancel_outlined,
                            color: theme.error,
                            size: 28.0,
                          );
                        } else {
                          trailing = Icon(
                            Icons.check_circle_rounded,
                            color: theme.success,
                            size: 28.0,
                          );
                        }

                        final canEdit = _isCashierRole ||
                            status == 'draft' ||
                            status == 'draft_reject';
                        return InkWell(
                          onTap: canEdit
                              ? () async {
                                  await context.pushNamed(
                                    EditEquipmentSimpleWidget.routeName,
                                    queryParameters: {
                                      'equipmentJson': serializeParam(
                                        item,
                                        ParamType.JSON,
                                      ),
                                    }.withoutNulls,
                                  );
                                  await _reloadEquipments();
                                }
                              : null,
                          borderRadius: BorderRadius.circular(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.secondaryBackground,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 8.0,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: theme.primary.withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: imgPath != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: Image.network(
                                              'https://app.etry.kz${imgPath.toString()}',
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Icon(
                                                  Icons.kitchen_rounded,
                                                  color: theme.primary,
                                                  size: 22.0,
                                                );
                                              },
                                            ),
                                          )
                                        : Icon(
                                            Icons.kitchen_rounded,
                                            color: theme.primary,
                                            size: 22.0,
                                          ),
                                  ),
                                  const SizedBox(width: 12.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.bodyMedium.override(
                                            fontFamily: 'SFProText',
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        if (code.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 2.0,
                                            ),
                                            child: Text(
                                              code,
                                              style: theme.bodySmall.override(
                                                fontFamily: 'SFProText',
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                color: theme.secondaryText,
                                              ),
                                            ),
                                          ),
                                        if (typeTitle.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 4.0,
                                            ),
                                            child: Text(
                                              typeTitle,
                                              style: theme.bodySmall.override(
                                                fontFamily: 'SFProText',
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                color: theme.primary,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        if (status == 'draft_reject' &&
                                            comment.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 4.0,
                                            ),
                                            child: Text(
                                              comment,
                                              style: theme.bodySmall.override(
                                                fontFamily: 'SFProText',
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                color: theme.error,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  trailing,
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
