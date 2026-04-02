import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_util.dart';

/// Matches role checks used elsewhere (e.g. edit defect flow).
bool isDirectorRole() {
  return valueOrDefault<String>(
        functions.jsonToStringCopy(
          getJsonField(FFAppState().account, r'''$.role'''),
        ),
        '-',
      ) ==
      '\"director\"';
}
