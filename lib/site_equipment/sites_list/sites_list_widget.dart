import 'package:flutter/material.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/site_equipment/equipment_add_onboarding/equipment_add_onboarding_widget.dart';

import '/site_equipment/site_equipment_list/site_equipment_list_widget.dart';

class SitesListWidget extends StatefulWidget {
  const SitesListWidget({super.key});

  static String routeName = 'SitesList';
  static String routePath = '/sitesList';

  @override
  State<SitesListWidget> createState() => _SitesListWidgetState();
}

class _SitesListWidgetState extends State<SitesListWidget> {
  int? _selectedIndex;
  late Future<List<Map<String, dynamic>>> _areasWithCountsFuture;

  @override
  void initState() {
    super.initState();
    _areasWithCountsFuture = _loadAreasWithEquipmentCounts();
  }

  Future<List<Map<String, dynamic>>> _loadAreasWithEquipmentCounts() async {
    final token = authManager.authenticationToken;
    final objectsRes = await GetObjectCall.call(access: token);
    final objects = GetObjectCall.objects(objectsRes.jsonBody) ?? [];
    if (objects.isEmpty) return [];
    final List<Map<String, dynamic>> allAreas = [];
    for (final obj in objects) {
      final objMap = obj as Map<String, dynamic>;
      final objectId = objMap['id'] as int?;
      final objectTitle = (objMap['title'] ?? '').toString().trim();
      if (objectId == null) continue;
      final childRes = await GetObjectChildCall.call(
        objectId: objectId,
        access: token,
      );
      final areas = GetObjectChildCall.areas(childRes.jsonBody) ?? [];
      for (final a in areas) {
        final areaMap = Map<String, dynamic>.from(a as Map<String, dynamic>);
        areaMap['object_title'] = objectTitle;
        allAreas.add(areaMap);
      }
    }
    return allAreas;
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
          title: Text(
            FFLocalizations.of(context).getVariableText(
              ruText: 'Ваши участки',
              kkText: 'Сіздің учаскелеріңіз',
            ),
            style: theme.bodyMedium.override(
              fontFamily: 'SFProText',
              fontSize: 18.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
            ),
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
          ],
          elevation: 0.0,
        ),
        body: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FFLocalizations.of(context).getVariableText(
                    ruText: 'Выберите участок, чтобы посмотреть оборудование.',
                    kkText: 'Жабдықты көру үшін учаскені таңдаңыз.',
                  ),
                  style: theme.bodySmall.override(
                    fontFamily: 'SFProText',
                    fontSize: 13.0,
                    letterSpacing: 0.0,
                    color: theme.secondaryText,
                  ),
                ),
                const SizedBox(height: 12.0),
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _areasWithCountsFuture,
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
                      final areas = snapshot.data!;

                      if (areas.isEmpty) {
                        return Center(
                          child: Text(
                            FFLocalizations.of(context).getVariableText(
                              ruText: 'Участки не найдены',
                              kkText: 'Учаскелер табылмады',
                            ),
                            style: theme.bodyMedium.override(
                              fontFamily: 'SFProText',
                              letterSpacing: 0.0,
                              color: theme.secondaryText,
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: areas.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8.0),
                        itemBuilder: (context, index) {
                          final area = areas[index];
                          final isSelected = _selectedIndex == index;
                          final equipmentsCount =
                              (area['equipments_count'] ?? 0) as int;
                          final equipmentsDraftCount =
                              (area['equipments_draft_count'] ?? 0) as int;
                          final acceptedCount =
                              equipmentsCount - equipmentsDraftCount;
                          final allAccepted = equipmentsCount > 0 &&
                              equipmentsDraftCount == 0;

                          final cardColor = isSelected
                              ? theme.secondaryBackground
                                  .withOpacity(0.7)
                                  .withAlpha(255)
                              : theme.secondaryBackground;

                          final highlightColor = allAccepted
                              ? const Color(0xFFDFF7E1)
                              : theme.primaryBackground;

                          final highlightTextColor = allAccepted
                              ? const Color(0xFF1E8E3E)
                              : theme.secondaryText;

                          final areaTitle =
                              (area['title'] ?? '').toString().trim();
                          final objectTitle =
                              (area['object_title'] ?? '').toString().trim();

                          return InkWell(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });

                              context.pushNamed(
                                SiteEquipmentListWidget.routeName,
                                queryParameters: {
                                  'areaId': serializeParam(
                                    area['id'],
                                    ParamType.int,
                                  ),
                                  'areaTitle': serializeParam(
                                    areaTitle,
                                    ParamType.String,
                                  ),
                                  'objectTitle': serializeParam(
                                    objectTitle,
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            borderRadius: BorderRadius.circular(16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(isSelected ? 0.06 : 0.03),
                                    blurRadius: 12.0,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: theme.primary.withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(999.0),
                                    ),
                                    child: Icon(
                                      Icons.location_on_rounded,
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
                                          areaTitle.isEmpty
                                              ? 'Участок #${area['id']}'
                                              : areaTitle,
                                          style: theme.bodyLarge.override(
                                            fontFamily: 'SFProText',
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        if (objectTitle.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 2.0,
                                            ),
                                            child: Text(
                                              objectTitle,
                                              style:
                                                  theme.bodyMedium.override(
                                                fontFamily: 'SFProText',
                                                fontSize: 13.0,
                                                letterSpacing: 0.0,
                                                color: theme.secondaryText,
                                              ),
                                            ),
                                          ),
                                        const SizedBox(height: 8.0),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                            vertical: 6.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: highlightColor,
                                            borderRadius:
                                                BorderRadius.circular(999.0),
                                          ),
                                          child: Text(
                                            'Оборудование: $acceptedCount/$equipmentsCount принято${equipmentsDraftCount > 0 ? ', $equipmentsDraftCount на проверке' : ''}',
                                            style: theme.bodySmall.override(
                                              fontFamily: 'SFProText',
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              color: highlightTextColor,
                                              fontWeight: allAccepted
                                                  ? FontWeight.w600
                                                  : FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
