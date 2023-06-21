import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '/models/cart.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../config.dart';
import '../providers.dart';

class PaymentPage extends ConsumerStatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String cardHolderName = "";
  String cardNumber = "";
  String cardExp = "";
  String cardCVC = "";

  @override
  Widget build(BuildContext context) {
    final orderPayment = ref.watch(orderPaymentProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: ProgressHUD(
        key: UniqueKey(),
        inAsyncCall: orderPayment.isLoading,
        opacity: 0.3,
        child: Form(
          key: globalKey,
          child: _paymentUI(context, ref),
        ),
      ),
    );
  }

  Widget _paymentUI(BuildContext context, WidgetRef ref) {
    final cartProvider = ref.watch(cartItemsProvider);
    if (cartProvider.cartModel != null) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Total Amount",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "${cartProvider.cartModel!.grandTotal.toString()} ${Config.currency}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              FormHelper.inputFieldWidgetWithLabel(
                context,
                "Card Holder Name",
                "Card Holder",
                "Your name and surename",
                (onValidate) {
                  if (onValidate.isEmpty) {
                    return "* Required";
                  }
                },
                (onSaved) {
                  cardHolderName = onSaved.toString().trim();
                },
                showPrefixIcon: true,
                prefixIcon: const Icon(Icons.face),
                borderRadius: 10,
                contentPadding: 10,
                fontSize: 14,
                paddingLeft: 0,
                paddingRight: 0,
                prefixIconPaddingLeft: 10,
                borderColor: Colors.grey.shade500,
                textColor: Colors.black,
                prefixIconColor: Colors.black,
                hintColor: Colors.black.withOpacity(.6),
                backgroundColor: Colors.grey.shade100,
                borderFocusColor: Colors.grey.shade200,
              ),
              const SizedBox(height: 15),
              FormHelper.inputFieldWidgetWithLabel(
                context,
                "Card Number",
                "Card Number",
                "Card Number",
                (onValidate) {
                  if (onValidate.isEmpty) {
                    return "* Required";
                  }
                },
                (onSaved) {
                  cardNumber = onSaved.toString().trim();
                },
                showPrefixIcon: true,
                prefixIcon: const Icon(Icons.credit_card),
                borderRadius: 10,
                contentPadding: 10,
                fontSize: 14,
                paddingLeft: 0,
                paddingRight: 0,
                prefixIconPaddingLeft: 10,
                borderColor: Colors.grey.shade500,
                textColor: Colors.black,
                prefixIconColor: Colors.black,
                hintColor: Colors.black.withOpacity(.6),
                backgroundColor: Colors.grey.shade100,
                borderFocusColor: Colors.grey.shade200,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Flexible(
                    child: FormHelper.inputFieldWidgetWithLabel(
                      context,
                      "Valide Exp",
                      "Valide Untile",
                      "Month / Year",
                      (onValidate) {
                        if (onValidate.isEmpty) {
                          return "* Required";
                        }
                      },
                      (onSaved) {
                        cardExp = onSaved.toString().trim();
                      },
                      showPrefixIcon: true,
                      prefixIcon: const Icon(Icons.calendar_month),
                      borderRadius: 10,
                      contentPadding: 10,
                      fontSize: 14,
                      paddingLeft: 0,
                      paddingRight: 10,
                      prefixIconPaddingLeft: 10,
                      borderColor: Colors.grey.shade500,
                      textColor: Colors.black,
                      prefixIconColor: Colors.black,
                      hintColor: Colors.black.withOpacity(.6),
                      backgroundColor: Colors.grey.shade100,
                      borderFocusColor: Colors.grey.shade200,
                    ),
                  ),
                  Flexible(
                    child: FormHelper.inputFieldWidgetWithLabel(
                      context,
                      "CVV",
                      "CVV",
                      "CVV",
                      (onValidate) {
                        if (onValidate.isEmpty) {
                          return "* Required";
                        }
                      },
                      (onSaved) {
                        cardCVC = onSaved.toString().trim();
                      },
                      showPrefixIcon: false,
                      prefixIcon: const Icon(Icons.face),
                      borderRadius: 10,
                      contentPadding: 10,
                      fontSize: 14,
                      paddingLeft: 0,
                      paddingRight: 0,
                      prefixIconPaddingLeft: 10,
                      borderColor: Colors.grey.shade500,
                      textColor: Colors.black,
                      prefixIconColor: Colors.black,
                      hintColor: Colors.black.withOpacity(.6),
                      backgroundColor: Colors.grey.shade100,
                      borderFocusColor: Colors.grey.shade200,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Center(
                child: FormHelper.submitButton(
                  "Proceed to Confirm",
                  () async {
                    if (validateAndSave()) {
                      final orderPaymentModel =
                          ref.read(orderPaymentProvider.notifier);
                      await orderPaymentModel.processPayment(
                        cardHolderName,
                        cardNumber,
                        cardExp,
                        cardCVC,
                        cartProvider.cartModel!.grandTotal.toString(),
                      );
                      final orderPaymetnResponseModel =
                          ref.watch(orderPaymentProvider);
                      print(orderPaymetnResponseModel.isSuccess);
                      if (!orderPaymetnResponseModel.isSuccess) {
                        // ignore: use_build_context_synchronously
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.app_name,
                          orderPaymetnResponseModel.message,
                          "Ok",
                          () {
                            Navigator.of(context).pop();
                          },
                        );
                      } else {
                        Navigator.of(context).pushNamed("/order-success");
                      }
                    }
                  },
                  btnColor: Colors.blue,
                  borderColor: Colors.white,
                  txtColor: Colors.white,
                  borderRadius: 20,
                  width: 250,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return const CircularProgressIndicator();
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
