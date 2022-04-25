import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  Success({Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Account Created Successfully"),
          ),
          MaterialButton(
            color: const Color(0xFF8889B9),
            textColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            child: const Text(
              "Login",
            ),
          ),
        ],
      ),
    );
  }
}
