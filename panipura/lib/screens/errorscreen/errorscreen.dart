import '../../core/hooks/hook.dart';
import '../../widgets/background/backgroundsplash.dart';

class ScreenError extends StatefulWidget {
  const ScreenError({super.key});

  @override
  State<ScreenError> createState() => _ScreenErrorState();
}

class _ScreenErrorState extends State<ScreenError> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Stack(key: _scaffoldKey, children: [
      const Backgroundsplash(),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        "assets/background/alekseyvanin200701168.jpg"),
                  ),
                  //Text("Loading")
                ],
              ),
              const Text(
                "Something Went Wrong",
                style: kHeaderlightText,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Navigator.pushReplacement(_scaffoldKey.currentContext!,
                        Approutes().splashScreen1);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                      fixedSize: const Size(100, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: const Text(
                    "Retry",
                    style: TextStyle(
                        fontFamily: 'Oswald',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    ]);
  }
}
