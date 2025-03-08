import 'package:panipura/core/hooks/hook.dart';

import 'package:sms_autofill/sms_autofill.dart';

//import 'ScreenLogin.dart';

class ScreenOtpverify extends StatefulWidget {
  final String? mobileNo;
  final int? category;
  final String? otpHash;
  const ScreenOtpverify(
      {super.key,
      required this.mobileNo,
      required this.category,
      this.otpHash});

  @override
  State<ScreenOtpverify> createState() => _ScreenOtpverifyState();
}

class _ScreenOtpverifyState extends State<ScreenOtpverify> {
  // String? catgoryval;
  String otpCode = "";
  final int _otpCodeLength = 6;
  bool isAPICallProcess = false;
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    // catgoryval=widget.category;
    // myFocusNode=FocusNode();
    // myFocusNode.requestFocus();

    // SmsAutoFill().listenForCode.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ProgressHUD(
          key: UniqueKey(),
          opacity: .3,
          inAsyncCall: isAPICallProcess,
          child: verifyOtpUI(),
        ),
      ),
    );
  }

  Widget verifyOtpUI() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          ScreenLogin(category: widget.category),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_back)),
            const SizedBox(height: 80),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/background/e9b33ec8595630e5a2cfaa14eb6784b6.jpg',
                      //'assets/backgroundimg/indian rupees.jpg',
                    ),

                    fit: BoxFit.contain,
                    //colorFilter: ColorFilter.mode(Colors.white12, BlendMode.darken),
                  ),
                ),
              ),
            ),
            const Center(
              child: Text("OTP Verification", style: kScreenText),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Enter OTP code sent to your mobile \n+91-${widget.mobileNo}",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: PinFieldAutoFill(
                decoration: UnderlineDecoration(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  colorBuilder: const FixedColorBuilder(
                      Color.fromARGB(255, 158, 89, 248)),
                ),
                currentCode: otpCode,
                codeLength: _otpCodeLength,
                onCodeChanged: (code) {
                  if (code!.length == _otpCodeLength) {
                    //_otpCode=code;
                    //FocusScope.of(context).requestFocus(FocusNode());
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
                child: FormHelper.submitButton("Verify", () {
              if (widget.category == lab) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Screenlabhome(),
                  ),
                );
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const ScreenEmployerHome(),
                  ),
                );
              }
            },
                    borderColor: const Color.fromARGB(255, 158, 89, 248),
                    btnColor: const Color.fromARGB(255, 158, 89, 248),
                    txtColor: Colors.white,
                    borderRadius: 20)),
            const SizedBox(
              height: 15,
            ),
            buildTimer(),
            Center(
              child: TextButton(
                child: const Text(
                  "Resend OTP",
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "This otp will expired in ",
          style: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 18,
              color: Color.fromARGB(255, 114, 188, 248),
              fontWeight: FontWeight.bold),
        ),
        TweenAnimationBuilder(
          tween: Tween(begin: 3000.0, end: 0),
          duration: const Duration(seconds: 3000),
          builder: (context, value, child) => Text(
            "00:${value.toInt()}",
            style: const TextStyle(color: Colors.red),
          ),
          onEnd: () {},
        ),
      ],
    );
  }

  @override
  void dispose() {
    // SmsAutoFill().unregisterListener();
    // myFocusNode.dispose();
    super.dispose();
  }
}
