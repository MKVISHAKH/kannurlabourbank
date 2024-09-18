// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:panipura/core/hooks/hook.dart';

// final _scaffoldKey = GlobalKey<ScaffoldState>();
// final _formkey = GlobalKey<FormState>();
//  Future showRatingpopup(BuildContext context,Getskillreq editval) async{

//     // final _placeEditingController=TextEditingController();
//     double rating=0;

//     showDialog(
//       barrierDismissible:false,
//       context: context,
//        builder:(ctx){
//         return SimpleDialog(
//           key:_scaffoldKey,
//           title:const Center(
//             child:  Text(
//               "Rate My Work",
//               style: TextStyle(color: Color.fromARGB(255, 101, 47, 248)),
//               ),
//               ),
//           children: [
//               RatingBar.builder(
//                 minRating: 1,
//                 itemBuilder: (context,_)=>const Icon(Icons.star,color:Color.fromARGB(255, 158, 89, 248)),
//                  onRatingUpdate: (rating)=>setState(){}
//                  ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 20),
//                 child:Center(
//                   child: Row(
//                     // crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                           ElevatedButton(
//                             style:ElevatedButton.styleFrom(
//                               backgroundColor:const Color.fromARGB(255, 158, 89, 248),
//                             ),
//                             onPressed: (){
//                               Navigator.of(ctx).pop();
//                             },
//                             child:const Text('Cancel',style:TextStyle(color: Colors.white))),
//                            const SizedBox(width:10),
//                            ElevatedButton(
//                             style:ElevatedButton.styleFrom(
//                               backgroundColor:const Color.fromARGB(255, 158, 89, 248),
//                             ),
//                             onPressed: (){

//                             },
//                             child:const Text('Submit',style:TextStyle(color: Colors.white)))
//                     ],),
//                 ),
//               )
//           ],
//         );
//        }
//        );
// }

// Future buildedithmtwn(BuildContext context,Edithmtwnreq val)async{
//  final editresp=await Labourdata().edithometwn(val);
//       print(editresp);
//      if(editresp!.statusCode==200){
//         final _resultAsjson = jsonDecode(editresp.data);
//         final searchval= Edithmtwnresp.fromJson(_resultAsjson as Map<String, dynamic>);
//             final place=searchval.place;
//             final value = await Sharedata.instance.getdata();
//             final usrID=value!.userid;
//             final token=value.token;
//             final name=value.name;
//             final mobile=value.mobile;
//             final address=value.address;
//             final adhaar=value.aadhaar;
//             final post=value.post;
//             final pincode=value.pin;
//             final gender=value.gender;
//             final district=value.district;
//             final block=value.block;
//             final localbody=value.localbody;
//             final dob=value.dob;
//             final education=value.education;
//             final category=value.category;
//             final passwrd=value.password;
//             final sharedval=SharedtokenM.values(
//               userid: usrID,
//               token: token,
//                name: name,
//                 mobile: mobile,
//                 address:address,
//                     place:place,
//                     post:post,
//                     pin:pincode,
//                     gender:gender,
//                     district:district,
//                     block:block,
//                     localbody:localbody,
//                     dob:dob,
//                     aadhaar:adhaar,
//                     education:education,
//                     category:category,
//                     password:passwrd
//                 );
//              await Sharedata.instance.setdata(sharedval);
//              final status=searchval.success;

//             final message=searchval.message;
//             Fluttertoast.showToast(
//             msg: message!,
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.green,
//             textColor: Colors.white,
//             fontSize: 16.0
//             );
//             if(status==true){
//              Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
//                                MaterialPageRoute(
//                                  builder: (context) => ScreenLabProfile(usrId:val.userId ,token:val.token,),
//                                 ),
//                               );
//             }
//              }
//          else if(editresp.statusCode==404){
//             // final _resultAsjson = jsonDecode(editresp.data);
//             //   final searchval= Deleteresp.fromJson(_resultAsjson as Map<String, dynamic>);
//             //       final message=searchval.message;
//             Fluttertoast.showToast(
//             msg:'Something went wrong',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0
//             );
//             Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
//                                MaterialPageRoute(
//                                  builder: (context) => ScreenLabProfile(usrId: val.userId,token: val.token,),
//                                 ),
//                               );
//     }else{
//         Fluttertoast.showToast(
//             msg: "Server not reached",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0
//             );
//             Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
//                                MaterialPageRoute(
//                                  builder: (context) => ScreenLabProfile(usrId: val.userId,token:val.token),
//                                 ),
//                               );
//     }
// }
