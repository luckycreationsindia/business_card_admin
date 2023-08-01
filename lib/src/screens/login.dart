import 'package:business_card_admin/src/models/user.dart';
import 'package:business_card_admin/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: 600,
            width: 400,
            child: FutureBuilder<bool>(
              future: preCheck(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!) {
                  Future.microtask(() => context.go('/dashboard'));
                  return const SizedBox();
                }
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Center(
                        child: SizedBox(
                          width: 200,
                          height: 150,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'Email',
                          hintText: 'Enter valid email id as abc@gmail.com',
                          filled: true,
                          fillColor: const Color(0xFF171B2D),
                        ),
                        controller: _usernameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                        top: 15,
                        bottom: 0,
                      ),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'Password',
                          hintText: 'Enter secure password',
                          filled: true,
                          fillColor: const Color(0xFF171B2D),
                        ),
                        controller: _passwordController,
                      ),
                    ),
                    const SizedBox(height: 20),
                    isLoading
                        ? const CircularProgressIndicator()
                        : FilledButton(
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                                initLogin().then((value) {
                                  context.go('/dashboard');
                                }).catchError((err) {
                                  print(err);
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              });
                            },
                            child: const Text('Login'),
                          ),
                    const SizedBox(height: 130),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> initLogin() async {
    print("INIT LOGIN:");
    print(Consts.API_ROOT);
    Login login = Login(
      email: _usernameController.text,
      password: _passwordController.text,
    );
    await UserRestClient(Consts.dio).login(login);
    print("GOT LOGGED IN");
    Consts.USER_DATA = await UserRestClient(Consts.dio).profile();
    print(Consts.USER_DATA);
    return Future.value(true);
  }

  Future<bool> preCheck() async {
    Consts.USER_DATA = await UserRestClient(Consts.dio).profile();
    return Future.value(true);
  }
}
