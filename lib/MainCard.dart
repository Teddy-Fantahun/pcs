import 'package:flutter/material.dart';
import 'package:pcs/DescriptionPage.dart';

import 'TextStyles.dart';
class MainCard extends StatefulWidget {
  const MainCard(this.description,{Key key}) : super(key: key);
  final DescriptionPage description;

  @override
  _MainCardState createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      child: ListTile(
        leading: Icon(Icons.info, color: Colors.blue,),
        title: Text(widget.description.title, style: TextStyles.myDefaultStyle,),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    widget.description),
          );
        },
      ),
    );
  }
}
