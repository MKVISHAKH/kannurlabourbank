// import 'package:flutter/material.dart';
// import 'package:panipura/screens/screenhome.dart';
// import 'package:panipura/widgets/screensbackground.dart';

// import '../../widgets/stylefamily.dart';
// //import '../widgets/stylefamily.dart';

// class ScreenLabour extends StatelessWidget {
//   const ScreenLabour({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//       const  Screensbackground(),
//       Scaffold(
//          backgroundColor: Colors.transparent,
//          appBar: PreferredSize(
//           preferredSize:const Size.fromHeight(120),
//           child: AppBar(
//             leading:  IconButton(onPressed: (){
//                       Navigator.of(context).pushReplacement(
//                            MaterialPageRoute(
//                              builder: (context) =>const ScreenHome(),
//                             ),
//                           );
//                     },
//                      icon:const Icon(Icons.arrow_back)),
//             centerTitle: true,
//             title:const Text("LABOUR",style: kBoldText,),
//             backgroundColor:const Color.fromARGB(255, 148, 15, 224) ,
//             shape:const RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50)
//               )
//             ),
//           ),
//           ),
//           extendBodyBehindAppBar: true,
//         body:SingleChildScrollView(
//           child: SafeArea(
//             child:Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [

//                     const SizedBox(height: 100,),
//                    SizedBox(
//                       width:MediaQuery.of(context).size.width,
//                       child:const Center(child: Text("Are you a Registered Labour",style: kscreenText,),
//                       ),
//                    ),
//                    SizedBox(
//                       width:MediaQuery.of(context).size.width,
//                       child:const Center(child: Text("then",style: kscreenText,),
//                       ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: ElevatedButton(
//                          onPressed: (){
//                                         Navigator.of(context).pushReplacement(
//                                               MaterialPageRoute(
//                                                 builder: (ctx) =>const  ScreenLabour(),
//                                               ),
//                                             );
//                                   },
//                         style:ElevatedButton.styleFrom(
//                         side:const BorderSide(
//                           width: 3.0,
//                           color:Color.fromARGB(255, 2, 64, 116),
//                         ),
//                         backgroundColor:const Color.fromARGB(255, 44, 110, 185),
//                         fixedSize:const Size(200, 80),
//                         shape:RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15)
//                         ),
//                         ),
//                         child:const  Center(child: Text("LOGIN",textAlign: TextAlign.center,style:kButtonText)),),
//                    ),
//                     const SizedBox(height: 100,),
//                    SizedBox(
//                       width:MediaQuery.of(context).size.width,
//                       child:const Center(child: Text("If not Registered",style: kscreenText,),
//                       ),
//                    ),
//                    SizedBox(
//                       width:MediaQuery.of(context).size.width,
//                       child:const Center(child: Text("then",style: kscreenText,),
//                       ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: ElevatedButton(
//                          onPressed: (){
//                                         Navigator.of(context).pushReplacement(
//                                               MaterialPageRoute(
//                                                 builder: (ctx) =>const  ScreenLabour(),
//                                               ),
//                                             );
//                                   },
//                         style:ElevatedButton.styleFrom(
//                         side:const BorderSide(
//                           width: 3.0,
//                           color:Color.fromARGB(255, 2, 64, 116),
//                         ),
//                         backgroundColor:const Color.fromARGB(255, 7, 170, 61),
//                         fixedSize:const Size(200, 80),
//                         shape:RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15)
//                         ),
//                         ),
//                         child:const  Center(child: Text("REGISTER",textAlign: TextAlign.center,style:kButtonText)),),
//                    ),

//               ],
//             ),),
//         )
//       ),
//       ],
//     );
//   }
// }
