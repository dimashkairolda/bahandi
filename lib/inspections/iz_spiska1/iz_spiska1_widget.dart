import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'iz_spiska1_model.dart';
export 'iz_spiska1_model.dart';

class IzSpiska1Widget extends StatefulWidget {
  const IzSpiska1Widget({
    super.key,
    required this.data,
    required this.index,
    required this.searchID,
    required this.equipmentId,
    required this.name,
    required this.nextIndex,
  });

  final dynamic data;
  final int? index;
  final int? searchID;
  final int? equipmentId;
  final dynamic name;
  final int? nextIndex;

  @override
  State<IzSpiska1Widget> createState() => _IzSpiska1WidgetState();
}

class _IzSpiska1WidgetState extends State<IzSpiska1Widget> {
  late IzSpiska1Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IzSpiska1Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

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
                  final radios = getJsonField(
                    widget.data,
                    r'''$.data.radios[:]''',
                  ).toList();

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
                          await actions.updateResponseByIdRadio(
                            FFAppState().checkCache,
                            widget.equipmentId!,
                            getJsonField(
                              widget.data,
                              r'''$.data.title''',
                            ).toString(),
                            getJsonField(
                              radiosItem,
                              r'''$.text''',
                            ).toString(),
                          );
                          _model.index = radiosIndex;
                          safeSetState(() {});
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          height: MediaQuery.sizeOf(context).height * 0.06,
                          decoration: BoxDecoration(
                            color: valueOrDefault<Color>(
                              _model.index == radiosIndex
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
                              if (_model.index == radiosIndex)
                                Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.02,
                                  height:
                                      MediaQuery.sizeOf(context).width * 0.02,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              Text(
                                getJsonField(
                                  radiosItem,
                                  r'''$.text''',
                                ).toString(),
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
