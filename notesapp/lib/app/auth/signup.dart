import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:notesapp/componets/crud.dart';
import 'package:notesapp/componets/customtextform.dart';
import 'package:notesapp/componets/vliad.dart';
import 'package:notesapp/constant/linkapi.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  // ignore: unused_field, prefer_final_fields
  Crud _crud = Crud();

  bool isLoading = false;

  sigUp() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequest(linkSignUp, {
        "username": usernameController.text,
        "email": emailController.text,
        "password": passwordController.text,
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("success", (route) => false);
      } else {
        print("SignUp Fial");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop("login");
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Form(
                    key: formstate,
                    child: Column(
                      children: [
                        Image.asset(
                          "images/logo.png",
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustTextFormSign(
                          preIcon: const Icon(LineAwesomeIcons.user),
                          valid: (value) {
                            return validInput(value!, 3, 20);
                          },
                          hint: "Username",
                          mycontroller: usernameController,
                        ),
                        CustTextFormSign(
                          preIcon: const Icon(LineAwesomeIcons.envelope),
                          hint: "Email",
                          mycontroller: emailController,
                          valid: (value) {
                            return validInput(value!, 10, 30);
                          },
                        ),
                        CustTextFormSign(
                          preIcon: const Icon(LineAwesomeIcons.lock),
                          suffIcon: const Icon(LineAwesomeIcons.eye),
                          hint: "Password",
                          mycontroller: passwordController,
                          valid: (value) {
                            return validInput(value!, 6, 20);
                          },
                        ),
                        MaterialButton(
                          color: const Color(0xFF8889B9),
                          textColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 10),
                          onPressed: () async {
                            await sigUp();
                          },
                          child: const Text(
                            "Sign up",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop("login");
                          },
                          child: const Text("Login"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
