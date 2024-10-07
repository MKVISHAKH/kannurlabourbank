
import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/l10n/l10n.dart';
import 'package:panipura/provider/locale_provider.dart';
import 'package:panipura/screens/screenemployer/Screenemprprofile.dart';
import 'package:panipura/widgets/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ScreenDeleteAccount extends StatefulWidget {
  final int? usrId;
  final String? token;
  final int? category;
  const ScreenDeleteAccount({super.key,required this.usrId, required this.token,required this.category});

  @override
  State<ScreenDeleteAccount> createState() => _ScreenDeleteAccountState();
}

class _ScreenDeleteAccountState extends State<ScreenDeleteAccount> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Locale? localecode;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializedata();      
    });
    
    super.initState();
    
  }

  void initializedata() {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    localecode = provider.locale;
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return Stack(
      children: [
        const Screensbackground(),
        Scaffold(
          key: _scaffoldKey,
           backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBar(
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: IconButton(
                    onPressed: () {
                      if(widget.category==lab){
                        Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>ScreenLabProfile(usrId: widget.usrId, token: widget.token),
                        ),
                      );
                      }else if(widget.category==emp){
                        Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>const ScreenEmpProfile(),
                        ),
                      );
                      }
                      
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 158, 89, 248),
                    )),
              ),
              centerTitle: true,
              title: Text(
               AppLocalizations.of(context)!.deleteac,
                    style: L10n.getappbarSize(locale.languageCode),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(

                      borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(50))
                      
                      ),
            ),
          ),
          body:Center(
            child: ListView(
              
              children: [
                Padding(
               padding:const  EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
               child:  Row(
                  
                  children: [
                 const Icon(Icons.warning_outlined,color:Colors.red),
                 const SizedBox(width: 10),
                  Flexible(
                    child: Text(AppLocalizations.of(context)!.dltaccount,
                    softWrap: true,
                    style: const TextStyle(color:Colors.red,
                    fontWeight: FontWeight.w500,fontSize: 20),),
                  )
                ],),
             ),
                Padding(
                  padding:const  EdgeInsets.only(left:30.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                      const  TextSpan(
                          text: '• ',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.cautionone,
                          
                          style:const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                    softWrap: true,
                  ),
                ),
                 Padding(
                  padding:const  EdgeInsets.only(left:30.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                       const TextSpan(
                          text: '• ',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.cautiontwo,
                          style:const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        
                      ],
                    ),
                    softWrap: true,
                  ),
                ),
                Padding(
                  padding:const  EdgeInsets.only(left: 30.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: '• ',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.cautionthree,
                          style:const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        
                      ],
                    ),
                    softWrap: true,
                  ),
                ),
                Padding(
                  padding:const  EdgeInsets.only(left:30.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: '• ',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.cautionfour,
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        
                      ],
                    ),
                    softWrap: true,
                  ),
                ),
                Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      gradient:const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                         Colors.red,
                                          Colors.redAccent
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        
                                        deleteAccount(context,widget.usrId);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.deleteac,
                                        style:const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
              ],
            ),
          )
        ),
      ],
    );
  }
  deleteAccount(BuildContext context,int? usrid,) async => showDialog<bool>(
      context: context,
    //  barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 const Padding(
                    padding:  EdgeInsets.symmetric(vertical:20),
                    child: Text("Are you sure You want to delete this Account?",
                        style:
                     TextStyle(color: Colors.red)),
                  ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: Container(
                                        height: 30,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          gradient:const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color.fromARGB(255, 101, 47, 248),
                                              Colors.white
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () async {                            
                                          Navigator.pop(context, false);
                                        },
                                        style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                          child:const Text(
                                            'No',
                                            style:TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: Container(
                                        height: 30,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          gradient:const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.red,
                                              Colors.redAccent
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                              // StopFunctions.instance.deleteStop(tripid, stopid);                                        
                                              deleteacnt(context, usrid);
                                               Navigator.pop(context, false);
                                          },
                                          style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                          child:const Text(
                                            'yes',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                      ],)
                ],
              ),
              
            ),
      ));


 Future deleteacnt(BuildContext context,int? usrid)async {
  
  if(widget.category==lab){
    final deleteresp=await Labourdata().deleteuser(usrid);
    if (deleteresp == null) {
      Fluttertoast.showToast(
          msg: "something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (deleteresp.statusCode == 200) {
      final resultAsjson = jsonDecode(deleteresp.data);
      final searchval =
          Deleteresp.fromJson(resultAsjson as Map<String, dynamic>);
      final message = searchval.message;
      final status = searchval.success;
      if (status == true) {
        Fluttertoast.showToast(
            msg: message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
             await Sharedata.instance.cleardata();
              // await sharedprefs.clear();
              Navigator.of(_scaffoldKey.currentContext!).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx1) => ScreenHome()),
                   (route) => false);
                 
      } else {
        Fluttertoast.showToast(
            msg: message ?? "something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
       
      }
    } else {
      Fluttertoast.showToast(
          msg: "Server error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
     
    }
  }else if(widget.category==emp){
   final deleteresp=await Labourdata().deleteEmp(usrid);
   if (deleteresp == null) {
      Fluttertoast.showToast(
          msg: "something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (deleteresp.statusCode == 200) {
      final resultAsjson = jsonDecode(deleteresp.data);
      final searchval =
          Deleteresp.fromJson(resultAsjson as Map<String, dynamic>);
      final message = searchval.message;
      final status = searchval.success;
      if (status == true) {
        Fluttertoast.showToast(
            msg: message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
             await Sharedata.instance.cleardata();
              // await sharedprefs.clear();
              Navigator.of(_scaffoldKey.currentContext!).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx1) => ScreenHome()),
                   (route) => false);
                 
      } else {
        Fluttertoast.showToast(
            msg: message ?? "something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
       
      }
    } else {
      Fluttertoast.showToast(
          msg: "Server error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
     
    }
  }
    
    
 }    
}