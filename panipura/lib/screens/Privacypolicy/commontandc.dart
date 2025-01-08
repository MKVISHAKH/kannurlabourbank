import 'package:panipura/core/hooks/hook.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panipura/l10n/l10n.dart';
import 'package:panipura/provider/locale_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ScreenCommonTandC extends StatefulWidget {
  const ScreenCommonTandC({super.key});

  @override
  State<ScreenCommonTandC> createState() => _ScreenCommonTandCState();
}

class _ScreenCommonTandCState extends State<ScreenCommonTandC> {

  WebViewController tandccontroller = WebViewController();
  Locale? localecode;
  Future<void> webViewFuture = Future.delayed(const Duration(seconds: 3));
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
     initializedata(); 
      
     buildwebloading(); 
    });
    
    super.initState();
    
  }

  void initializedata() {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    localecode = provider.locale;
  }



  void buildwebloading(){
    if(localecode==Locale('ml')){
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController tccontroller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features
    tccontroller
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(
        Uri.parse('https://kannurlabourbank.com:549/thozhil-admin/public/terms_conditions_ml'));

        // #docregion platform_features
    if (tccontroller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (tccontroller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    tandccontroller = tccontroller;
       
    }else{
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController tccontroller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features
    tccontroller
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(
        Uri.parse('https://kannurlabourbank.com:549/thozhil-admin/public/terms_conditions'));

        // #docregion platform_features
    if (tccontroller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (tccontroller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    tandccontroller = tccontroller;
    // tandccontroller
    // ..setJavaScriptMode(JavaScriptMode.unrestricted)
    // ..loadRequest(
    //     Uri.parse('https://kannurlabourbank.com:549/thozhil-admin/public/terms_conditions'));
    }
    
  }
  
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                        Navigator.of(context).pop();
                        // Navigator.pushReplacement(_scaffoldKey.currentContext!,
                        //     Approutes().homeScreen);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Appcolors.fontclr,
                      )),
                ),
              centerTitle: true,
              title: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.tandc,
                    style: L10n.getappbarSize(locale.languageCode),
                  ),
                  Text(
                    "Last Updated:JAN 01,2024",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 47, 3, 100),
                        fontSize: size.height * 0.015),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50))),
            ),
          ),
          extendBodyBehindAppBar: true,

          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: FutureBuilder(
                future: webViewFuture,
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Appcolors.magenta,
                          backgroundColor: Colors.white,
                          strokeWidth: 4.0,
                      ),
                    );
                }else{
                  return WebViewWidget(
                  controller: tandccontroller,
                );
                }
                
                }
                
              ),
            ),
          ),
          //bottomNavigationBar: acceptdeclButn(),
        ),
        ),
      ],
    );
  }
}
