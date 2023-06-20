import 'package:flutter/material.dart';
import 'package:grocery_flutter/utils/InfoCard.dart';
import 'package:grocery_flutter/utils/shared_service.dart';

const fullName = "Tran COng TIen  ";
const email = "tien@gmail.com";

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
   SharedService.loginDetails();
    return Scaffold(
        backgroundColor: Colors.orangeAccent[800],
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
              const Text(
                "Tran Cong Tien",
                style: TextStyle(
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
              InfoCard(text: fullName, icon: Icons.person, onPressed: ()   {}),
              InfoCard(text: email, icon: Icons.mail, onPressed: ()   {}),
              // we will be creating a new widget name info carrd
            ],
          ),
        ));
  }
}
