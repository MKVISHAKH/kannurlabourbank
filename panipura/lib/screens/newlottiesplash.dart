// import 'dart:math';
// import 'package:flutter/cupertino.dart';
// import 'package:panipura/core/hooks/hook.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({Key? key}) : super(key: key);

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   int _currentIndex = 0;
//   final PageController _pageController = PageController();

//   @override
//   void initState() {
//     //checkUserLoggedIn();
//     getdistrict();
//     geteducation();
//     getlocalbdytype();
//     getgender();
//     getlocalbdy();
//     getcategory();
//     gotoLogin();
//     super.initState();
//   }

//   Future<void> gotoLogin() async {
//     await Future.delayed(
//       const Duration(seconds: 8),
//     );
//     Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
//       MaterialPageRoute(
//         builder: (ctx) => ScreenHome(),
//       ),
//     );
//   }

//   Future<void> getdistrict() async {
//     await Labourdata().district();
//   }

//   Future<void> geteducation() async {
//     await Labourdata().education();
//   }

//   Future<void> getlocalbdytype() async {
//     await Labourdata().localbodytype();
//   }

//   Future<void> getgender() async {
//     await Labourdata().gender();
//   }

//   Future<void> getlocalbdy() async {
//     await Labourdata().localbodies();
//   }

//   Future<void> getcategory() async {
//     await Labourdata().occupations();
//   }

//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           CustomPaint(
//             painter: ArcPainter(),
//             child: SizedBox(
//               height: screenSize.height / 1.4,
//               width: screenSize.width,
//             ),
//           ),
//           Positioned(
//             top: 130,
//             right: 5,
//             left: 5,
//             child: Image.asset(
//               tabs[_currentIndex].lottieFile,
//               key: Key('${Random().nextInt(999999999)}'),
//               width: 600,
//               alignment: Alignment.topCenter,
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: SizedBox(
//               height: 270,
//               child: Column(
//                 children: [
//                   Flexible(
//                     child: PageView.builder(
//                       controller: _pageController,
//                       itemCount: tabs.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         OnboardingModel tab = tabs[index];
//                         return Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               tab.title,
//                               style: const TextStyle(
//                                 fontSize: 27.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 50),
//                             Text(
//                               tab.subtitle,
//                               style: const TextStyle(
//                                 fontSize: 17.0,
//                                 color: Colors.white70,
//                               ),
//                               textAlign: TextAlign.center,
//                             )
//                           ],
//                         );
//                       },
//                       onPageChanged: (value) {
//                         _currentIndex = value;
//                         setState(() {});
//                       },
//                     ),
//                   ),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       for (int index = 0; index < tabs.length; index++)
//                         _DotIndicator(isSelected: index == _currentIndex),
//                     ],
//                   ),
//                   const SizedBox(height: 75)
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (_currentIndex == 2) {
//             _pageController.animateToPage(
//               0,
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.linear,
//             );
//           } else {
//             _pageController.nextPage(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.linear,
//             );
//           }
//         },
//         backgroundColor: Colors.transparent,
//         child: const Icon(CupertinoIcons.chevron_right, color: Colors.white),
//       ),
//     );
//   }
// }

// class ArcPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Path orangeArc = Path()
//       ..moveTo(0, 0)
//       ..lineTo(0, size.height - 170)
//       ..quadraticBezierTo(
//           size.width / 2, size.height, size.width, size.height - 170)
//       ..lineTo(size.width, size.height)
//       ..lineTo(size.width, 0)
//       ..close();

//     canvas.drawPath(orangeArc, Paint()..color = Colors.orange);

//     Path whiteArc = Path()
//       ..moveTo(0.0, 0.0)
//       ..lineTo(0.0, size.height - 185)
//       ..quadraticBezierTo(
//           size.width / 2, size.height - 70, size.width, size.height - 185)
//       ..lineTo(size.width, size.height)
//       ..lineTo(size.width, 0)
//       ..close();

//     canvas.drawPath(whiteArc, Paint()..color = Colors.white);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

// class _DotIndicator extends StatelessWidget {
//   final bool isSelected;

//   const _DotIndicator({Key? key, required this.isSelected}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 6.0),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         height: 6.0,
//         width: 6.0,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: isSelected ? Colors.white : Colors.white38,
//         ),
//       ),
//     );
//   }
// }

// class OnboardingModel {
//   final String lottieFile;
//   final String title;
//   final String subtitle;

//   OnboardingModel(this.lottieFile, this.title, this.subtitle);
// }

// List<OnboardingModel> tabs = [
//   OnboardingModel(
//     'assets/splash/images.jpg',
//     'Choose A Tasty',
//     'When you order Eat Street , \nwe\'ll hook you up with exclusive \ncoupons.',
//   ),
//   OnboardingModel(
//     'assets/splash/images1.jpg',
//     'Discover Places',
//     'We make it simple to find the \nfood you crave. Enter your \naddress and let',
//   ),
//   OnboardingModel(
//     'assets/splash/images2.jpg',
//     'Pick Up Or',
//     'We make food ordering fast ,\n simple and free - no matter if you \norder',
//   ),
// ];
