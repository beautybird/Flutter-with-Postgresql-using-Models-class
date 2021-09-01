

import 'package:postgres/postgres.dart';

class AppDatabase {
  String buyerEmailValue = '';
  String sellerEmailValue = '';
  String passwordValue = '';
  String mobileValue = '';
  String companyNameValue = '';
  String landlineValue = '';
  String fNameValue = '';
  String lNameValue = '';

  PostgreSQLConnection? connection;
  PostgreSQLResult? newSellerRegisterResult, newBuyerRegisterResult;
  PostgreSQLResult? sellerAlreadyRegistered, buyerAlreadyRegistered;

  PostgreSQLResult? loginResult, userRegisteredResult;

  PostgreSQLResult? updateBuyerResult;
  PostgreSQLResult? updateSellerResult;

  static String? sellerEmailAddress, buyerEmailAddress;

  PostgreSQLResult? _fetchSellerDataResult;

  AppDatabase() {
    connection = (connection == null || connection!.isClosed == true
        ? PostgreSQLConnection(
            // for external device like mobile phone use domain.com or
            // your computer machine IP address (i.e,192.168.0.1,etc)
            // when using AVD add this IP 10.0.2.2
            '10.0.2.2',
            5432,
            'flutterdb',
            username: 'flutterdb_admin',
            password: '123456',
            timeoutInSeconds: 30,
            queryTimeoutInSeconds: 30,
            timeZone: 'UTC',
            useSSL: false,
            isUnixSocket: false,
          )
        : connection);

    fetchDataFuture = [];
  }

  // Register Database Section
  String newSellerFuture = '';
  Future<String> registerSeller(
      String email, String password, String mobile) async {
    try {
      await connection!.open();
      await connection!.transaction((newSellerConn) async {
        //Stage 1 : Make sure email or mobile not registered.
        sellerAlreadyRegistered = await newSellerConn.query(
          'select * from myAppData.register where emailDB = @emailValue OR mobileDB = @mobileValue',
          substitutionValues: {'emailValue': email, 'mobileValue': mobile},
          allowReuse: true,
          timeoutInSeconds: 30,
        );
        if (sellerAlreadyRegistered!.affectedRowCount > 0) {
          newSellerFuture = 'alr';
        } else {
          //Stage 2 : If user not already registered then we start the registration
          newSellerRegisterResult = await newSellerConn.query(
            'insert into myAppData.register(emailDB,passDB,mobileDB,registerDateDB,roleDB,authDB,statusDB,isSellerDB) '
            'values(@emailValue,@passwordValue,@mobileValue,@registrationValue,@roleValue,@authValue,@statusValue,@isSellerValue )',
            substitutionValues: {
              'emailValue': email,
              'passwordValue': password,
              'mobileValue': mobile,
              'statusValue': true,
              'roleValue': 'ROLE_SELLER',
              'authValue': 'seller',
              'registrationValue': DateTime.now(),
              'isSellerValue': true,
            },
            allowReuse: true,
            timeoutInSeconds: 30,
          );
          newSellerFuture =
              (newSellerRegisterResult!.affectedRowCount > 0 ? 'reg' : 'nop');
        }
      });
    } catch (exc) {
      newSellerFuture = 'exc';
      exc.toString();
    }
    return newSellerFuture;
  }

  String newBuyerFuture = '';
  Future<String> registerBuyer(
      String email, String password, String fName, String lName) async {
    try {
      await connection!.open();
      await connection!.transaction((newBuyerConn) async {
        buyerAlreadyRegistered = await newBuyerConn.query(
          'select * from myAppData.register where emailDB = @emailValue order by idDB',
          substitutionValues: {'emailValue': email},
          allowReuse: true,
          timeoutInSeconds: 30,
        );
        if (buyerAlreadyRegistered!.affectedRowCount > 0) {
          newBuyerFuture = 'alr';
        } else {
          newBuyerRegisterResult = await newBuyerConn.query(
            'insert into myAppData.register (emailDB,passDB,fNameDB,lNameDB,statusDB,roleDB,authDB,registerDateDB)'
            'values(@emailValue,@passwordValue,@fNameValue,@lNameValue,@statusValue,@roleValue,@authValue,@registrationValue)',
            substitutionValues: {
              'emailValue': email,
              'passwordValue': password,
              'fNameValue': fName,
              'lNameValue': lName,
              'statusValue': true,
              'roleValue': 'ROLE_BUYER',
              'authValue': 'buyer',
              'registrationValue': DateTime.now(),
            },
            allowReuse: true,
            timeoutInSeconds: 30,
          );
          newBuyerFuture =
              (newBuyerRegisterResult!.affectedRowCount > 0 ? 'reg' : 'nop');
        }
      });
    } catch (exc) {
      exc.toString();
      newBuyerFuture = 'exc';
    }
    return newBuyerFuture;
  }

