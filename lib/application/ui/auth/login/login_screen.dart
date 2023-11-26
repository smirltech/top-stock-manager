import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../system/configs/constants.dart';
import '../../../../system/configs/theming.dart';
import '../../../core/services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String route = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  final _userAddFormKey = GlobalKey<FormState>();
  late final Map<String, dynamic> _user = {
    'username': '',
    'password': '',
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 100,
                    color: kWhite,
                  ),
                  Spacer(),
                  Text(
                    kAppName,
                    style: TextStyle(color: kWhite),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                color: kWhite,
                //margin: const EdgeInsets.symmetric(horizontal: 5.0),
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Form(
                  key: _userAddFormKey,
                  child: Column(
                    children: [
                      const Spacer(),
                      Center(
                        child: Text(
                          "Login".tr,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: _user['username'],
                        onSaved: (String? value) {
                          _user['username'] = value.toString();
                        },
                        validator: (va) {
                          if (va!.isEmpty) {
                            return "Username must not be empty".tr;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "User identifier".tr,
                          labelText: "Username".tr,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: _user['password'],
                        onSaved: (String? value) {
                          _user['password'] = value.toString();
                        },
                        validator: (va) {
                          if (va!.isEmpty) {
                            return "Password must not be empty".tr;
                          } else if (va.length < 4) {
                            return "Length of password must be 4 characters and above";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "User password".tr,
                          labelText: "Password".tr,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_userAddFormKey.currentState!.validate()) {
                              return;
                            }
                            _userAddFormKey.currentState!.save();
                            AuthServices.to.login(_user);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: kWhite,
                            backgroundColor: kWarning,
                          ),
                          child: Text('Confirm'.tr),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
