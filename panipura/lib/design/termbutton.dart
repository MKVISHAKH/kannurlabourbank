import 'package:panipura/core/hooks/hook.dart';

// ignore: must_be_immutable
class TermsButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  bool isAccepted;
  TermsButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isAccepted = false,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.012,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            border: Border.all(
              color: Appcolors.magenta,
              width: size.width * 0.005,
            ),
            borderRadius: BorderRadius.circular(size.height * 0.01),
            color: isAccepted ? Appcolors.magenta : Appcolors.white),
        child: Text(title,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: size.height * 0.022,
                fontWeight: FontWeight.w600,
                color: isAccepted ? Appcolors.white : Appcolors.magenta)),
      ),
    );
  }
}
