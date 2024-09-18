
import 'package:flutter/material.dart';
import 'package:panipura/widgets/stylefamily.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../screenhome.dart';

class ScreenEmployerLogin extends StatefulWidget {
  const ScreenEmployerLogin({super.key});

  @override
  State<ScreenEmployerLogin> createState() => _ScreenEmployerLoginState();
}

class _ScreenEmployerLoginState extends State<ScreenEmployerLogin> {
  String? mobileNo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ScreenHome(),
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
                        'assets/background/istockphoto-1246021208-612x612.jpg',
                        //'assets/backgroundimg/indian rupees.jpg',
                      ),

                      fit: BoxFit.contain,
                      //colorFilter: ColorFilter.mode(Colors.white12, BlendMode.darken),
                    ),
                  ),
                ),
              ),
              const Center(
                child: Text("Login with mobile Number ", style: kBodyText),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "Enter your mobile number we will send you OTP to verify ",
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Container(
                            height: 47,
                            width: 50,
                            margin: const EdgeInsets.fromLTRB(0, 10, 3, 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 158, 89, 248),
                                )),
                            child: const Center(
                              child: Text("+91",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ))),
                    Flexible(
                      flex: 5,
                      child: TextFormField(
                        maxLines: 1,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        style: kBodyText,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                          hintText: "Mobile Number",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 89, 248),
                                width: 1),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color.fromARGB(255, 158, 89, 248),
                            width: 1,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color.fromARGB(255, 158, 89, 248),
                            width: 1,
                          )),
                        ),
                        onChanged: (String value) {
                          if (value.length > 9) {
                            mobileNo = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                  child: FormHelper.submitButton("Continue", () {
                // Navigator.of(context).pushReplacement(
                //              MaterialPageRoute(
                //                builder: (context) =>const ScreenOtpverify(),
                //               ),
                //             );
              },
                      borderColor: const Color.fromARGB(255, 158, 89, 248),
                      btnColor: const Color.fromARGB(255, 158, 89, 248),
                      txtColor: Colors.white,
                      borderRadius: 20)),
              const SizedBox(height: 15),
              Center(
                  child: FormHelper.submitButton("SignUP", () {
                // Navigator.of(context).pushReplacement(
                //              MaterialPageRoute(
                //                builder: (context) => ScreenEmployerRegister(category:widget.),
                //               ),
                //             );
              },
                      borderColor: const Color.fromARGB(255, 158, 89, 248),
                      btnColor: Colors.white,
                      txtColor: Colors.blue,
                      borderRadius: 20))
            ],
          ),
        ),
      ),
    );
  }
}
