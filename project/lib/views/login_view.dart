import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shared_pref.dart';
import '../view_models/login_view_model.dart';
import 'navigation_container.dart';

class LoginView extends ConsumerWidget {
  LoginView({Key? key}) : super(key: key);
  final LoginViewModel loginViewModel = LoginViewModel();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController usernameInputController =
        TextEditingController();
    final TextEditingController passwordInputController =
        TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .3,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Welcome Back !",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      controller: usernameInputController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Username',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Username';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      controller: passwordInputController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Password';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          loginViewModel.login(
                            username: usernameInputController.text,
                            password: passwordInputController.text,
                          );
                          var userToken = await checkToken(
                            type: TokenType.accessToken,
                          );
                          if (userToken) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NavigationContainer(index: 0),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Wrong Username or Password"),
                              ),
                            );
                          }
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
