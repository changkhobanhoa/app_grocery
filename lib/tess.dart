import 'package:flutter/material.dart';

import 'models/login_response_model.dart';
import 'utils/shared_service.dart';
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Future<LoginResponseModel?>? _loginDetails;

  @override
  void initState() {
    super.initState();
    _loginDetails = SharedService.loginDetails();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LoginResponseModel?>(
      future: _loginDetails,
      builder: (BuildContext context, AsyncSnapshot<LoginResponseModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final data = snapshot.data;
        if (data != null) {
          return Text('Message: ${data.message}');
        } else {
          return Text('No data available');
        }
      },
    );
  }
}