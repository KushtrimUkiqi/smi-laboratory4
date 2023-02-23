import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab4_test/statics/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameTextFieldController = TextEditingController();
  TextEditingController passwordTextFieldController = TextEditingController();

  String error = "";

  String username = "";
  String password = "";

  void logIn() async {
    error = "";
    final form = _formKey.currentState;

    if(form != null && form.validate()) {
      form.save();

      var userName = usernameTextFieldController.value.text;
      var password = passwordTextFieldController.value.text;

      showDialog(context: context, builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });

      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }

      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: userName, password: password);
        Navigator.pop(context);
      }
      on FirebaseAuthException catch(e){
        error = "error";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Builder(
            builder: (context) => Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: usernameTextFieldController,
                      decoration: const InputDecoration(
                          labelText: "Username"
                      ),
                      validator: (value){
                        if(value == null || value.trim() == "")
                        {
                          return "Please enter your username";
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          username = value ?? "";
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordTextFieldController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: "Password"
                      ),
                      validator: (value){
                        if(value == null || value.trim() == "")
                        {
                          return "Please enter your password";
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          password = value ?? "";
                        });
                      },
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () {

                          usernameTextFieldController.clear();
                          passwordTextFieldController.clear();

                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        }, child: Text("Cancel")),
                        SizedBox(width: 20,),
                        ElevatedButton(onPressed: logIn, child: Text("Submit"))
                      ],
                    )
                  ],
                )),
          ),
        ),

      ),
    );
  }
}
