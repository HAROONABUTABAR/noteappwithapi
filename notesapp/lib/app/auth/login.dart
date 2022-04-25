import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:notesapp/componets/crud.dart';
import 'package:notesapp/componets/customtextform.dart';
import 'package:notesapp/componets/vliad.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  Crud crud = new Crud();

  bool isLoading = false;

  login() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(linkLogIn, {
        "password": passwordController.text,
        "email": emailController.text,
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        sharedPreferences.setString("id", response['data']['id'].toString());
        sharedPreferences.setString("username", response['data']['username']);
        sharedPreferences.setString("email", response['data']['email']);

        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        AwesomeDialog(context: context, title: "Error", desc: "plase try again")
            .show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                          preIcon: const Icon(LineAwesomeIcons.envelope),
                          hint: "Email",
                          mycontroller: emailController,
                          valid: (value) {
                            return validInput(value!, 10, 100);
                          },
                        ),
                        CustTextFormSign(
                          preIcon: const Icon(LineAwesomeIcons.lock),
                          suffIcon: const Icon(LineAwesomeIcons.eye),
                          hint: "Password",
                          mycontroller: passwordController,
                          valid: (value) {
                            return validInput(value!, 5, 50);
                          },
                        ),
                        MaterialButton(
                          color: const Color(0xFF8889B9),
                          textColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 10),
                          onPressed: () async {
                            await login();
                            // Navigator.of(context).pushNamed("home");
                          },
                          child: const Text(
                            "Login",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("signup");
                          },
                          child: const Text("Sign up"),
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
