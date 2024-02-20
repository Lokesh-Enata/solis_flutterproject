import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:solis_flutterproject/Views/models/registermodel.dart';
import 'package:solis_flutterproject/Views/pages/Account/loginpage.dart';
import 'package:solis_flutterproject/Views/pages/dashboardpage.dart';
import 'package:solis_flutterproject/Views/pages/livemapspage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  String countryCode = '+91';
  final FocusNode _textFieldFocusNode = FocusNode();
  bool hasFocus = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController devicetypeController =
      TextEditingController(text: 'android');
  TextEditingController macIDController =
      TextEditingController(text: '1234567890');
  TextEditingController serialNumberController =
      TextEditingController(text: '1334');

  bool isLoading = false;

  Future<void> register(
      String firstName, lastName, email, mobileNumber, password) async {
    setState(() {
      isLoading = false;
    });
     showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CustomLoaderDialog(),
    );  
    const String apiUrl = 'http://139.59.62.79/api/v1/accounts/fotax-register/';

    try {
      Response response = await http.post(Uri.parse(apiUrl), body: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'mobile': mobileNumber,
        'password': password,
        'device_type': 'android',
        'mac_id': '1234567899',
        'serial_number': '1544'
      });
      if (firstName.isEmpty &&
          lastName.isEmpty &&
          email.isEmpty &&
          password.isEmpty) {
             setState(() {
        isLoading = false;
        Navigator.pop(context);
      });
        // ignore: use_build_context_synchronously
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.scale,
          btnOkColor: const Color.fromARGB(255, 25, 45, 159),
          title: 'Alert',
          desc: 'Please enter the required field',
          descTextStyle: const TextStyle(fontSize: 18),
          btnOkOnPress: () {},
        ).show();
        return;
      } else if (response.statusCode == 201) {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DashboardPage()));

        // ignore: use_build_context_synchronously
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          btnOkColor: const Color.fromARGB(255, 25, 45, 159),
          title: 'Success',
          desc: 'Welcome, $firstName',
          descTextStyle: const TextStyle(fontSize: 18),
          btnOkOnPress: () {},
        ).show();
        // } else if () {
        //   // ignore: use_build_context_synchronously
        //   AwesomeDialog(
        //     context: context,
        //     dialogType: DialogType.error,
        //     animType: AnimType.scale,
        //     title: 'Alert',
        //     desc: 'Please enter the required field',
        //     btnOkColor: const Color.fromARGB(255, 25, 45, 159),
        //     descTextStyle: const TextStyle(fontSize: 18),
        //     btnOkOnPress: () {},
        //   ).show();
      }
      // else if (response.statusCode == 400)
      // {
      //   print(response.body);
      //   // ignore: use_build_context_synchronously
      //   AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.error,
      //     animType: AnimType.scale,
      //     title: 'Alert',
      //     desc: 'User already Registered',
      //     btnOkColor: const Color.fromARGB(255, 25, 45, 159),
      //     descTextStyle: const TextStyle(fontSize: 18),
      //     btnOkOnPress: () {},
      //   ).show();
      // }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          resizeToAvoidBottomInset: true,
          // Appbar code
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 25, 45, 159),
            toolbarHeight: 80,
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: Image.asset(
                    "assets/images/ic_sidebar.png",
                    height: 30,
                  ), // Menu icon
                  onPressed: () {
                    // Handle menu button press
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            title: const Text(
              "Register User",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
          ),

          // SideMenuBar Code

          drawer: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Drawer(
              backgroundColor: const Color.fromARGB(255, 25, 45, 159),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Image.asset(
                              'assets/images/icbackarrow.png',
                              height: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Image.asset(
                            'assets/images/ic_sidebar.png',
                            height: 40,
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        height: 80,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/images/icbluetractor.png',
                              height: 30,
                            ),
                            const Text(
                              'Vehicles',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LiveMapsView()));
                        },
                        child: Container(
                          height: 80,
                          width: 180,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/iclivemap.png',
                                height: 40,
                              ),
                              const Text(
                                'Live Map',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/ictripmonitor.png',
                              height: 40,
                            ),
                            const Text(
                              'Trip Monitor',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/icparametermonitor.png',
                              height: 30,
                            ),
                            const Text(
                              'Parameter Monitor',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/icremotediagno.png',
                              height: 40,
                            ),
                            const Text(
                              'Remote Diagnotics',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/icdigilock.png',
                              height: 50,
                            ),
                            const Text(
                              'Digilock',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/icsettings.png',
                              height: 40,
                            ),
                            const Text(
                              'Settings',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  barrierColor: Colors.grey,
                                  animType: AnimType.scale,
                                  title: 'Alert',
                                  desc: 'Are you sure you want to Logout ?',
                                  descTextStyle: const TextStyle(fontSize: 18),
                                  btnOkOnPress: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  },
                                  btnCancelOnPress: () {})
                              .show();
                        },
                        child: Container(
                          height: 80,
                          width: 180,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/iclogout.png',
                                height: 40,
                              ),
                              const Text(
                                'Logout',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // ignore: sized_box_for_whitespace
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Add photo',
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                        ),
                      ),
                      // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
                      Container(
                        height: 160,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            // Profile photo
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.grey[200],
                              child: Container(
                                height: 90,
                                width: 90,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'assets/images/icuserprofile.png'))),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              bottom: 0,
                              child: Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Textfield Code
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    'First Name*',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                  ),
                                ),
                                TextField(
                                  controller: firstNameController,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10),
                                      hintText: 'Enter here',
                                      labelStyle: const TextStyle(
                                          fontSize: 23, color: Colors.black),
                                      hintStyle: const TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 2.0,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    'Last Name*',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                  ),
                                ),
                                TextField(
                                  controller: lastNameController,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10),
                                      hintText: 'Enter here',
                                      labelStyle: const TextStyle(
                                          fontSize: 23, color: Colors.black),
                                      hintStyle: const TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 2.0,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    'Password*',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                  ),
                                ),
                                TextField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10),
                                      hintText: 'Enter here',
                                      labelStyle: const TextStyle(
                                          fontSize: 23, color: Colors.black),
                                      hintStyle: const TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 2.0,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    'Mobile Number*',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(_textFieldFocusNode);
                                  },
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: _textFieldFocusNode.hasFocus
                                                ? const Color.fromARGB(
                                                    255, 25, 45, 159)
                                                : Colors.grey,
                                            width: 1.5)),
                                    child: Row(
                                      children: [
                                        // Country Code Dropdown
                                        Container(
                                          height: 65,
                                          width: 80,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10)),
                                              color: Colors.black12),
                                          child: Center(
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                iconSize: 35,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                focusColor: Colors.grey,
                                                value: countryCode,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    countryCode = value!;
                                                  });
                                                },
                                                items: [
                                                  '+91',
                                                  '+1',
                                                  '+44'
                                                ] // Add more country codes as needed
                                                    .map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                8.0), // Add spacing between country code and text field
                                        // Text Field
                                        Expanded(
                                          child: Center(
                                            child: TextField(
                                              keyboardType: TextInputType.phone,
                                              controller:
                                                  mobileNumberController,
                                              focusNode: _textFieldFocusNode,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: const InputDecoration(
                                                labelStyle: TextStyle(
                                                    fontSize: 23,
                                                    color: Colors.black),
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                hintStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.grey),
                                                hintText: 'Phone Number',
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    'Email Id*',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                  ),
                                ),
                                TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      labelStyle: const TextStyle(
                                          fontSize: 23, color: Colors.black),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10),
                                      hintText: 'Enter here',
                                      hintStyle: const TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 2.0,
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: RichText(
                                    text: TextSpan(
                                        text:
                                            'By Registering yourself, you agree to our ',
                                        style: const TextStyle(
                                            color: Colors.black54),
                                        children: [
                                          TextSpan(
                                            text: ' Privacy Policy ',
                                            style: const TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Color.fromARGB(
                                                    255, 25, 45, 159)),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const RegisterPage()));
                                              },
                                          ),
                                          const TextSpan(text: 'and'),
                                          TextSpan(
                                            text: ' Terms & Conditions ',
                                            style: const TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Color.fromARGB(
                                                    255, 25, 45, 159)),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const RegisterPage()));
                                              },
                                          ),
                                        ]),
                                  ),
                                )
                              ],
                            ),

                            // Sign In Button
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  register(
                                      firstNameController.text.toString(),
                                      lastNameController.text.toString(),
                                      emailController.text.toString(),
                                      mobileNumberController.text.toString(),
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
                                        Size(500, 60))),
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
//                       if (isLoading)
//                         Stack(children: [
//                           ModalBarrier(
//                             color: Colors.black.withOpacity(0.5),
// //           dismissible: false,
//                           ),
//                           const SpinKitWave(
//                             color: Colors.blue, // You can customize the color
//                             //             size: 50.0,),
//                           ),
//                         ])
                    ]),
              ),
            ),
          )),
    ]);
  }

  Color _containerBorderColor = Colors.grey;
}


class CustomLoaderDialog extends StatelessWidget {
  const CustomLoaderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      content: Center(
        child: SpinKitWave(
          color: Colors.blue, // You can customize the color
          size: 50.0, // You can customize the size
        ),
      ),
    );
  }
}