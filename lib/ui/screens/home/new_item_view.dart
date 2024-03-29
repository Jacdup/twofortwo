import 'package:flutter/material.dart';
import 'package:twofortwo/shared/loading.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/screen_size.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/shared/widgets.dart';
/* This file serves as the code for adding new items as well as updating the items*/

class NewItem extends StatefulWidget {
//  final String uid;
//  final bool isTab1;
  final List<Object> uidTabItem;

  NewItem({this.uidTabItem});

  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  bool loading = false;

//  static String uid = widget.uidTab[0];

  DateTime selectedDate = DateTime.now();
  DateTime itemStartDate;
  DateTime itemEndDate;

  String updatedItemName;
  String updatedDescription;
  String itemName;
  String itemDescription;
  double itemPrice = 0;
  int itemPricePeriod = 0;
  String date;
  String title;
  String tab1Text;
  String tab2Text;
  final category = TextEditingController();
  String error = '';
  bool _doesntMatter;
  String dropdownValue = 'Per day';

//  List<Widget> tabs;
//  List<Widget> tabViews ;
//  bool _isButtonDisabled;
//  String text = "Availability";

  @override
  void initState() {
    super.initState();
//    tabs = (widget.uidTab[1] == 2) ? List(1) : List(2) ;
//    tabViews = (widget.uidTab[1] == 2) ? List(1) : List(2) ;
    _doesntMatter = false;
//    _isButtonDisabled = false;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
//    itemName.dispose();
//    itemDescription.dispose();
//    date.dispose();
    category.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loading();
    } else {
      if (widget.uidTabItem[2] == null) {
        title = "Add item";
        return _tabView();
      } else {
        title = "Update Item";
        return _updateView();
      }
    }
  }

  Widget _updateView() {
    return Scaffold(
      backgroundColor: customBlue5,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight(context, dividedBy: 5)),
        child: AppBar(
          //leading:  BackButton(onPressed: (){Navigator.pop(context);}),
          //automaticallyImplyLeading: true,
          elevation: 0.0,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.all(8.0),
            centerTitle: true,
            title: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: titleFont,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: _createFields("Dates", _formKey1, widget.uidTabItem[2], 1),
    );
  }

  Widget _tabView() {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.uidTabItem[1] == 1 ? 1 : 0,
      child: Scaffold(
          backgroundColor: customBlue5,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight(context, dividedBy: 5)),
            child: AppBar(
              //automaticallyImplyLeading: false,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.all(8.0),
                centerTitle: true,
                title: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,
                        style: titleFont,
                      ),
                    ],
                  ),
                ),
              ),
              bottom: TabBar(
                indicatorColor: customYellow2,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 4.0,
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.black38,
                tabs: //tabs,
                    [
                  new Tab(text: "Post an item"),
                  new Tab(text: "Request an item"),
                ],
              ),
            ),
          ),
          body: new TabBarView(
            children: //tabViews,
                <Widget>[
              _createFields('Dates available', _formKey2, null, 4),
              _createFields('Requested usage date', _formKey1, null, 4),
            ],
          )),
    );
  }

  Widget _createFields(
      String dateDescription, GlobalKey type, dynamic item, double width) {


    if (item != null) {
      itemName = item.itemName;
      itemDescription = item.description;
      if (item.price != null){
        itemPrice = item.price;
        itemPricePeriod = item.pricePeriod;
      }
      if ((itemStartDate == null) && (itemEndDate == null) && (item.startDate != null) && (item.startDate != "null")) {
        // TODO: check where this null value becomes a string
        itemStartDate = DateTime.parse(item.startDate);
        itemEndDate = DateTime.parse(item.endDate);
      }
    }
    final ButtonStyle dateButtonStyle = ElevatedButton.styleFrom(elevation: 4.0,
                              padding: itemStartDate == null
                                  ? EdgeInsets.fromLTRB(16.0, 8, 16.0, 8.0)
                                  : EdgeInsets.fromLTRB(4.0, 8, 4.0, 8.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                              primary: _doesntMatter == true
                                  ? Colors.grey
                                  : Colors.white70,);

    return Form(
      key: type, // Keep track of form
      child: SingleChildScrollView(
        child: Container(
          width: screenWidth(context, dividedBy: width),
          margin: EdgeInsets.fromLTRB(20.0, 10, 20.0, 10.0),
          child: Column(
            children: <Widget>[
//              SizedBox(height: 20.0),
              /*-------------------*/
              // Title
              /*-------------------*/
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Item Name", style: titleDescriptionFont),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    initialValue: itemName ?? "",
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) {
                      setState(() {
                        itemName = val;
                        updatedItemName = val;
                      });
                    },
                    decoration: textInputDecoration.copyWith(
                        hintText: 'e.g. "Mountain bike"',
                        hintStyle: itemBodyFont),
                  ),
                ],
              ),
              /*-------------------*/
              // Description
              /*-------------------*/
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Description",
                      style: titleDescriptionFont,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      initialValue: itemDescription ?? "",
                      validator: (val) =>
                          val.isEmpty ? 'Please provide a description' : null,
                      keyboardType: TextInputType.multiline,
                      onChanged: (val) {
                        setState(() {
                          itemDescription = val;
                          updatedDescription = val;
                        });
                      },
                      textAlignVertical: TextAlignVertical.top,
                      minLines: 2,
                      maxLines: 8,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'e.g. "Giant 29inch wheels"',
                          hintStyle: itemBodyFont),
//                      maxLines: null,
                    ),
                  ],
                ),
              ),

              /*-------------------*/
              // Dates
              /*-------------------*/
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    dateDescription,
                    style: titleDescriptionFont,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16.0)),
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ElevatedButton(style: dateButtonStyle,
                              onPressed: () => _doesntMatter == true
                                  ? null
                                  : _datePicker(context, true),
                              child: Text(
                                itemStartDate == null
                                    ? "Start Date"
                                    : "${itemStartDate.toString().split(' ')[0]}",
                                style: textFont,
                              ),
                            ),
                            Spacer(),
                            //SizedBox(width: 8.0,),
                            Text(
                              "to",
                              style: textFont,
                            ),
                            Spacer(),
                            // SizedBox(width: 8.0,),
                           ElevatedButton(style: dateButtonStyle,
                              onPressed: () => _doesntMatter == true
                                  ? null
                                  : _datePicker(context, false),
                              child: Text(
                                itemEndDate == null
                                    ? "End Date"
                                    : "${itemEndDate.toString().split(' ')[0]}",
                                style: textFont,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              " Doesn't matter",
                              style: textFont,
                            ),
                            Checkbox(
                              value: _doesntMatter,
                              tristate: false,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _doesntMatter = newValue;
//                                _isButtonDisabled = !_isButtonDisabled;
//                                print(_isButtonDisabled);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              /*-------------------*/
              //Price
              /*-------------------*/
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Row(
                      children: <Widget>[
                        Text(
                          "R",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Container(
                          width: screenWidth(context)/2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            enabled: itemPricePeriod != 0,
                            initialValue: itemPrice.round().toString(),
                            validator: (val) => (val.isEmpty && itemPricePeriod != 0) ? 'Please set an asking price.' : null,
                            onChanged: (val) {
                              setState(() {
                                itemPrice = double.parse(val);
                              });
                            },
                            decoration: textInputDecoration.copyWith(
                                hintText: '', hintStyle: itemBodyFont),
                          ),
                        ),
                        Spacer(),
                        _buildDropDown(),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
//              Container(
//                child: IconButton(onPressed: (){print(widget.uidTab[1]);},icon: Icon(Icons.add_photo_alternate),iconSize: 40.0,color: Colors.black87,),
//              ),

              _buildButton(item, type),
            ], // Children
          ),
        ),
      ),
    );
  }

  Future<Null> _datePicker(BuildContext context, bool start) async {
    DateTime endVal;
    DateTime startVal;
    // This does the job of validation for startDate < endDate
    if (start == false) {
      endVal = DateTime(2101);
      itemStartDate == null
          ? startVal = DateTime.now()
          : startVal =
              itemStartDate; // Value can't be smaller than itemStartDate
    } else {
      startVal = DateTime.now();
//        itemEndDate == null ? startVal = DateTime.now() : startVal = itemEndDate;
      itemEndDate == null
          ? endVal = DateTime(2101)
          : endVal =
              itemEndDate; // Value can't be larger than itemEndDate
    }
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: startVal,
      firstDate: startVal,
      lastDate: endVal,
    );
    if (picked != null && picked != selectedDate){
      setState(() {
        (start == true) ? itemStartDate = picked : itemEndDate = picked;
//        selectedDate = picked;
      });
     }
  }

  _buildDropDown() {
    return DropdownButton<String>(
      value: pricePeriod[itemPricePeriod],
      icon: Icon(Icons.keyboard_arrow_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color:textColor),
      underline: Container(
        height: 2,
        color: textColor,
      ),
      onChanged: (String newValue) {
        setState(() {
          //dropdownValue = newValue;
          print("!!!!!");
          print(newValue);
          itemPricePeriod = pricePeriod.indexOf(newValue);
        });
      },
      items: pricePeriod.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  _buildButton(dynamic item, GlobalKey type) {
//    (type == _formKey1) ? ButtonWidget(icon: Icons.navigate_next, onPressed: onPressedBtn1)
//        : ButtonWidget(icon: Icons.navigate_next, onPressed: onPressedBtn2),

    if (item != null) {
      return ButtonWidget(
          icon: Icons.navigate_next, onPressed: onPressedBtnUpdate);
    } else {
      if (type == _formKey1)
        return ButtonWidget(
            icon: Icons.navigate_next, onPressed: onPressedBtnRequested);
      else {
        return ButtonWidget(
            icon: Icons.navigate_next, onPressed: onPressedBtnAvailable);
      }
    }
  }

//  onPressedBtnUpdate(dynamic item, bool itemType) async {
  onPressedBtnUpdate() async {
    String newDescription;
    String newItemName;
    //int itemPrice = 0;

    if (_formKey1.currentState.validate()) {
      updatedDescription == null
          ? newDescription = itemDescription
          : newDescription = updatedDescription;
      updatedItemName == null
          ? newItemName = itemName
          : newItemName = updatedItemName;

      if (widget.uidTabItem[1] == true) {
        ItemAvailable oldItem = widget.uidTabItem[2];
        ItemAvailable newItem = new ItemAvailable(
            null,
            newItemName,
            itemStartDate.toString().split(' ')[0],
            itemEndDate.toString().split(' ')[0],
            newDescription,
            widget.uidTabItem[0],
            oldItem.docRef,
            DateTime.now(),
            true,
            itemPrice,
        itemPricePeriod);
        Navigator.pushReplacementNamed(context, CategoryRoute,
            arguments: [newItem, widget.uidTabItem[1]]);
      } else {
        Item oldItem = widget.uidTabItem[2];
        Item newItem = new Item(
            null,
            newItemName,
            itemStartDate.toString().split(' ')[0],
            itemEndDate.toString().split(' ')[0],
            newDescription,
            widget.uidTabItem[0],
            oldItem.docRef,
            DateTime.now(),
            true,
            itemPrice,
            itemPricePeriod);
        Navigator.pushReplacementNamed(context, CategoryRoute,
            arguments: [newItem, widget.uidTabItem[1]]);
      }
    }
  }

  onPressedBtnRequested() async {
    if (_formKey1.currentState.validate()) {
      Item newItem = new Item(
          null,
          itemName,
          itemStartDate.toString().split(' ')[0],
          itemEndDate.toString().split(' ')[0],
          itemDescription,
          widget.uidTabItem[0],
          '1',
          DateTime.now(),
          true,
          itemPrice,
          itemPricePeriod);
      Navigator.pushReplacementNamed(context, CategoryRoute,
          arguments: [newItem]);
    }
  }

  onPressedBtnAvailable() async {
    if (_formKey2.currentState.validate()) {
      print(itemPrice);
      ItemAvailable newItem = new ItemAvailable(
          null,
          itemName,
          itemStartDate.toString().split(' ')[0],
          itemEndDate.toString().split(' ')[0],
          itemDescription,
          widget.uidTabItem[0],
          '2',
          DateTime.now(),
          true,
          itemPrice,
          itemPricePeriod);
      print(newItem);
      Navigator.pushReplacementNamed(context, CategoryRoute,
          arguments: [newItem]);
    }
  }
}
