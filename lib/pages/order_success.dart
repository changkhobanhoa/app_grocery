import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class OrderSucces extends StatelessWidget {
  const OrderSucces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Success"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Your order has been placed! you will recieve an email shortly",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const Icon(
                Icons.celebration,
                size: 200,
                color: Colors.orange,
              ),
              Center(
                child: FormHelper.submitButton(
                  "Go to Store!",
                  () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/", (route) => false);
                  },
                  btnColor: Colors.green,
                  borderColor: Colors.white,
                  txtColor: Colors.white,
                  borderRadius: 20,
                  width: 250,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}