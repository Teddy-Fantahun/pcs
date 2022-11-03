import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcs/DatabaseHelper.dart';
import 'package:pcs/EditAnExistingCandidate.dart';
import 'package:pcs/PCSCandidateDataModel.dart';

class PCSListCard extends StatefulWidget {
  const PCSListCard(this.datamodel, this.refreshPCSList);
  final PCSCandidateDataModel
      datamodel; //the data model from which the widget displays its content

  final Function
      refreshPCSList; //this function need to be passed to this child widget from its parent widget i.e. Home page
  //because this class needs to refresh the home page during some of its operations

  @override
  _PCSListCardState createState() => _PCSListCardState();
}

class _PCSListCardState extends State<PCSListCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      child: ListTile(
          leading: Icon(
            Icons.account_circle,
            size: 40,
            color: Colors.blue[800],
          ),
          title: Text(
              widget.datamodel.firstName + " " + widget.datamodel.lastName,
              style: TextStyle(color: Colors.blue[800])),
          subtitle: Text(
            'ከ' + widget.datamodel.getSelectedDate() + ' ጀምሮ',
            style: TextStyle(fontSize: 12),
          ),
          trailing: Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditAnExistingCandidate(widget.datamodel, widget.refreshPCSList)),
                      );
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.deepOrange,
                    ),
                    onPressed: () {
                      //prompt the user before deleting it
                      showCupertinoDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext) {
                            return CupertinoAlertDialog(
                              content: Text(
                                  'እርግጠኛ ነዎት ይህን ግለሰብ ከዝርዝርዎ ማስወገድ ይፈልጋሉ?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      DatabaseHelper.deleteAPCSCandidate(
                                          widget.datamodel.id);
                                      //refresh the PCS list in the home page
                                      widget.refreshPCSList();
                                      //close the pop-up alert dialog
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('አዎ', style: TextStyle(color: Colors.red),)),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('ይቅር'))
                              ],
                            );
                          });
                    },
                  )),
            ],
            mainAxisSize: MainAxisSize.min,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          )),
    );
  }
}
