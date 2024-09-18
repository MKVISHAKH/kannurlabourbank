
// import 'package:panipura/core/hooks/hook.dart';
// import 'package:panipura/widgets/constants.dart';
// import 'package:panipura/widgets/navbar.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class Screenhome extends StatefulWidget {
//   const Screenhome({super.key});
//   //final String task;
//   @override
//   State<Screenhome> createState() => _ScreenhomeState();
// }

// @override
// class _ScreenhomeState extends State<Screenhome> {
//   List<Color> colorList = [
//     const Color.fromARGB(0, 157, 14, 14),
//     const Color.fromARGB(0, 64, 193, 21),
//     const Color.fromARGB(0, 190, 92, 17),
//   ];

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//   //     getsharedata();
//   //     dashboarddata();
//   //   });

//   // }

//   Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//             title: const Text('Do you want to exit app?'),
//             actions: [
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context, false),
//                 child: const Text('No'),
//               ),
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context, true),
//                 child: const Text('Yes'),
//               ),
//             ],
//           ));
//   //bool isPressed=true;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       key: _scaffoldKey,
//       children: [
//         const Screensbackground(),
//         WillPopScope(
//           onWillPop: () async {
//             print('BackButton pressed!');
//             final shouldPop = await showWarning(context);
//             return shouldPop ?? false;
//           },
//           child: Scaffold(
//             backgroundColor: Colors.transparent,
//             drawer: const Navbar(
//               category: 3,
//             ),
//             appBar: AppBar(
//               title: Container(
//                 padding: const EdgeInsets.only(right: 55),
//                 child: const Center(
//                   child: Text(
//                     'LABOUR BANK',
//                   ),
//                 ),
//               ),
//               // flexibleSpace: const Appbarimage(),
//             ),
//             body: SingleChildScrollView(
//               child: SafeArea(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // const Screensbackground(),
//                     // SizedBox(height: 50,),
//                     Container(
//                       width: MediaQuery.of(context).size.width / 3,
//                       height: MediaQuery.of(context).size.width / 3,
//                       padding: const EdgeInsets.all(3.0),
//                       decoration: const BoxDecoration(
//                           image: DecorationImage(
//                         image: AssetImage("assets/splash/panchayath_logo.png"),
//                         fit: BoxFit.fill,
//                       )

//                           //child:const Center(child: AssetImage("assets/splash/panchayath_logo.png"),
//                           ),
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       padding: const EdgeInsets.all(3.0),
//                       child: Center(
//                         child: Text(
//                           AppLocalizations.of(context)!.homeheading1,
//                           style: kHeading,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: Center(
//                         child: Text(
//                           AppLocalizations.of(context)!.homeheading2,
//                           style: kHeaderText,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: Center(
//                         child: Text(
//                           AppLocalizations.of(context)!.homeheading3,
//                           style: klighthead,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: Center(
//                         child: Text(
//                           AppLocalizations.of(context)!.homeheading4,
//                           style: klighthead,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: Center(
//                         child: Text(
//                           AppLocalizations.of(context)!.homeheading5,
//                           style: klighthead,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: Center(
//                         child: Text(
//                           AppLocalizations.of(context)!.homeheading6,
//                           style: klighthead,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 50,
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: const Center(
//                         child: Text(
//                           "Are you a",
//                           style: kscreenText,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context).pushReplacement(
//                             MaterialPageRoute(
//                               builder: (ctx) => const ScreenLogin(
//                                 category: lab,
//                               ),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           side: const BorderSide(
//                             width: 3.0,
//                             color: Appcolors.labelclr,
//                           ),
//                           backgroundColor: Appcolors.magenta,
//                           fixedSize: const Size(200, 80),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15)),
//                         ),
//                         child: Center(
//                             child: Text(
//                                 AppLocalizations.of(context)!.buttonlabour,
//                                 textAlign: TextAlign.center,
//                                 style: kButtonText)),
//                       ),
//                     ),

//                     const SizedBox(
//                       height: 30,
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: const Center(
//                         child: Text(
//                           "Or an",
//                           style: kscreenText,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context).pushReplacement(
//                             MaterialPageRoute(
//                               builder: (ctx) => const ScreenLogin(
//                                 category: emp,
//                               ),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           side: const BorderSide(
//                             width: 3.0,
//                             color: Appcolors.labelclr,
//                           ),
//                           backgroundColor: Appcolors.magenta,
//                           fixedSize: const Size(200, 80),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15)),
//                         ),
//                         child: Center(
//                             child: Text(
//                                 AppLocalizations.of(context)!.buttonemployer,
//                                 textAlign: TextAlign.center,
//                                 style: kButtonText)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
