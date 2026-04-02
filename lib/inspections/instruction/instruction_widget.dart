import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'instruction_model.dart';
export 'instruction_model.dart';

class InstructionWidget extends StatefulWidget {
  const InstructionWidget({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  State<InstructionWidget> createState() => _InstructionWidgetState();
}

class _InstructionWidgetState extends State<InstructionWidget> {
  late InstructionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InstructionModel());
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
                width: MediaQuery.sizeOf(context).width * 0.9,
                decoration: BoxDecoration(),
                child: Text(
                  getJsonField(
                    widget.data,
                    r'''$.data.title''',
                  ).toString(),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'SFProText',
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 0.25,
                  child: custom_widgets.Base64Media(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.25,
                    base64Data: getJsonField(
                      widget.data,
                      r'''$.data.image''',
                    ).toString(),
                    controllable: false,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.9,
                decoration: BoxDecoration(),
                child: Text(
                  getJsonField(
                    widget.data,
                    r'''$.data.description''',
                  ).toString(),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'SFProText',
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Builder(
                builder: (context) {
                  final descriptions = getJsonField(
                    widget.data,
                    r'''$.data.descriptions''',
                  ).toList();

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children:
                        List.generate(descriptions.length, (descriptionsIndex) {
                      final descriptionsItem = descriptions[descriptionsIndex];
                      return Container(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        decoration: BoxDecoration(),
                        child: Text(
                          getJsonField(
                            descriptionsItem,
                            r'''$.text''',
                          ).toString(),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'SFProText',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      );
                    }),
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
