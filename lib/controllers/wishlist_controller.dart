import 'package:get/get.dart';
import 'package:mini_ecommerce/db/local/db_helper.dart';

class WishlistController extends GetxController {
  RxBool isAdded = false.obs;
  var isdata;

  // Define allNotes as an RxList
  RxList<Map<String, dynamic>> allNotes = <Map<String, dynamic>>[].obs;

  DbHelper? dbRef;

  @override
  void onInit() {
    super.onInit();
    dbRef = DbHelper.getInstance;
    getNotes();
  }

  // Fetch notes from the database and update allNotes
  void getNotes() async {
    allNotes.value = await dbRef!.getAllNotes();
  }

  isExsist(String id) async {
    isdata = await dbRef!.findUserById(id);
  }

  bool isFound(id) {
    var item = allNotes.where((item) => item["key"] == id);

    if (item.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future wishlist(
      {String? title,
      String? price,
      double? rating,
      String? image,
      String? key}) async {
    bool check = await dbRef!.addCard(
        title: title!,
        price: price!,
        image: image!,
        rating: rating!,
        key: key!);
    if (check) {
      getNotes();
      print("Card Added to your wishlist");
      Get.snackbar("Success", "Item Added to your wishlist");
    } else {
      {
        Get.snackbar("Error", "Something went wrong.");
      }
    }
  }

  Future removedFromWishList({String? key}) async {
    var item = allNotes.where((item) => item["key"] == key);
    print(item);
    if (item.isNotEmpty) {
      bool check =
          await dbRef!.deleteNote(sNo: item.first[dbRef!.COLUMN_CARD_SNO]);
      if (check) {
        getNotes();
        print("Card Removed to your wishlist");
        Get.snackbar("Success", "Item Removed to your wishlist");
      } else {
        {
          Get.snackbar("Error", "Something went wrong.");
        }
      }
    }
  }
}
