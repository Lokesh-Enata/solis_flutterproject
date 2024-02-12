import 'package:flutter/material.dart';
import 'package:solis_flutterproject/Views/pages/dashboardpage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
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
                                  autofocus: true,
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DashboardPage()));
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
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 20.0, right: 15.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Register",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 95,
                                    ),
                                    Text(
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
