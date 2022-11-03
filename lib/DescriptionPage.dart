import 'package:flutter/material.dart';

import 'TextStyles.dart';
class DescriptionPage extends StatefulWidget {
  const DescriptionPage(this.title,this.imagePath,this.content);
  final String title;
  final String imagePath;
  final String content;

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.1,
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover),
        ),
        child: ListView(
          children: [
            Image.asset(widget.imagePath),
            GenerateSimpleCardForText(widget.content)
          ],
        ),
      ),
    );
  }
}

class GenerateSimpleCardForText extends StatefulWidget {
  const GenerateSimpleCardForText(this.text, {Key key}) : super(key: key);
  final String text;

  @override
  _GenerateSimpleCardForTextState createState() =>
      _GenerateSimpleCardForTextState();
}

class _GenerateSimpleCardForTextState extends State<GenerateSimpleCardForText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white.withOpacity(0.9),
        child: ListTile(
          title: Text(
            widget.text,
            textAlign: TextAlign.justify,
            style: TextStyles.myDefaultStyle,
          ),
          contentPadding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
