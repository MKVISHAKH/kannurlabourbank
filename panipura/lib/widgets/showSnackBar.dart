
import 'package:panipura/core/hooks/hook.dart';

void showSnackBar(
  BuildContext context, {
  IconData icon = Icons.info_outline,
  required String text,
}) {
  Size size = MediaQuery.of(context).size;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 4.0,
      backgroundColor: Appcolors.black.withOpacity(0.65),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 800),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.height * 0.02),
      ),
      content: Row(
        children: [
          SizedBox(width: size.width * 0.01),
          Icon(
            icon,
            size: size.height * 0.035,
            color: Appcolors.white,
          ),
          SizedBox(width: size.width * 0.01),
          Text(text,
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(
                color: Appcolors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ))
        ],
      ),
    ),
  );
}
