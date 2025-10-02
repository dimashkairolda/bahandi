import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'detailed_inspections_copy_copy2_model.dart';
export 'detailed_inspections_copy_copy2_model.dart';

class DetailedInspectionsCopyCopy2Widget extends StatefulWidget {
  const DetailedInspectionsCopyCopy2Widget({
    super.key,
    required this.asas,
  });

  final List<dynamic>? asas;

  static String routeName = 'detailedInspectionsCopyCopy2';
  static String routePath = '/detailedInspectionsCopyCopy2';

  @override
  State<DetailedInspectionsCopyCopy2Widget> createState() =>
      _DetailedInspectionsCopyCopy2WidgetState();
}

class _DetailedInspectionsCopyCopy2WidgetState
    extends State<DetailedInspectionsCopyCopy2Widget> {
  late DetailedInspectionsCopyCopy2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetailedInspectionsCopyCopy2Model());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Builder(
            builder: (context) {
              final asas = widget!.asas!.toList();

              return ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: asas.length,
                itemBuilder: (context, asasIndex) {
                  final asasItem = asas[asasIndex];
                  return SelectionArea(
                      child: Text(
                    asasItem.toString(),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.readexPro(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
