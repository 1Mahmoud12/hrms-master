import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class RulesCardView extends StatelessWidget {
  final String title;
  final String description;

  const RulesCardView(this.title, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),),
      elevation: 0,
      color: Colors.white,
      child: Container(
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
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff635F54),
              ),
            ),
            collapsed: Html(
              shrinkWrap: true,
              style: {
                'body': Style(
                    color: Colors.black, fontSize: FontSize.medium, maxLines: 1,),
              },
              data: description,
            ),
            expanded: Html(
              shrinkWrap: true,
              style: {
                'body': Style(color: Colors.black, fontSize: FontSize.medium),
              },
              data: description,
            ),
          ),
        ),
      ),
    );
  }
}
