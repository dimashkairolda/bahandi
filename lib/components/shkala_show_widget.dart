import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'shkala_show_model.dart';
export 'shkala_show_model.dart';

class ShkalaShowWidget extends StatefulWidget {
  const ShkalaShowWidget({
    super.key,
    required this.data,
    required this.index,
  });

  final dynamic data;
  final int? index;

  @override
  State<ShkalaShowWidget> createState() => _ShkalaShowWidgetState();
}

class _ShkalaShowWidgetState extends State<ShkalaShowWidget> {
  late ShkalaShowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShkalaShowModel());

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
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    valueOrDefault<String>(
                      getJsonField(
                        widget.data,
                        r'''$.result.response''',
                      )?.toString(),
                      '-',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'SFProText',
                          letterSpacing: 0.0,
                        ),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      showValueIndicator: ShowValueIndicator.always,
                    ),
                    child: Slider(
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
                      onChanged: true
                          ? null
                          : (newValue) {
                              newValue =
                                  double.parse(newValue.toStringAsFixed(0));
                              safeSetState(() => _model.sliderValue = newValue);
                            },
                    ),
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
