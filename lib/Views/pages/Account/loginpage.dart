import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart' hide Response;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:solis_flutterproject/Views/pages/Account/registerpage.dart';
import 'package:solis_flutterproject/Views/pages/dashboardpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async {
    try {
      Response response = await post(
          Uri.parse('http://139.59.62.79/api/v1/accounts/login/fotax/web'),
          body: {'mobile': email, 'password': password});
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DashboardPage()));

        // ignore: use_build_context_synchronously
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          btnOkColor:const Color.fromARGB(255, 25, 45, 159),
          title: 'Success',
          desc: 'Welcome, Lokesh',
          descTextStyle: const TextStyle(fontSize: 18),
          btnOkOnPress: () {},
        ).show();
      } else {
        // ignore: use_build_context_synchronously
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: 'Alert',
          desc: 'Invalid username and password',
           btnOkColor:const Color.fromARGB(255, 25, 45, 159),
          descTextStyle: const TextStyle(fontSize: 18),
          btnOkOnPress: () {},
        ).show();
        // ignore: avoid_print
        print('Invalid user name and password');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              child: Stack(children: [
                Container(
                  height: 380,
                  width: double.infinity,
                  color: const Color.fromARGB(255, 25, 45, 159),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/name_logo.png',
                          width: 250,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            "Welcome, John!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                        const Text(
                          "Please login to continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),

                // TextField Container Code
                Center(
                  child: Positioned(
                    top: 0,
                    child: Container(
                      height: 340,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 3, // Spread radius
                              blurRadius: 7, // Blur radius
                              offset: const Offset(
                                  0, 3), // Offset in the x, y direction
                            ),
                          ],
                          color: Colors.white),
                      margin:
                          const EdgeInsets.only(top: 60, left: 20, right: 20),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                  controller: emailController,
                                  autofocus: false,
                                  decoration: const InputDecoration(
                                      labelStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                      labelText: 'Email',
                                      hintText: "dummyemail@gmail.com",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 22),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 5.0),
                                      icon: Padding(
                                        padding: EdgeInsets.only(top: 15.0),
                                      ))),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                textInputAction: TextInputAction.done,
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.black,
                                      ),
                                      labelStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                      labelText: 'Password',
                                      hintText: "********",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 22),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 1.0),
                                      icon: Padding(
                                        padding: EdgeInsets.only(top: 15.0),
                                      ))),

                              // Sizebox for spacing
                              const SizedBox(
                                height: 50,
                              ),

                              // Sign In Button
                              ElevatedButton(
                                onPressed: () {
                                  login(emailController.text.toString(),
                                      passwordController.text.toString());
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const DashboardPage()));
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                            Color.fromARGB(255, 25, 45, 159)),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0))),
                                    // Set width and height
                                    fixedSize: const MaterialStatePropertyAll(
                                        Size(300, 60))),
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                               Padding(
                                padding:
                                  const  EdgeInsets.only(left: 20.0, right: 15.0),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RegisterPage()));
                                      },
                                      child:const Text(
                                        "Register",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 18),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 95,
                                    ),
                                   const Text(
                                      "Forgot Password",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                    )
                                  ],
                                ),
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 110,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/fotax_logo.png',
                        width: 200,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const Text(
                          "Powered by",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),
                      const Text(
                        "autopeepal",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: "MagnetoBold"),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ],
        ));
  }
}
