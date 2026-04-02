import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'shkala_model.dart';
export 'shkala_model.dart';

class ShkalaWidget extends StatefulWidget {
  const ShkalaWidget({
    super.key,
    required this.data,
    required this.index,
    required this.old,
  });

  final dynamic data;
  final int? index;
  final bool? old;

  @override
  State<ShkalaWidget> createState() => _ShkalaWidgetState();
}

class _ShkalaWidgetState extends State<ShkalaWidget> {
  late ShkalaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShkalaModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
              Container(
                width: MediaQuery.sizeOf(context).width * 0.83,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getJsonField(
                        widget.data,
                        r'''$.data.title''',
                      ).toString(),
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SFProText',
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    if (functions.jsonToStringCopy(getJsonField(
                          widget.data,
                          r'''$.data.description''',
                        )) !=
                        '\"\"')
                      Text(
                        getJsonField(
                          widget.data,
                          r'''$.data.description''',
                        ).toString(),
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'SFProText',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Slider(
                    activeColor: FlutterFlowTheme.of(context).primary,
                    inactiveColor: FlutterFlowTheme.of(context).alternate,
                    min: 0.0,
                    max: 10.0,
                    value: _model.sliderValue ??= getJsonField(
                              widget.data,
                              r'''$.result.response''',
                            ) ==
                            null
                        ? 0.0
                        : getJsonField(
                            widget.data,
                            r'''$.result.response''',
                          ),
                    label: _model.sliderValue?.toStringAsFixed(0),
                    divisions: 10,
                    onChanged: (newValue) async {
                      newValue = double.parse(newValue.toStringAsFixed(0));
                      safeSetState(() => _model.sliderValue = newValue);
                      FFAppState().updateFormresult1AtIndex(
                        widget.index!,
                        (e) => e
                          ..updateResult(
                            (e) => e
                              ..response = functions
                                  .doubletoint(_model.sliderValue!)
                                  .toString(),
                          ),
                      );
                      FFAppState().update(() {});
                    },
                  ),
                ],
              ),
            ].divide(SizedBox(height: 10.0)),
          ),
        ),
      ),
    );
  }
}
