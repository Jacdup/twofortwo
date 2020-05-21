
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/main.dart';
import 'package:twofortwo/services/category_service.dart';
import 'package:twofortwo/services/database.dart';
import 'package:twofortwo/services/item_service.dart';

/*
This is to keep the 'business' logic separate from the widget construction.
* Here I do all the calls to the database service, and update ValueNotifier
* 'loading' to change the state
*/
class ButtonPresses{


  onSelectRequestedItemCategories(String uid, Item item,
      List<String> selectedCategories) async {
//      loading.value = true;
////      newItem = new Item(null, itemName, description, date, null, null); //TODO, send to category route
////      Navigator.pushReplacementNamed(context,CategoryRoute);
//
//    // TODO, this in category view
    dynamic result = await DatabaseService(uid: uid).addItemRequestedData(
        item.itemName, item.description, item.date, selectedCategories,
        item.createdAt);
//
    if (result == null) {
      Fluttertoast.showToast(msg: 'Success! Item added.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
//          error = 'Could not add item, please check details';
      loading.value = false;
    } else {
      Fluttertoast.showToast(msg: 'Hmm. Something went wrong.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
//        Navigator.pop(context);
    }
//    Navigator.pop(context);

  }


  onSelectAvailableItemCategories(String uid, ItemAvailable item,
      List<String> selectedCategories) async {
//      loading.value = true;
//
////      newItem = new Item(_selectedCategory, itemName, date, description);
    dynamic result = await DatabaseService(uid: uid).addItemAvailableData(
        item.itemName, item.description, item.date, selectedCategories,
        item.createdAt);

    if (result == null) {
      Fluttertoast.showToast(msg: 'Success! Item added.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
      loading.value = false;
    } else {
      Fluttertoast.showToast(msg: 'Hmm. Something went wrong.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
    }
//

  }


  onUpdateCategories(BuildContext context, String uid, List<String> selectedCategories) async {
    loading.value = true; // Should do the job of setState
    var categories = Provider.of<CategoryService>(context, listen: false);
    categories.updateWith(selectedCategories);
//    CategoryService thisCat = CategoryService();
//   CategoryService().updateWith(selectedCategories); // Notifies listeners
//    thisCat.updateWith(selectedCategories);
//    print(thisCat.userCategories);

    dynamic result = await DatabaseService(uid: uid).updateCategory(
        selectedCategories);

//                      storageService.hasSignedUp = true;
//                      storageService.category = _selectedCategories;
//                      print(_selectedCategories);
//                      print(storageService.category);

    if (result == null) {
      loading.value = false;
//    setState(() {
      Fluttertoast.showToast(
          msg: 'Successfully updated categories.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
//                  error = 'Could not sign in, please check details';
//      loading.value = false;
//    });
    } else {
      Fluttertoast.showToast(
          msg: 'Hmm. Something went wrong.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
    }
//  Navigator.pop(context);
  }

  onSendMessage(String messageUid, String documentRef, String messagePayload,
      String datePayload, bool type) async {
    dynamic result = await DatabaseService(uid: messageUid).contactItemOwner(
        documentRef, messagePayload, datePayload, type);
    if (result == null) {
      loading.value = false;
//    setState(() {
      Fluttertoast.showToast(
          msg: 'Successfully sent message.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
//                  error = 'Could not sign in, please check details';
//      loading.value = false;
//    });
    } else {
      Fluttertoast.showToast(
          msg: 'Hmm. Something went wrong.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
    }
  }

}