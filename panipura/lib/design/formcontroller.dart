import 'package:panipura/core/hooks/hook.dart';

class FormTextInput extends StatelessWidget {
  //FormTextInput({super.key});
  final TextEditingController controller;
  final String hint;
  final String label;
  final TextInputType keyboard;
  final bool ispassword;
  final bool iscnfrmpassword;
  final bool isforgot;
  final bool isSignup;
  const FormTextInput({
    super.key,
    required this.controller,
    required this.hint,
    required this.label,
    required this.keyboard,
    this.ispassword = false,
    this.iscnfrmpassword = false,
    this.isforgot = false,
    this.isSignup = false,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    late FrgtpswrdProvider pro;
    if (ispassword) {
      if (isforgot) {
        pro = context.watch<FrgtpswrdProvider>();
      }
    }

    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.done,
      keyboardType: keyboard,
      obscureText: ispassword ? pro.isVisible : false,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 25),
        fillColor: Colors.white,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          borderSide:
              BorderSide(color: Color.fromARGB(255, 158, 89, 248), width: 1),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 158, 89, 248),
            width: 1,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 158, 89, 248),
            width: 1,
          ),
        ),
        suffixIcon: ispassword
            ? IconButton(
                onPressed: () => pro.setVisibility(),
                icon: Icon(
                  pro.isVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  // color:Appcolors.black.withOpacity(0.5),
                  size: size.height * 0.03,
                  color: const Color.fromARGB(255, 101, 47, 248),
                ),
              )
            : const SizedBox.shrink(),
        hintText: hint,
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
      ),
    );
  }
}
