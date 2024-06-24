import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/aboutprovider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/about';

  final String title;

  const AboutScreen(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => AboutProvider(), child: About(title));
  }
}

class About extends StatefulWidget {
  final String title;

  const About(this.title, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AboutScreenState();
}

class AboutScreenState extends State<About> {
  bool initialState = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (initialState) {
      getContent();
      initialState = false;
    }
    super.didChangeDependencies();
  }

  void getContent() async {
    try {
      setState(() {
        isLoading = true;
        EasyLoading.show(status: 'Loading..', maskType: EasyLoadingMaskType.black);
      });
      await Provider.of<AboutProvider>(context).getContent(widget.title);
      setState(() {
        isLoading = false;
        EasyLoading.dismiss();
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        EasyLoading.dismiss();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AboutProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            provider.content['title']!,
            style: Styles.styleHeader,
          ),
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Visibility(
                visible: isLoading,
                // child: Html(
                //   style: {
                //     "body":
                //         Style(color: Colors.white, fontSize: FontSize.medium)
                //   },
                //   data: provider.content['description']!,
                // ),
                child: Card(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: ExpandableTheme(
                      data: const ExpandableThemeData(
                        iconPadding: EdgeInsets.all(0),
                        iconColor: Color(0xff635F54),
                        tapHeaderToExpand: true,
                        animationDuration: Duration(milliseconds: 500),
                      ),
                      child: ExpandablePanel(
                        header: Text(
                          provider.content['title']!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff635F54),
                          ),
                        ),
                        collapsed: Html(
                          shrinkWrap: true,
                          style: {'body': Style(color: Colors.black, fontSize: FontSize.medium, maxLines: 1)},
                          data: provider.content['description'],
                        ),
                        expanded: Html(
                          shrinkWrap: true,
                          style: {'body': Style(color: Colors.black, fontSize: FontSize.medium)},
                          data: provider.content['description'],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
