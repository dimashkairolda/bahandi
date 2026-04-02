import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'checkboxes_model.dart';
export 'checkboxes_model.dart';

class CheckboxesWidget extends StatefulWidget {
  const CheckboxesWidget({
    super.key,
    required this.data,
    required this.index,
    required this.old,
  });

  final dynamic data;
  final int? index;
  final bool? old;

  @override
  State<CheckboxesWidget> createState() => _CheckboxesWidgetState();
}

class _CheckboxesWidgetState extends State<CheckboxesWidget> {
  late CheckboxesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckboxesModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.99,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(11.0, 11.0, 10.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getJsonField(
                  widget.data,
                  r'''$.data.title''',
                ).toString(),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SFProText',
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Builder(
                builder: (context) {
                  final radios = (getJsonField(
                        widget.data,
                        r'''$.data.checkboxes''',
                        true,
                      )
                              ?.toList()
                              .map<CheckboxesStruct?>(
                                  CheckboxesStruct.maybeFromMap)
                              .toList() as Iterable<CheckboxesStruct?>)
                          .withoutNulls
                          .toList() ??
                      [];

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(radios.length, (radiosIndex) {
                      final radiosItem = radios[radiosIndex];
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          if (radiosItem.result.response) {
                            FFAppState().updateFormresult1AtIndex(
                              widget.index!,
                              (e) => e
                                ..updateData(
                                  (e) => e
                                    ..updateCheckboxes(
                                      (e) => e[radiosIndex]
                                        ..updateResult(
                                          (e) => e..response = false,
                                        )
                                        ..value = false,
                                    ),
                                ),
                            );
                            FFAppState().update(() {});
                          } else {
                            FFAppState().updateFormresult1AtIndex(
                              widget.index!,
                              (e) => e
                                ..updateData(
                                  (e) => e
                                    ..updateCheckboxes(
                                      (e) => e[radiosIndex]
                                        ..updateResult(
                                          (e) => e
                                            ..response = true
                                            ..comment = null
                                            ..image = null,
                                        )
                                        ..value = false,
                                    ),
                                ),
                            );
                            FFAppState().update(() {});
                          }
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          height: MediaQuery.sizeOf(context).height * 0.06,
                          decoration: BoxDecoration(
                            color: valueOrDefault<Color>(
                              radiosItem.result.response == true
                                  ? FlutterFlowTheme.of(context)
                                      .primaryBackground
                                  : FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                              FlutterFlowTheme.of(context).secondaryBackground,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              width: 0.3,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (radiosItem.result.response == true)
                                Icon(
                                  Icons.check_box,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 18.0,
                                ),
                              Text(
                                radiosItem.text,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SFProText',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ]
                                .divide(SizedBox(width: 10.0))
                                .addToStart(SizedBox(width: 15.0)),
                          ),
                        ),
                      );
                    }).divide(SizedBox(height: 5.0)),
                  );
                },
              ),
            ].divide(SizedBox(height: 10.0)),
          ),
        ),
      ),
    );
  }
}
