import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'count_component_model.dart';
export 'count_component_model.dart';

class CountComponentWidget extends StatefulWidget {
  const CountComponentWidget({
    super.key,
    required this.ref,
    required this.price,
    required this.amourt,
  });

  final DocumentReference? ref;
  final double? price;
  final int? amourt;

  @override
  State<CountComponentWidget> createState() => _CountComponentWidgetState();
}

class _CountComponentWidgetState extends State<CountComponentWidget> {
  late CountComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CountComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(8.0),
        shape: BoxShape.rectangle,
      ),
      child: FlutterFlowCountController(
        decrementIconBuilder: (enabled) => Icon(
          Icons.remove_rounded,
          color: enabled
              ? FlutterFlowTheme.of(context).secondaryText
              : FlutterFlowTheme.of(context).alternate,
          size: 24.0,
        ),
        incrementIconBuilder: (enabled) => Icon(
          Icons.add_rounded,
          color: enabled
              ? FlutterFlowTheme.of(context).primary
              : FlutterFlowTheme.of(context).alternate,
          size: 24.0,
        ),
        countBuilder: (count) => Text(
          count.toString(),
          style: FlutterFlowTheme.of(context).titleLarge.override(
                fontFamily: 'Inter',
                letterSpacing: 0.0,
              ),
        ),
        count: _model.countControllerValue ??= widget.amourt!,
        updateCount: (count) async {
          safeSetState(() => _model.countControllerValue = count);
          logFirebaseEvent('COUNT_COMPONENT_CountController_8zx3m1yx');
          logFirebaseEvent('CountController_backend_call');

          await widget.ref!.update(createShoppingCartRecordData(
            subtotal: functions.priceAmount(
                widget.price, _model.countControllerValue),
            amount: _model.countControllerValue,
          ));
        },
        stepSize: 1,
        minimum: 1,
        contentPadding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
      ),
    );
  }
}
