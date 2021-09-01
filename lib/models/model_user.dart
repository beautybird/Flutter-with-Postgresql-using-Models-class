import 'package:flutter_db/database/app_database.dart';

class ModelsUsers {
  // Register Model Section
  String futureSeller = '';
  Future<String> registerNewSeller(
      String email, String password, String mobile) async {
    futureSeller = await AppDatabase().registerSeller(email, password, mobile);

    return futureSeller;
  }

  String futureBuyer = '';
  Future<String> registerNewBuyer(
      String buyerEmail, String password, String fName, String lName) async {
    futureBuyer =
        await AppDatabase().registerBuyer(buyerEmail, password, fName, lName);
    return futureBuyer;
  }

  /// Login Model Section
  String loginFuture = '';
  Future<String> userLoginModel(String email, String password) async {
    loginFuture = await AppDatabase().loginUser(email, password);
    return loginFuture;
  }

  //Update Model Section
  String futureUpdateBuyer = '';
  Future<String> updateBuyerDetails(
      int ssnFieldValue, String mobileFieldValue) async {
    futureUpdateBuyer =
        await AppDatabase().updateBuyerData(ssnFieldValue, mobileFieldValue);

    return futureUpdateBuyer;
  }

  String sellerUpdateFuture = '';
  Future<String> updateSellerDetails(String companyFieldValue,
      String fNameFieldValue, String logoValue) async {
    sellerUpdateFuture = await AppDatabase().updateSellerData(
        companyFieldValue, fNameFieldValue, logoValue);

    return sellerUpdateFuture;
  }

  // Fetch Seller Data

  List<dynamic> sellerDataFuture = [];
  Future<List<dynamic>> fetchSellerData(String emailValue) async{
    sellerDataFuture = await AppDatabase().fetchSellerData(emailValue);
  return sellerDataFuture ;
  }
}
