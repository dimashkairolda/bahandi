import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'get_equipment_model.dart';
export 'get_equipment_model.dart';

class GetEquipmentWidget extends StatefulWidget {
  const GetEquipmentWidget({
    super.key,
    required this.json,
  });

  final dynamic json;

  @override
  State<GetEquipmentWidget> createState() => _GetEquipmentWidgetState();
}

class _GetEquipmentWidgetState extends State<GetEquipmentWidget> {
  late GetEquipmentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GetEquipmentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              child: Container(
                width: 50.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Выберите из списка',
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'SFProText',
                          fontSize: 20.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 10.0, 15.0, 0.0),
              child: FlutterFlowCheckboxGroup(
                options: (getJsonField(
                  widget.json,
                  r'''$[:].title''',
                  true,
                ) as List?)!
                    .map<String>((e) => e.toString())
                    .toList()
                    .cast<String>()
                    .toList(),
                onChanged: (val) async {
                  safeSetState(() => _model.checkboxGroupValues = val);
                  FFAppState().CreateDefectEquip = GetAreaStruct(
                    id: getJsonField(
                      widget.json,
                      r'''$[:].id''',
                    ),
                    title: getJsonField(
                      widget.json,
                      r'''$[:].title''',
                    ).toString(),
                  );
                  safeSetState(() {});
                },
                controller: _model.checkboxGroupValueController ??=
                    FormFieldController<List<String>>(
                  [],
                ),
                activeColor: FlutterFlowTheme.of(context).primary,
                checkColor: FlutterFlowTheme.of(context).info,
                checkboxBorderColor: FlutterFlowTheme.of(context).secondaryText,
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SFProText',
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
                unselectedTextStyle:
                    FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'SFProText',
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                checkboxBorderRadius: BorderRadius.circular(4.0),
                initialized: _model.checkboxGroupValues != null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
