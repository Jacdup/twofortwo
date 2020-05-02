import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/utils/routing_constants.dart';


class AvailableList extends StatefulWidget {

  final List<String> chosenCategories;
  final List<ItemAvailable> allItems;
  final String name;

  AvailableList({this.chosenCategories, this. allItems, this.name});

  @override
  _AvailableListState createState() => _AvailableListState();
}

class _AvailableListState extends State<AvailableList> {
  final _itemFont = const TextStyle(fontSize: 15.0);
  List<bool> _infoShow = [];

  void _toggleDropdown(int num) {
    setState(() {
      _infoShow[num] = !_infoShow[num];
    });
  }

  @override
  Widget build(BuildContext context) {

    var numItems = widget.allItems.length;
    for (var i = 0; i <= numItems; i++){
      _infoShow.add(false) ;
    }
    return _buildBorrowList(widget.chosenCategories, widget.allItems, widget.name);
  }

  Widget _buildBorrowList(List<String> chosenCategories, List<ItemAvailable> allItems, String name) {

    double _buildBox = 0;

    return allItems.isEmpty ? Center(child: Text("No items"),) : ListView.separated(
      key: PageStorageKey<String>(name), // Keeps track of scroll position
      padding: const EdgeInsets.all(10.0),
      itemCount: allItems.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == allItems.length -1){
          _buildBox = 80;
        }
        return _buildRow(allItems[index], index, _buildBox);

      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );

  }

  Widget _buildRow(ItemAvailable item, int num, double buildBox) {
    String category = item.category;
    String itemName = item.itemName;
    String description = item.description;
    String date = item.date;
    // final bool alreadySaved = _saved.contains(pair);
    return Hero(
      tag: "row$num",
      child: Card(
        margin: EdgeInsets.fromLTRB(0, 0, 0, buildBox),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: 4.0,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                itemName,
                style: _itemFont,
              ),
              subtitle: Text(
                description,
              ),
              trailing: Text(
                date,
              ),
              onTap: () {
                _toggleDropdown(num);
              },
            ),

            Visibility(
              visible: _infoShow[num] ,
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('Willing to help'),
                    onPressed: () {/* send ping to item user, with thisUser info */
                      _confirmHelp(context);},
                  ),
                  FlatButton(
                    child: const Text('Contact'),
                    onPressed: () {
                      print("row$num");
                      Navigator.pushNamed(context, getItemInfoRoute, arguments: num,);},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _confirmHelp(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirmation"),
          content: new Text("This will send your contact details to the user that requested this item. Proceed?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () async {
                //TODO
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
    // return false;
    //return true;
  }
}