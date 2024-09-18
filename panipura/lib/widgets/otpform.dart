import 'package:panipura/core/hooks/hook.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;
  late FocusNode focusNode5;
  late FocusNode focusNode6;
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  final controller5 = TextEditingController();
  final controller6 = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();
    focusNode6 = FocusNode();
  }

  @override
  void dispose() {
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();
    focusNode6 = FocusNode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //double width=size.width*0.12;
    return Container(
      width: size.width,
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          inputField(
              controller: controller1,
              autoFouc: true,
              size: size,
              node: focusNode1,
              function: (string) {
                moveForward(string, focusNode2);
              }),
          inputField(
              controller: controller2,
              autoFouc: true,
              size: size,
              node: focusNode2,
              function: (string) {
                moveForward(string, focusNode3);
              }),
          inputField(
              controller: controller3,
              autoFouc: true,
              size: size,
              node: focusNode3,
              function: (string) {
                moveForward(string, focusNode4);
              }),
          inputField(
              controller: controller4,
              autoFouc: true,
              size: size,
              node: focusNode4,
              function: (string) {
                moveForward(string, focusNode5);
              }),
          inputField(
              controller: controller5,
              autoFouc: true,
              size: size,
              node: focusNode5,
              function: (string) {
                moveForward(string, focusNode6);
              }),
          inputField(
              controller: controller6,
              autoFouc: true,
              size: size,
              node: focusNode6,
              function: (string) {
                focusNode6.unfocus();
              }),
        ],
      ),
    );
  }

  void moveForward(String value, FocusNode node) {
    if (value.length == 1) {
      node.requestFocus();
    }
  }

  Widget inputField({
    required Size size,
    autoFouc = false,
    required FocusNode node,
    required Function(String) function,
    required TextEditingController controller,
  }) {
    Size size = MediaQuery.of(context).size;
    double width = size.width * 0.12;
    return SizedBox(
        //color:Appcolors.black.withOpacity(0.05),
        width: width,
        child: TextField(
          maxLength: 1,
          autofocus: autoFouc,
          focusNode: node,
          controller: controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          onChanged: function,
          style: _style(size),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: size.height * 0.012,
              ),
              border: _border(),
              errorBorder: _border(),
              focusedBorder: _border(),
              enabledBorder: _border(),
              disabledBorder: _border(),
              focusedErrorBorder: _border()),
        ));
  }

  TextStyle _style(Size size) {
    return GoogleFonts.roboto(
      color: Appcolors.black,
      fontWeight: FontWeight.w700,
      fontSize: size.height * 0.04,
    );
  }

  OutlineInputBorder _border() {
    Size size = MediaQuery.of(context).size;
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(size.height * 0.01),
        borderSide: const BorderSide(
          color: Appcolors.magenta,
          width: 1,
        ));
  }
}

// OTPTextField(
//   length: 6,
//   width: MediaQuery.of(context).size.width -34,
//   fieldWidth: 58,
//   otpFieldStyle: OtpFieldStyle(
//     backgroundColor:const Color.fromARGB(255, 204, 202, 201),
//     borderColor:const Color.fromARGB(255, 158, 89, 248),
//   ),
//   style:const TextStyle(
//     fontSize: 17
//   ),
//   textFieldAlignment: MainAxisAlignment.spaceAround,
//   fieldStyle: FieldStyle.underline,
//   onCompleted: (pin) {
//     print("Completed: " + pin);
//   },
//   );
