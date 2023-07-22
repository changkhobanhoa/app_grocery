import 'package:flutter/material.dart';
import 'package:grocery_flutter/models/login_response_model.dart';
import 'package:grocery_flutter/utils/shared_service.dart';
import '../utils/InfoCard.dart';

const fullName = "Tran COng TIen  ";
const email = "tien@gmail.com";

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
     loginDetails = SharedService.loginDetails();
    super.initState();
  }

 Future<LoginResponseModel?>? loginDetails;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orangeAccent[800],
        body: FutureBuilder<LoginResponseModel?>(
            future: loginDetails,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    children: [
                      const Text(
                        "Bạn Chưa đăng nhập",
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text("Tới màn hình đăng nhập"))
                    ],
                  ),
                );
              }
               final data = snapshot.data;
              return SafeArea(
                minimum: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/avatar.png'),
                    ),
                      Text(
                     data!.data.email,
                      style: const TextStyle(
                        fontSize: 40.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Pacifico",
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                      width: 200,
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    InfoCard(
                        text:   data.data.fullName, icon: Icons.person, onPressed: () {}),
                    InfoCard(text: data.data.email, icon: Icons.mail, onPressed: () {}),
                    // we will be creating a new widget name info carrd
                  ],
                ),
              );
            }));
  }
}
