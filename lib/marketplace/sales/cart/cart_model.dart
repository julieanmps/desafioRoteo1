import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/marketplace/components/costs/costs_widget.dart';
import '/marketplace/components/count_component/count_component_widget.dart';
import '/marketplace/components/menu/menu_widget.dart';
import 'cart_widget.dart' show CartWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CartModel extends FlutterFlowModel<CartWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Menu component.
  late MenuModel menuModel;
  ProductsRecord? containerPreviousSnapshot;
  // Models for CountComponent dynamic component.
  late FlutterFlowDynamicModels<CountComponentModel> countComponentModels;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  final textFieldMask = MaskTextInputFormatter(mask: '##.###.###');
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (frete)] action in IconButton widget.
  ApiCallResponse? apiResultgty;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;
  // Stores action output result for [Custom Action - valorfrete] action in RadioButton widget.
  double? valorfrete;
  // Model for Costs component.
  late CostsModel costsModel;

  @override
  void initState(BuildContext context) {
    menuModel = createModel(context, () => MenuModel());
    countComponentModels =
        FlutterFlowDynamicModels(() => CountComponentModel());
    costsModel = createModel(context, () => CostsModel());
  }

  @override
  void dispose() {
    menuModel.dispose();
    countComponentModels.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    costsModel.dispose();
  }

  /// Additional helper methods.
  String? get radioButtonValue => radioButtonValueController?.value;
}
