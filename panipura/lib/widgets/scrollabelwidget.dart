
import 'package:panipura/core/hooks/hook.dart';

class Scrollablewidget extends StatelessWidget {
  final Widget child;

  const Scrollablewidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: child,
      ));
}
