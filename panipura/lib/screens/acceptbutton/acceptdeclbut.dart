// import 'package:panipura/core/hooks/hook.dart';

// class AcceptdeclButn extends StatelessWidget {
//   const AcceptdeclButn({super.key});

//   @override
//   Widget build(BuildContext context) {
//      Size size = MediaQuery.of(context).size;
//     var pro = context.read<SignupProvider>();
//     return Container(
//                           width: size.width,
//                           margin: EdgeInsets.symmetric(
//                               horizontal: size.width * 0.035),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Expanded(
//                                 child: TermsButton(
//                                     title: "Decline",
//                                     onTap: () {
//                                       pro.setAccepted(false);
//                                       Navigator.pop(context);
//                                     }),
//                               ),
//                               SizedBox(
//                                 width: size.width * 0.05,
//                               ),
//                               Expanded(
//                                 child: TermsButton(
//                                   isAccepted: true,
//                                   title: "Accept",
//                                   onTap: () {
//                                     pro.setAccepted(true);
//                                     Navigator.pop(context);
//                                     print("liked");
//                                   },
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: size.width * 0.15,
//                               ),
//                             ],
//                           ));
//   }
// }
