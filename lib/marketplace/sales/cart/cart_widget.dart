import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/marketplace/components/costs/costs_widget.dart';
import '/marketplace/components/count_component/count_component_widget.dart';
import '/marketplace/components/menu/menu_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';
export 'cart_model.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  late CartModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CartModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Cart'});
    _model.textController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.cep, ''));
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<ShoppingCartRecord>>(
      stream: queryShoppingCartRecord(
        queryBuilder: (shoppingCartRecord) => shoppingCartRecord.where(
          'hash',
          isEqualTo: FFAppState().idhash,
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 25.0,
                height: 25.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<ShoppingCartRecord> cartShoppingCartRecordList = snapshot.data!;

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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            FlutterFlowTheme.of(context).primary,
                            Color(0xFF1B5E20)
                          ],
                          stops: [0.0, 1.0],
                          begin: AlignmentDirectional(0.0, -1.0),
                          end: AlignmentDirectional(0, 1.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 24.0, 24.0, 24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      '11v20y2y' /* Shopping Cart */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentDirectional(1.0, 0.0),
                                      child: wrapWithModel(
                                        model: _model.menuModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: MenuWidget(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              FFLocalizations.of(context).getText(
                                'u0a7ya72' /* Review your items */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: Color(0xFFE0E0E0),
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 600.0,
                          constraints: BoxConstraints(
                            minWidth: 300.0,
                            maxWidth: 800.0,
                          ),
                          decoration: BoxDecoration(),
                          child: Builder(
                            builder: (context) {
                              final cart = cartShoppingCartRecordList.toList();

                              return ListView.separated(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: cart.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 12.0),
                                itemBuilder: (context, cartIndex) {
                                  final cartItem = cart[cartIndex];
                                  return StreamBuilder<ProductsRecord>(
                                    stream: ProductsRecord.getDocument(
                                        cartItem.product!)
                                      ..listen((containerProductsRecord) async {
                                        if (_model.containerPreviousSnapshot !=
                                                null &&
                                            !ProductsRecordDocumentEquality()
                                                .equals(
                                                    containerProductsRecord,
                                                    _model
                                                        .containerPreviousSnapshot)) {}
                                        _model.containerPreviousSnapshot =
                                            containerProductsRecord;
                                      }),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 25.0,
                                            height: 25.0,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }

                                      final containerProductsRecord =
                                          snapshot.data!;

                                      return Material(
                                        color: Colors.transparent,
                                        elevation: 2.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 16.0, 16.0, 16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.network(
                                                        'https://images.unsplash.com/photo-1683688684067-b87a189c7503?w=500&h=500',
                                                        width: 80.0,
                                                        height: 80.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            containerProductsRecord
                                                                .name,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                          Text(
                                                            formatNumber(
                                                              containerProductsRecord
                                                                  .price,
                                                              formatType:
                                                                  FormatType
                                                                      .custom,
                                                              currency: 'R\$ ',
                                                              format:
                                                                  '#,##0.00',
                                                              locale: 'pt_BR',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            logFirebaseEvent(
                                                                'CART_PAGE_Container_ehsj4y6e_ON_TAP');
                                                            logFirebaseEvent(
                                                                'CountComponent_backend_call');

                                                            await cartItem
                                                                .reference
                                                                .update(
                                                                    createShoppingCartRecordData(
                                                              amount: _model
                                                                  .countComponentModels
                                                                  .getValueForKey(
                                                                cartItem
                                                                    .reference
                                                                    .id,
                                                                (m) => m
                                                                    .countControllerValue,
                                                              ),
                                                              subtotal: functions
                                                                  .priceAmount(
                                                                      cartItem
                                                                          .price,
                                                                      _model
                                                                          .countComponentModels
                                                                          .getValueForKey(
                                                                        cartItem
                                                                            .reference
                                                                            .id,
                                                                        (m) => m
                                                                            .countControllerValue,
                                                                      )),
                                                            ));
                                                          },
                                                          child: wrapWithModel(
                                                            model: _model
                                                                .countComponentModels
                                                                .getModel(
                                                              cartItem
                                                                  .reference.id,
                                                              cartIndex,
                                                            ),
                                                            updateCallback: () =>
                                                                safeSetState(
                                                                    () {}),
                                                            child:
                                                                CountComponentWidget(
                                                              key: Key(
                                                                'Keyehs_${cartItem.reference.id}',
                                                              ),
                                                              ref: cartItem
                                                                  .reference,
                                                              price: cartItem
                                                                  .price,
                                                              amourt: cartItem
                                                                  .amount,
                                                            ),
                                                          ),
                                                        ),
                                                        FlutterFlowIconButton(
                                                          borderRadius: 8.0,
                                                          buttonSize: 40.0,
                                                          icon: Icon(
                                                            Icons
                                                                .delete_forever_sharp,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            size: 24.0,
                                                          ),
                                                          onPressed: () async {
                                                            logFirebaseEvent(
                                                                'CART_delete_forever_sharp_ICN_ON_TAP');
                                                            logFirebaseEvent(
                                                                'IconButton_backend_call');
                                                            await cartItem
                                                                .reference
                                                                .delete();
                                                          },
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 8.0)),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 12.0)),
                                                ),
                                              ].divide(SizedBox(height: 16.0)),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Material(
                              color: Colors.transparent,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Container(
                                width: 600.0,
                                constraints: BoxConstraints(
                                  minWidth: 300.0,
                                  maxWidth: 800.0,
                                ),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 24.0, 24.0, 24.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          '16j4v45z' /* Add your CEP  */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      Container(
                                        height: 1.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AuthUserStreamWidget(
                                            builder: (context) => Container(
                                              width: 200.0,
                                              child: TextFormField(
                                                controller:
                                                    _model.textController,
                                                focusNode:
                                                    _model.textFieldFocusNode,
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelText: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'zx1aburi' /* CEP */,
                                                  ),
                                                  labelStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0.0,
                                                          ),
                                                  hintStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0.0,
                                                          ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                keyboardType:
                                                    TextInputType.number,
                                                cursorColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                validator: _model
                                                    .textControllerValidator
                                                    .asValidator(context),
                                                inputFormatters: [
                                                  _model.textFieldMask
                                                ],
                                              ),
                                            ),
                                          ),
                                          FlutterFlowIconButton(
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            borderRadius: 8.0,
                                            buttonSize: 40.0,
                                            icon: Icon(
                                              Icons.search_outlined,
                                              color: Colors.black,
                                              size: 24.0,
                                            ),
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'CART_PAGE_search_outlined_ICN_ON_TAP');
                                              logFirebaseEvent(
                                                  'IconButton_backend_call');
                                              _model.apiResultgty =
                                                  await FreteCall.call(
                                                bodyJson: <String, dynamic>{
                                                  'from': <String, dynamic>{
                                                    'postal_code': _model
                                                        .textController.text,
                                                  },
                                                  'to': <String, dynamic>{
                                                    'postal_code':
                                                        FFAppState().postalcode,
                                                  },
                                                  'package':
                                                      FFAppState().package,
                                                },
                                              );

                                              if ((_model.apiResultgty
                                                      ?.succeeded ??
                                                  true)) {
                                                logFirebaseEvent(
                                                    'IconButton_update_app_state');
                                                FFAppState().frete = [];
                                                safeSetState(() {});
                                                while (FFAppState().loop <= 3) {
                                                  logFirebaseEvent(
                                                      'IconButton_update_app_state');
                                                  FFAppState().addToFrete(
                                                      '${FreteCall.nameCompany(
                                                    (_model.apiResultgty
                                                            ?.jsonBody ??
                                                        ''),
                                                  )?.elementAtOrNull(FFAppState().loop)} ${FreteCall.nameEnvio(
                                                    (_model.apiResultgty
                                                            ?.jsonBody ??
                                                        ''),
                                                  )?.elementAtOrNull(FFAppState().loop)} R\$ ${FreteCall.price(
                                                    (_model.apiResultgty
                                                            ?.jsonBody ??
                                                        ''),
                                                  )?.elementAtOrNull(FFAppState().loop)}');
                                                  safeSetState(() {});
                                                  logFirebaseEvent(
                                                      'IconButton_update_app_state');
                                                  FFAppState().loop =
                                                      FFAppState().loop + 1;
                                                  safeSetState(() {});
                                                }
                                                logFirebaseEvent(
                                                    'IconButton_update_app_state');
                                                FFAppState().loop = 0;
                                                FFAppState().update(() {});
                                                logFirebaseEvent(
                                                    'IconButton_backend_call');

                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  cep: _model
                                                      .textController.text,
                                                ));
                                              } else {
                                                logFirebaseEvent(
                                                    'IconButton_alert_dialog');
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text('Erro'),
                                                      content:
                                                          Text('CEP incorreto'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }

                                              safeSetState(() {});
                                            },
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (FFAppState().frete.length > 3)
                                            FlutterFlowRadioButton(
                                              options:
                                                  FFAppState().frete.toList(),
                                              onChanged: (val) async {
                                                safeSetState(() {});
                                                logFirebaseEvent(
                                                    'CART_RadioButton_hakcru8v_ON_FORM_WIDGET');
                                                logFirebaseEvent(
                                                    'RadioButton_custom_action');
                                                _model.valorfrete =
                                                    await actions.valorfrete(
                                                  valueOrDefault<String>(
                                                    _model.radioButtonValue,
                                                    '0',
                                                  ),
                                                );

                                                safeSetState(() {});
                                              },
                                              controller: _model
                                                      .radioButtonValueController ??=
                                                  FormFieldController<String>(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                'd30uago4' /* 0 */,
                                              )),
                                              optionHeight: 25.0,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                              selectedTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                              buttonPosition:
                                                  RadioButtonPosition.left,
                                              direction: Axis.vertical,
                                              radioButtonColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              inactiveRadioButtonColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              toggleable: false,
                                              horizontalAlignment:
                                                  WrapAlignment.start,
                                              verticalAlignment:
                                                  WrapCrossAlignment.start,
                                            ),
                                        ],
                                      ),
                                    ]
                                        .divide(SizedBox(height: 6.0))
                                        .around(SizedBox(height: 6.0)),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Container(
                                width: 600.0,
                                constraints: BoxConstraints(
                                  minWidth: 300.0,
                                  maxWidth: 800.0,
                                ),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: wrapWithModel(
                                  model: _model.costsModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CostsWidget(
                                    parameter1: cartShoppingCartRecordList
                                        .map((e) => valueOrDefault<double>(
                                              e.subtotal,
                                              0.0,
                                            ))
                                        .toList(),
                                    parameter2: valueOrDefault<String>(
                                      formatNumber(
                                        _model.valorfrete,
                                        formatType: FormatType.custom,
                                        currency: 'R\$ ',
                                        format: '#,##0.00',
                                        locale: 'pt_BR',
                                      ),
                                      'R\$ 0,00',
                                    ),
                                    parameter3: valueOrDefault<double>(
                                      functions.somatotal(
                                          valueOrDefault<double>(
                                            _model.valorfrete,
                                            0.0,
                                          ),
                                          valueOrDefault<double>(
                                            functions.subsomatotal(
                                                cartShoppingCartRecordList
                                                    .map((e) =>
                                                        valueOrDefault<double>(
                                                          e.subtotal,
                                                          0.0,
                                                        ))
                                                    .toList()),
                                            0.0,
                                          )),
                                      0.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'CART_PAGE_PROCEED_TO_CHECKOUT_BTN_ON_TAP');
                                logFirebaseEvent('Button_navigate_to');

                                context.pushNamed(
                                  'Checkout',
                                  queryParameters: {
                                    'subtotal': serializeParam(
                                      cartShoppingCartRecordList.length
                                          .toDouble(),
                                      ParamType.double,
                                    ),
                                    'frete': serializeParam(
                                      _model.valorfrete,
                                      ParamType.double,
                                    ),
                                    'total': serializeParam(
                                      valueOrDefault<double>(
                                        functions.somatotal(
                                            valueOrDefault<double>(
                                              _model.valorfrete,
                                              0.0,
                                            ),
                                            valueOrDefault<double>(
                                              functions.subsomatotal(
                                                  cartShoppingCartRecordList
                                                      .map((e) => e.subtotal)
                                                      .toList()),
                                              0.0,
                                            )),
                                        0.0,
                                      ),
                                      ParamType.double,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              text: FFLocalizations.of(context).getText(
                                'ejsah2dw' /* Proceed to Checkout */,
                              ),
                              options: FFButtonOptions(
                                width: 200.0,
                                height: 56.0,
                                padding: EdgeInsets.all(8.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(28.0),
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'CART_PAGE_CONTINUE_SHOPPING_BTN_ON_TAP');
                                logFirebaseEvent('Button_navigate_back');
                                context.safePop();
                              },
                              text: FFLocalizations.of(context).getText(
                                'ozoj8ug7' /* Continue Shopping */,
                              ),
                              options: FFButtonOptions(
                                width: 200.0,
                                height: 56.0,
                                padding: EdgeInsets.all(8.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(28.0),
                              ),
                            ),
                          ]
                              .divide(SizedBox(height: 16.0))
                              .addToEnd(SizedBox(height: 24.0)),
                        ),
                      ],
                    ),
                  ].divide(SizedBox(height: 24.0)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