  //Login Database Section
  String userLoginFuture = '';
  Future<String> loginUser(String email, String password) async {
    try {
      await connection!.open();
      await connection!.transaction((loginConn) async {
        //Step 1 : Check email registered or no
        loginResult = await loginConn.query(
          'select emailDB,passDB,isSellerDB from myAppData.register where emailDB = @emailValue order by idDB',
          substitutionValues: {'emailValue': email},
          allowReuse: true,
          timeoutInSeconds: 30,
        );
        if (loginResult!.affectedRowCount > 0) {
          // Usually we check if account expired or no ...but I will
          // not add the code and skip here to simplify things
          // We will check the entered credentials..and decide
          // weather the user is a buyer or seller

          sellerEmailAddress = loginResult!.first
              .elementAt(0); //This to use when update seller details

          if (loginResult!.first.elementAt(1).contains(password) == true &&
              loginResult!.first.elementAt(2) == true) {
            userLoginFuture = 'sel';
          } else if (loginResult!.first.elementAt(1).contains(password) ==
                  true &&
              loginResult!.first.elementAt(2) == false) {
            userLoginFuture = 'buy';
          } else if (loginResult!.first.elementAt(1).contains(password) ==
              false) {
            userLoginFuture = 'fai';
          } else {
            userLoginFuture = 'exc';
          }
        } else {
          userLoginFuture = 'not';
        }
      });
    } catch (exc) {
      userLoginFuture = 'exc';
      exc.toString();
    }
    return userLoginFuture;
  }

  //Update Database Section
  String futureBuyerUpdate = '';
  Future<String> updateBuyerData(int ssn, String mobile) async {
    try {
      await connection!.open();
      await connection!.transaction((updateBuyerConn) async {
        print('update buyer');
        // Mobile column in DB is unique..so we check the buyer mobile first
        PostgreSQLResult checkBuyerMobile = await updateBuyerConn.query(
          'select mobileDB from myAppData.register where mobileDB = @mobileValue',
          substitutionValues: {'mobileValue': mobile},
          allowReuse: false,
          timeoutInSeconds: 30,
        );
        if (checkBuyerMobile.affectedRowCount > 0) {
          futureBuyerUpdate = 'alr';
        } else {
          //If check fails ..then we update buyer data
          updateBuyerResult = await updateBuyerConn.query(
            'update myAppData.register set SSN_DB = @ssnValue, mobileDB = @mobileValue where emailDB = @emailValue',
            substitutionValues: {
              'ssnValue': ssn,
              'mobileValue': mobile,
              'emailValue': AppDatabase.sellerEmailAddress,
            },
            allowReuse: false,
            timeoutInSeconds: 30,
          );
          print('update buyer 1');
          futureBuyerUpdate =
              (updateBuyerResult!.affectedRowCount > 0 ? 'upd' : 'nop');
        }
      });
    } catch (exc) {
      futureBuyerUpdate = 'exc';
      exc.toString();
    }
    return futureBuyerUpdate;
  }

  String sellerDetailsFuture = '';
  Future<String> updateSellerData(
      String companyNameValue, String fNameValue, String logoImage) async {
    try {
      await connection!.open();
      await connection!.transaction((sellerUpdateConn) async {
        updateSellerResult = await sellerUpdateConn.query(
          'update myAppData.register set companyDB = @companyValue , fNameDB = @fNameValue , avatar = @avatarValue where emailDB = @emailValue',
          substitutionValues: {
            'companyValue': companyNameValue,
            'fNameValue': fNameValue,
            'avatarValue': logoImage,
            'emailValue': AppDatabase.sellerEmailAddress,
          },
          allowReuse: false,
          timeoutInSeconds: 30,
        );
        sellerDetailsFuture =
            (updateSellerResult!.affectedRowCount > 0 ? 'upd' : 'not');
      });
    } catch (exc) {
      sellerDetailsFuture = 'exc';
      exc.toString();
    }
    return sellerDetailsFuture;
  }

  // Fetch Data Section
  List<dynamic> fetchDataFuture = [];
  Future<List<dynamic>> fetchSellerData(String emailText) async {
    try {
      await connection!.open();
      await connection!.transaction((fetchDataConn) async {
        _fetchSellerDataResult = await fetchDataConn.query(
          'select companydb,emaildb,fnamedb,mobiledb,avatar from myAppData.register where emailDB = @emailValue order by idDB',
          substitutionValues: {'emailValue': emailText},
          allowReuse: false,
          timeoutInSeconds: 30,
        );
        if (_fetchSellerDataResult!.affectedRowCount > 0) {
          fetchDataFuture = _fetchSellerDataResult!.first.toList(growable: true);
        } else {
          fetchDataFuture = [];
        }
      });
    } catch (exc) {
      fetchDataFuture = [];
      exc.toString();
    }

    return fetchDataFuture;
  }
}
