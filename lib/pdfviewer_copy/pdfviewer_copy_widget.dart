import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pdfviewer_copy_model.dart';
export 'pdfviewer_copy_model.dart';

class PdfviewerCopyWidget extends StatefulWidget {
  const PdfviewerCopyWidget({
    super.key,
    required this.title,
    this.id,
  });

  final String? title;
  final int? id;

  static String routeName = 'pdfviewerCopy';
  static String routePath = '/pdfviewerCopy';

  @override
  State<PdfviewerCopyWidget> createState() => _PdfviewerCopyWidgetState();
}

class _PdfviewerCopyWidgetState extends State<PdfviewerCopyWidget> {
  late PdfviewerCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PdfviewerCopyModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiCallResponse>(
      future: GetServiceActByIDCopyCall.call(
        access: currentAuthenticationToken,
        id: widget!.id,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final pdfviewerCopyGetServiceActByIDCopyResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    child: custom_widgets.PdfViewerAndDownloaderWidget(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      apiUrl:
                          'https://magnum.etry.kz/api/v1/request/service-act/${widget!.id?.toString()}/pdf',
                      fileName: widget!.title!,
                      accessToken: currentAuthenticationToken!,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
