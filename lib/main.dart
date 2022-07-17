import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mysql1/mysql1.dart';
import 'package:url_launcher/url_launcher.dart';
import 'netconfit.dart';
import 'mysql.dart';
import 'dart:async';
import 'package:mysql1/mysql1.dart' as mysql;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const RegisterDemo(),
    );
  }
}

class RegisterDemo extends StatefulWidget {
  const RegisterDemo({Key? key}) : super(key: key);

  @override
  _RegisterDemoState createState() => _RegisterDemoState();
}

class _RegisterDemoState extends State<RegisterDemo> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController usernameController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController passwordconfController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  @override
  void initState() {
    usernameController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    passwordconfController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    super.initState();
  }

  @override
  Future<Widget> (BuildContext context) async {
    var settings = ConnectionSettings(
        host: 'kit301-mysql-server.mysql.database.azure.com',
        port: 3306,
        user: 'adminKevin@kit301-mysql-server',
        password: 'Admin301',
        db: 'MySql'
    );
    var conn = await MySqlConnection.connect(settings);
  }

  var emailReg =
      "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back, color: Colors.black),
          toolbarHeight: 35,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 30.0),
              child: Column(children: [
                Container(
                    alignment: const Alignment(-1, -1),
                    height: 30,
                    width: 300,
                    margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                    child: const Text(
                      'Sign up the free account',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff0a1f44),
                        letterSpacing: 0.3571428680419922,
                        height: 2,
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: TextFormField(
                    maxLines: 1,
                    controller: usernameController,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Your Username is too short';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        isCollapsed: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                        fillColor: Color.fromRGBO(230, 230, 230, 95),
                        filled: true,
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Colors.transparent,
                              style: BorderStyle.solid,
                            ))),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                    controller: nameController,
                    decoration: const InputDecoration(
                        isCollapsed: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                        fillColor: Color.fromRGBO(230, 230, 230, 95),
                        filled: true,
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Color.fromRGBO(230, 230, 230, 0),
                              style: BorderStyle.solid,
                            ))),
                  ), //name
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[]'))
                    ],
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    maxLines: 1,
                    controller: passwordController,
                    validator: (value) {
                      RegExp regExp = RegExp(r"(?![a-zA-Z]+$)(?![A-Z0-9]+$)(?![A-Z\W_]+$)(?![a-z0-9]+$)(?![a-z\W_]+$)(?![0-9\W_]+$)[a-zA-Z0-9\W_]{8,16}$");
                      bool isContain = regExp.hasMatch(passwordController.text);
                      if (isContain == true) {
                        return null;
                      }
                      return 'password not good';
                    },
                    decoration: const InputDecoration(
                        isCollapsed: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                        fillColor: Color.fromRGBO(230, 230, 230, 95),
                        filled: true,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Color.fromRGBO(230, 230, 230, 0),
                              style: BorderStyle.solid,
                            ))),
                  ),
                ), //password
                Container(
                  child: const Text(
                    '6-20 character in length. Contains at least 1 '
                    'lower case letter, 1 uppercase letter, 1 number and one '
                    'of following special characters ! @ # ￥ %',
                    style: TextStyle(
                        color: Color.fromRGBO(173, 173, 175, 100), fontSize: 8),
                  ),
                  height: 50,
                  width: 250,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(1, 1, 1, 0),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    maxLines: 1,
                    controller: passwordconfController,
                    validator: (value) {
                      if (value == passwordController.text) {
                        return null;
                      }
                      return 'passwords are inconsistent';
                    },
                    decoration: const InputDecoration(
                        isCollapsed: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                        fillColor: Color.fromRGBO(230, 230, 230, 95),
                        filled: true,
                        hintText: 'Confirm the Password',
                        hintStyle: TextStyle(
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Color.fromRGBO(230, 230, 230, 0),
                              style: BorderStyle.solid,
                            ))),
                  ), //password confirm
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                    controller: phoneController,

                    decoration: const InputDecoration(
                        isCollapsed: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                        fillColor: Color.fromRGBO(230, 230, 230, 95),
                        filled: true,
                        hintText: 'Phone number',
                        hintStyle: TextStyle(
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Color.fromRGBO(230, 230, 230, 0),
                              style: BorderStyle.solid,
                            ))),
                  ), //phone number
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    controller: emailController,
                    validator: (value) {
                      if (!RegExp(emailReg).hasMatch(emailController.text)) {
                        return 'email not correct';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        isCollapsed: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                        fillColor: Color.fromRGBO(230, 230, 230, 95),
                        filled: true,
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Color.fromRGBO(230, 230, 230, 0),
                              style: BorderStyle.solid,
                            ))),
                  ), //email
                ),
                TextButton(
                  onPressed: () async {
                    var valid = _formKey.currentState!.validate();
                    if (!valid) {
                      return;
                    }
                    String username = usernameController.text;
                    String name = nameController.text;
                    String password = passwordController.text;
                    String passwordconf = passwordconfController.text;
                    String phone = phoneController.text;
                    String email = emailController.text;
                  },
                  child: const Text(
                      '                            Sign Up                            '),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(255, 191, 34, 100)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 12)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                  ),
                ), //sign up button
                const Text(
                  'By clicking Sign up you agree to the following',
                  style: TextStyle(fontSize: 10, color: Colors.black26),
                ),
                Container(
                  child: InkWell(
                      child: const Text(
                        'Terms and Conditions',
                        style: TextStyle(fontSize: 10, color: Colors.black26,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () => _launchUrl()
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                )
              ]),
            )));
  }

  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    passwordController.dispose();
    passwordconfController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  //Set the redirect page for external links
  final Uri _url = Uri.parse('https://www.baidu.com');
  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }
}

