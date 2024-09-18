// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// //import 'package:panipura/screens/Screenregister.dart';
// //import 'package:panipura/screens/screenlabour.dart';
// import 'package:panipura/widgets/otpform.dart';

// import '../widgets/otpformscren.dart';
// import '../widgets/stylefamily.dart';
// import 'screenlabour/Screenregister.dart';

// class ScreenOtp extends StatelessWidget {
//   const ScreenOtp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:SafeArea(
//         child:
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           IconButton(onPressed: (){
//                       Navigator.of(context).pushReplacement(
//                            MaterialPageRoute(
//                              builder: (context) =>const ScreenLabourRegister(),
//                             ),
//                           );
//                     },
//                      icon:const Icon(Icons.arrow_back)),

//           SizedBox(
//                     width:MediaQuery.of(context).size.width,
//                       child:const Center(child: Text("OTP Verification",style:TextStyle(
//                                     fontFamily: 'Oswald',
//                                     fontSize: 30,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold
//                       ),),
//                   ),

//                   ) ,
//                   SizedBox(
//                     width:MediaQuery.of(context).size.width,
//                       child:const Center(child: Text("We sent your code to mobile no ***",style:kBodyText,),
//                   ),
//                   ),

//                   buildTimer(),

//                  const Center(child: Otpformscreen()),
//                  //const Text("We sent your code to mobile no ***"),
//         ],),),
//     );
//   }

//   Row buildTimer() {
//     return Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("This code will expired in ",style:kBodyText,),
//                     TweenAnimationBuilder(
//                       tween: Tween(begin:30.0,end:0),
//                        duration:const Duration(seconds:30),
//                         builder: (context,value,child)=>Text("00:${value.toInt()}",
//                         style:const TextStyle(color: Colors.red),
//                         ),
//                         onEnd: (){},
//                         ),

//                   ],
//                 );
//   }
// }
