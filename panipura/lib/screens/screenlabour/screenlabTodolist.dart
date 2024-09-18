import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/l10n/l10n.dart';
import 'package:panipura/provider/locale_provider.dart';
import 'package:panipura/widgets/calenderwidget/eventeditingpage.dart';
import '../../widgets/calenderwidget/calenderWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScreenLabTodoList extends StatefulWidget {
  const ScreenLabTodoList({super.key});

  @override
  State<ScreenLabTodoList> createState() => _ScreenLabTodoListState();
}

class _ScreenLabTodoListState extends State<ScreenLabTodoList> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return Stack(
      children: [
        const Screensbackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBar(
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const Screenlabhome(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 158, 89, 248),
                    )),
              ),
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context)!.todolist,
                style: L10n.getappbarSize(locale.languageCode),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50))),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: const SafeArea(child: CalenderWidget()),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Appcolors.labelclr,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const EventEditingPage())),
              child: const Icon(Icons.add, color: Colors.white)),
        ),
      ],
    );
  }
}
