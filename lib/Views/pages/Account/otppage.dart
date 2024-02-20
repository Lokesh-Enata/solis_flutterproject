import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:solis_flutterproject/Views/pages/dashboardpage.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  TextEditingController _pinEditingController = TextEditingController();

  late Timer _timer;
Function? onTap;

  int _timerMinutes = 0; // Initial minutes
  int _timerSeconds = 30;
  // Duration in seconds
  bool _timerRunning = false;
@override
void initState() {
  super.initState();
  onTap = () {
    _startTimer(); // Start the timer
    // TODO: Add logic to resend OTP
  };
}

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
  _timerRunning = true;
  _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
    if (_timerSeconds == 0) {
      if (_timerMinutes == 0) {
        _timer.cancel();
        _timerRunning = false;
      } else {
        setState(() {
          _timerMinutes--;
          _timerSeconds = 59;
        });
      }
    } else {
      setState(() {
        _timerSeconds--;
      });
    }
  });
}
 void _resetTimer() {
  _timer?.cancel();
  setState(() {
    _timerMinutes = 0;
    _timerSeconds = 30;
    _timerRunning = false; // Set _timerRunning to false when the timer resets
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "OTP Verification",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            const Text(
              'Enter OTP to authenticate yourself, sent to +9865412325',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            if (_timerRunning && (_timerMinutes > 0 || _timerSeconds > 0))
            Text(
              '$_timerMinutes:${_timerSeconds.toString().padLeft(2, '0')} remaining',
              style:const TextStyle(
                color: Color.fromARGB(255, 25, 45, 159),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
                 const SizedBox(
                    height: 20,
                  ),
            const SizedBox(
              height: 20,
            ),
            Pinput(
                length: 4,
                focusNode: FocusNode(),
                controller: _pinEditingController,
                onSubmitted: (String pin) {
                  // Handle the submitted OTP
                  print('Submitted OTP: $pin');
                  _resetTimer(); // Reset the timer after successful OTP submission
                }),
            const SizedBox(
              height: 20,
            ),

//            RichText(
//   text: TextSpan(
//     text: 'Don\'t receive the OTP?',
//     style:const TextStyle(color: Colors.black, fontSize: 16),
//     children: [
//       TextSpan(
//         text: ' Resend',
//         style: TextStyle(
//           color: _timerRunning
//               ? Colors.grey // Use grey when the timer is running
//               : Color.fromARGB(255, 25, 45, 159), // Use your color when the timer is not running
//           fontSize: 16,
//           decoration: _timerRunning ? TextDecoration.none : TextDecoration.underline,
//         ),
//         recognizer: _timerRunning
//             ? null // Disable recognizer when the timer is running
//             : TapGestureRecognizer()
//               ..onTap = onTap != null ? () => onTap!() : () {},
            
//       ),
//     ],
//   ),
// ),

 Row(
  children: [
   const Text('Don\'t receive the OTP?'),
    InkWell(
      onTap: () 
      {
       
      },
      child: Text('Resend',
      style: TextStyle(color: _timerRunning ? Colors.grey:const Color.fromARGB(255, 25, 45, 159),
      decoration: _timerRunning ? TextDecoration.none : TextDecoration.underline,),),
    )
  ],
),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const DashboardPage()));
              },
              style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(
                      Color.fromARGB(255, 25, 45, 159)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
                  // Set width and height
                  fixedSize: const MaterialStatePropertyAll(Size(500, 60))),
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ResendText extends StatelessWidget {
//   final Function onTap;
//   final bool isTimerRunning;

//   ResendText({required this.onTap, required this.isTimerRunning});

//   @override
//   Widget build(BuildContext context) {
//     return RichText(
//       text: TextSpan(
//         text: "Don't receive OTP? ",
//         style: DefaultTextStyle.of(context).style,
//         children: [
//           TextSpan(
//             text: 'Resend',
//             style: TextStyle(
//               color: isTimerRunning ? Colors.grey : Colors.blue,
//               decoration: isTimerRunning ? TextDecoration.none : TextDecoration.underline,
//             ),
//             recognizer: (isTimerRunning
//                 ? null // Disable recognizer when timer is running
//                 : TapGestureRecognizer())!..onTap = onTap as GestureTapCallback?,
//           ),
//         ],
//       ),
//     );
//   }
// }