import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter_db/models/model_user.dart';
import 'package:flutter_db/shared_widgets/buttons.dart';
import 'package:flutter_db/shared_widgets/clay.dart';
import 'package:flutter_db/shared_widgets/form_text_field.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegisterPage();
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  /*... 1 Create the required tabs ...*/
  final List<Tab> registerAccountsTabs = <Tab>[
    Tab(
      text: "BuyerAccount",
    ),
    Tab(
      text: "Seller Account",
    ),
  ];

  /*.. 2- Create a Tabs controller ..*/
  TabController? _userAccountController;

  // Global Keys to use with the form text fields
  final _buyerAccountFormKey = GlobalKey<FormState>();
  final _sellerAccountFormKey = GlobalKey<FormState>();

  // A controller for each field
  final buyerEmailFieldController = TextEditingController();
  final sellerEmailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final companyFieldController = TextEditingController();
  final fNameFieldController = TextEditingController();
  final lNameFieldController = TextEditingController();
  final landlineFieldController = TextEditingController();
  final mobileFieldController = TextEditingController();

  //This will be used when searching for city & country to setup the user account
  String searchedCityName = '';
  String searchedCountryName = '';

  // Methods to get the latest value of each form text field
  String buyerEmailText = '';
  String _buyerEmailFieldLatestValue() {
    return buyerEmailText = ((buyerEmailFieldController.text).isNotEmpty &&
            (buyerEmailFieldController.text).length > 0
        ? buyerEmailFieldController.text
        : "");
  }

  String sellerEmailText = '';
  String _sellerEmailFieldLatestValue() {
    return sellerEmailText = ((sellerEmailFieldController.text).isNotEmpty &&
            (sellerEmailFieldController.text).length > 0
        ? sellerEmailFieldController.text
        : "");
  }

  String passwordTextValue = '';
  String _passwordFieldLatestValue() {
    return passwordTextValue = ((passwordFieldController.text).isNotEmpty &&
            (passwordFieldController.text).length > 0
        ? passwordFieldController.text
        : "");
  }

  String companyNameText = '';
  String _companyNameFieldLatestValue() {
    return companyNameText = ((companyFieldController.text).isNotEmpty &&
            (companyFieldController.text).length > 0
        ? companyFieldController.text
        : "");
  }

  String fNameText = '';
  String _fNameFieldLatestValue() {
    return fNameText = ((fNameFieldController.text).isNotEmpty &&
            (fNameFieldController.text).length > 0
        ? fNameFieldController.text
        : "");
  }

  String lNameText = '';
  String _lNameFieldLatestValue() {
    return lNameText = ((lNameFieldController.text).isNotEmpty &&
            (lNameFieldController.text).length > 0
        ? lNameFieldController.text
        : "");
  }

  String landlineText = '';
  String _landlineFieldLatestValue() {
    return landlineText = ((landlineFieldController.text).isNotEmpty &&
            (landlineFieldController.text).length > 0
        ? landlineFieldController.text
        : '');
  }

  String mobileText = '';
  String _mobileFieldLatestValue() {
    return mobileText = ((mobileFieldController.text).isNotEmpty &&
            (mobileFieldController.text).length > 0
        ? mobileFieldController.text
        : '');
  }

  /*...When user select to become a seller..we activate the registration form
    ..user click a button and the registration form fields shows up using method
    .. showWidget() ...*/
  bool viewVisible = false;

  // The seller fields widget will show and hide upon clicking on a button
  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Initialize the Tabs controller
    _userAccountController = TabController(
        initialIndex: 0, vsync: this, length: registerAccountsTabs.length);

    // Start listening to changes in fields upon entering text.
    buyerEmailFieldController.addListener(() {
      _buyerEmailFieldLatestValue();
    });
    sellerEmailFieldController.addListener(() {
      _sellerEmailFieldLatestValue();
    });
    passwordFieldController.addListener(() {
      _passwordFieldLatestValue();
    });
    companyFieldController.addListener(() {
      _companyNameFieldLatestValue();
    });
    fNameFieldController.addListener(() {
      _fNameFieldLatestValue();
    });
    lNameFieldController.addListener(() {
      _lNameFieldLatestValue();
    });
    landlineFieldController.addListener(() {
      _landlineFieldLatestValue();
    });
    mobileFieldController.addListener(() {
      _mobileFieldLatestValue();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Clean up the controller when the widget is removed from the
    // widget tree.
    buyerEmailFieldController.dispose();
    sellerEmailFieldController.dispose();
    passwordFieldController.dispose();
    companyFieldController.dispose();
    fNameFieldController.dispose();
    lNameFieldController.dispose();
    landlineFieldController.dispose();
    mobileFieldController.dispose();

    super.dispose();
  }

  Color baseColor = Color(0xFFF2F2F2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: baseColor,
        title: ClayContainerDesign(
          containerColor: baseColor,
          borderRadius: 10.0,
          customBorderRadius: BorderRadius.circular(20.0),
          height: 60.0,
          curveType: CurveType.none,
          textDetails: "Fill Details",
          clayTextSize: 25.0,
          clayTextColor: Colors.white,
          clayTextColorText: Colors.grey,
        ),
        bottom: TabBar(
          controller: _userAccountController,
          tabs: registerAccountsTabs,
          isScrollable: false,
          indicator: BoxDecoration(
            //color: Colors.green,
            //border: Border(top: BorderSide(color:Colors.white ,width:1.0 ,style: BorderStyle.solid) ),
            border: Border.all(
                color: Colors.white, width: 1.0, style: BorderStyle.solid),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.teal, Colors.tealAccent],
              stops: [0.1, 0.8],
              transform: GradientRotation(0.45),
              tileMode: TileMode.clamp,
            ),
          ),
          //indicatorColor: Colors.black,  //ignored if indicator ins selected
          //indicatorPadding: EdgeInsets.all(5.0),  //ignored if indicator ins selected
          //indicatorWeight: 2.0,   //ignored if indicator ins selected
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            letterSpacing: 2.0,
          ),
          labelPadding: EdgeInsets.all(2.0),
          unselectedLabelColor: Colors.black,
          unselectedLabelStyle: TextStyle(
            fontSize: 15.0,
          ),
          onTap: (int) {}, //what to do here ?!!!
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return TabBarView(controller: _userAccountController, children: [
            ListView(
              scrollDirection: Axis.vertical,
              reverse: false,
              controller: ScrollController(
                initialScrollOffset: 0,
                keepScrollOffset: true,
                debugLabel: 'scroll_label',
              ),
              //physics: const AlwaysScrollableScrollPhysics(),
              //shrinkWrap: false,
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              children: <Widget>[
                Form(
                  key: _buyerAccountFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 15.0,
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: FormTextFieldStandard(
                          controller: fNameFieldController,
                          textInputType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          fontColor: Colors.black,
                          icon: Icons.person,
                          tooltip: 'First Name',
                          maxLines: 1,
                          formTextFieldLabel: "Name",
                          validate: (stringFieldValue) =>
                              stringFieldValue!.isEmpty == true
                                  ? 'Fill The Details'
                                  : null,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: FormTextFieldStandard(
                          controller: lNameFieldController,
                          textInputType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          fontColor: Colors.black,
                          icon: Icons.person,
                          tooltip: "Surname",
                          maxLines: 1,
                          formTextFieldLabel: "Surname",
                          validate: (stringFieldValue) =>
                              stringFieldValue!.isEmpty == true
                                  ? 'Fill The Details'
                                  : null,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: FormTextFieldStandard(
                          controller: buyerEmailFieldController,
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          fontColor: Colors.black,
                          icon: Icons.email,
                          tooltip: "Email",
                          maxLines: 1,
                          formTextFieldLabel: "Email",
                          validate: (stringFieldValue) =>
                              stringFieldValue!.isEmpty == true
                                  ? 'Fill The Details'
                                  : null,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: FormTextFieldStandardObsecured(
                          controller: passwordFieldController,
                          textInputType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          fontColor: Colors.black,
                          icon: Icons.security,
                          tooltip: "Password",
                          maxLines: 1,
                          formTextFieldLabel: "Password",
                          validate: (stringFieldValue) =>
                              stringFieldValue!.isEmpty == true
                                  ? "Password"
                                  : null,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 10.0),
                          alignment: Alignment.center,
                          child: StandardElevatedButton(
                            style: ButtonStyle(),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 19.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                            onPressed: () => registerBuyerMethod(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ListView(
              scrollDirection: Axis.vertical,
              reverse: false,
              controller: ScrollController(
                initialScrollOffset: 0,
                keepScrollOffset: true,
                debugLabel: 'scroll_label',
              ),
              //physics: const AlwaysScrollableScrollPhysics(),
              //shrinkWrap: false,
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Open Shop",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5.0,
                ),
                StandardElevatedButton(
                  style: ButtonStyle(),
                  child: Text(
                    "Create",
                  ),
                  onPressed: showWidget,
                ),
                Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: viewVisible,
                  maintainInteractivity: true,
                  child: Form(
                    key: _sellerAccountFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: FormTextFieldStandard(
                            controller: sellerEmailFieldController,
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            fontColor: Colors.black,
                            icon: Icons.email,
                            tooltip: "Email",
                            maxLines: 1,
                            formTextFieldLabel: "Seller",
                            validate: (emailStringValue) =>
                                emailStringValue!.isEmpty == true
                                    ? "Fill Details"
                                    : null,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: FormTextFieldStandardObsecured(
                            controller: passwordFieldController,
                            textInputType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            fontColor: Colors.black,
                            icon: Icons.security,
                            tooltip: "Password",
                            maxLines: 1,
                            formTextFieldLabel: "Password",
                            validate: (passwordFieldString) =>
                                passwordFieldString!.isEmpty == true
                                    ? "Fill Details"
                                    : null,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: FormTextFieldStandard(
                            controller: mobileFieldController,
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            fontColor: Colors.black,
                            icon: Icons.phone_android,
                            tooltip: "Mobile",
                            maxLines: 1,
                            formTextFieldLabel:
                                '+123 123456789 Or +12 123456789',
                            validate: (mobileValueString) =>
                                mobileValueString!.isEmpty == true
                                    ? "Fill Details"
                                    : null,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 10.0),
                          alignment: Alignment.center,
                          child: StandardElevatedButton(
                            style: ButtonStyle(),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 19.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                            onPressed: () {
                              registerSellerMethod(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  //replacement: SizedBox.shrink(),
                ),
              ],
            ),
            //physics: ,
          ]);
        },
      ),
    );
  }

  void registerSellerMethod(BuildContext context) {
    if (_sellerAccountFormKey.currentState!.validate()) {
      _sellerAccountFormKey.currentState!.save();

      ModelsUsers()
          .registerNewSeller(
        sellerEmailText,
        passwordTextValue,
        mobileText,
      )
          .then((futureSeller) {
        if (futureSeller.toString().contains('reg')) {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.blue[100],
              elevation: 10.0,
              shape: Border.all(
                  color: Colors.green, width: 0.5, style: BorderStyle.solid),
              content: Text(
                "Register Successful",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
                textAlign: TextAlign.center,
              ),
            ));
            sellerEmailFieldController.clear();
            passwordFieldController.clear();
            mobileFieldController.clear();

            Timer(Duration(seconds: 4), () {
              Navigator.pushNamed(context, '/login');
            });
          });
        } else if (futureSeller.toString().contains('nop')) {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.blue[100],
                elevation: 10.0,
                shape: Border.all(
                    color: Colors.red, width: 0.5, style: BorderStyle.solid),
                content: Text(
                  "Register Failed",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            sellerEmailFieldController.clear();
            passwordFieldController.clear();
            mobileFieldController.clear();
            Timer(Duration(seconds: 3), () {
              Navigator.pushNamed(context, '/register');
            });
          });
        } else if (futureSeller.toString().contains('alr')) {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.blue[100],
                elevation: 10.0,
                shape: Border.all(
                    color: Colors.yellow, width: 0.5, style: BorderStyle.solid),
                content: Text(
                  "Email Already Registered",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            sellerEmailFieldController.clear();
            passwordFieldController.clear();
            mobileFieldController.clear();
            Timer(Duration(seconds: 3), () {
              Navigator.pushNamed(context, '/login');
            });
          });
        } else {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                elevation: 10.0,
                shape: Border.all(
                  color: Colors.red,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
                content: Text(
                  "Something Went Wrong",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            sellerEmailFieldController.clear();
            passwordFieldController.clear();
            mobileFieldController.clear();
            Timer(Duration(seconds: 3), () {
              Navigator.pushNamed(context, '/register');
            });
          });
        }
      }).catchError((err) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.blue[100],
              elevation: 10.0,
              shape: Border.all(
                  color: Colors.red, width: 0.5, style: BorderStyle.solid),
              content: Text(
                "Something Went Wrong",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
          sellerEmailFieldController.clear();
          passwordFieldController.clear();
          mobileFieldController.clear();
          Timer(Duration(seconds: 3), () {
            Navigator.pushNamed(context, '/register');
          });
        });
      }).whenComplete(() => null);
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue[100],
            elevation: 10.0,
            shape: Border.all(
                color: Colors.red, width: 0.5, style: BorderStyle.solid),
            content: Text(
              "Fill All Fields",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
        sellerEmailFieldController.clear();
        passwordFieldController.clear();
        mobileFieldController.clear();
        Timer(Duration(seconds: 4), () {
          Navigator.pushNamed(context, '/register');
        });
      });
    }
  }

  void registerBuyerMethod(BuildContext context) {
    if (_buyerAccountFormKey.currentState!.validate()) {
      _buyerAccountFormKey.currentState!.save();

      //Update Buyer Data info section..using Postgres
      ModelsUsers()
          .registerNewBuyer(
        buyerEmailText,
        passwordTextValue,
        fNameText,
        lNameText,
      )
          .then((futureBuyer) {
        if (futureBuyer.toString().contains('reg')) {
          print('Here 1');
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                elevation: 10.0,
                shape: Border.all(
                  color: Colors.green,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
                content: Text(
                  "Registration Successful",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            buyerEmailFieldController.clear();
            passwordFieldController.clear();
            fNameFieldController.clear();
            lNameFieldController.clear();
            Timer(Duration(seconds: 3), () {
              Navigator.pushNamed(context, '/login');
            });
          });
        } else if (futureBuyer.toString().contains('nop')) {
          print('Here 2');
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                elevation: 10.0,
                shape: Border.all(
                  color: Colors.red,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
                content: Text(
                  "Registration Failed",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            buyerEmailFieldController.clear();
            passwordFieldController.clear();
            fNameFieldController.clear();
            lNameFieldController.clear();
            Timer(Duration(seconds: 3), () {
              Navigator.pushNamed(context, '/register');
            });
          });
        } else if (futureBuyer.toString().contains('alr')) {
          print('Here 3');
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                elevation: 10.0,
                shape: Border.all(
                  color: Colors.yellow,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
                content: Text(
                  "Email Already Registered",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            buyerEmailFieldController.clear();
            passwordFieldController.clear();
            fNameFieldController.clear();
            lNameFieldController.clear();
            Timer(Duration(seconds: 4), () {
              Navigator.pushNamed(context, '/login');
            });
          });
        } else {
          print('Here 4');
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                elevation: 10.0,
                shape: Border.all(
                  color: Colors.red,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
                content: Text(
                  "Something Went Wrong",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            buyerEmailFieldController.clear();
            passwordFieldController.clear();
            fNameFieldController.clear();
            lNameFieldController.clear();
            Timer(Duration(seconds: 3), () {
              Navigator.pushNamed(context, '/register');
            });
          });
        }
      }).catchError((err) {
        err.toString();
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.white,
              elevation: 10.0,
              shape: Border.all(
                  color: Colors.red, width: 0.5, style: BorderStyle.solid),
              content: Text(
                "Something Went Wrong",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
          buyerEmailFieldController.clear();
          passwordFieldController.clear();
          fNameFieldController.clear();
          lNameFieldController.clear();
          Timer(Duration(seconds: 3), () {
            Navigator.pushNamed(context, '/register');
          });
        });
      }).whenComplete(() => null);
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          elevation: 10.0,
          shape: Border.all(
            color: Colors.orange,
            width: 0.5,
            style: BorderStyle.solid,
          ),
          content: Text(
            "Something Went Wrong",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
        ));
        Timer(Duration(seconds: 4), () {
          Navigator.pushNamed(context, '/register');
        });
      });
    }
  }
}
