import 'dart:async';

import 'package:clay_containers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_db/models/model_user.dart';
import 'package:flutter_db/shared_widgets/buttons.dart';
import 'package:flutter_db/shared_widgets/clay.dart';
import 'package:flutter_db/shared_widgets/form_text_field.dart';

class BuyerAccount extends StatelessWidget {
  const BuyerAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buyer Account Page',
          style: TextStyle(
              fontSize: 20.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: BuyerPage(),
    );
  }
}

class BuyerPage extends StatefulWidget {
  const BuyerPage({Key? key}) : super(key: key);

  @override
  _BuyerPageState createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage> {
  Color baseColor = Color(0xFFF2F2F2);

  /// Get Form key to update the buyer's data
  final _updateBuyerKey = GlobalKey<FormState>();

  /*...Create a controller for every field buyer wish to update...*/
  final _ssnController = TextEditingController();
  final _mobileController = TextEditingController();

  /*...Get value of the fields when values entered ...*/

  int ssnValue = 0;
  int _ssnLatestValue() {

    if ((int.parse(_ssnController.text)) != 0 &&
        (int.parse(_ssnController.text)).isNegative == false) {
      ssnValue = int.parse(_ssnController.text);
    }
    return ssnValue;
  }

  String mobileValue = '';
  String _mobileLatestValue() {
    if ((_mobileController.text).isNotEmpty == true &&
        (_mobileController.text).length > 0) {
      mobileValue = _mobileController.text;
    }
    return mobileValue;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// Listen to any changes in the fields values
    _ssnController.addListener(() {
      _ssnLatestValue();
    });
    _mobileController.addListener(() {
      _mobileLatestValue();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _ssnController.dispose();
    _mobileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          reverse: false,
          controller: ScrollController(),
          primary: false,
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          addAutomaticKeepAlives: true,
          addSemanticIndexes: true,
          addRepaintBoundaries: true,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClayContainerDesign(
                    containerColor: baseColor,
                    borderRadius: 10.0,
                    customBorderRadius: BorderRadius.circular(20.0),
                    curveType: CurveType.convex,
                    height: 70.0,
                    textDetails: "Fill All Details",
                    clayTextSize: 32.0,
                    clayTextColor: Colors.white,
                    clayTextColorText: Colors.grey,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Form(
              key: _updateBuyerKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: FormTextFieldStandard(
                      controller: _ssnController,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                      fontColor: Colors.blueGrey,
                      icon: Icons.confirmation_number_outlined,
                      formTextFieldLabel: "SSN Number",
                      validate: (stringFieldValue) =>
                          stringFieldValue!.isEmpty == true
                              ? "Fill All Fields"
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
                      controller: _mobileController,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.none,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                      fontColor: Colors.blueGrey,
                      icon: Icons.phone_android,
                      formTextFieldLabel: "Mobile",
                      validate: (stringFieldValue) =>
                          stringFieldValue!.isEmpty == true
                              ? "Fill All Fields"
                              : null,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  StandardElevatedButton(
                    style: ButtonStyle(),
                    child: Text(
                      "Update",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      if (_updateBuyerKey.currentState!.validate()) {
                        _updateBuyerKey.currentState!.save();
                        ModelsUsers()
                            .updateBuyerDetails(
                          ssnValue,
                          mobileValue,
                        )
                            .then((updateBuyerFuture) {
                          if (updateBuyerFuture.toString().contains('upd')) {
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.white,
                                  elevation: 10.0,
                                  shape: Border.all(
                                      color: Colors.red,
                                      width: 0.5,
                                      style: BorderStyle.solid),
                                  content: Text(
                                    "Update Successful",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      letterSpacing: 1.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                              _ssnController.clear();
                              _mobileController.clear();
                              Timer(Duration(seconds: 3), () {
                                Navigator.pushNamed(context, '/login');
                              });
                            });
                          } else if(updateBuyerFuture.toString().contains('nop')){
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.white,
                                  elevation: 10.0,
                                  shape: Border.all(
                                      color: Colors.red,
                                      width: 0.5,
                                      style: BorderStyle.solid),
                                  content: Text(
                                    "Update Failed",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      letterSpacing: 1.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                              Timer(Duration(seconds: 3), () {
                                Navigator.pushNamed(context, '/buyerAccount');
                              });
                            });
                          }else if(updateBuyerFuture.toString().contains('exc')){
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.white,
                                  elevation: 10.0,
                                  shape: Border.all(
                                      color: Colors.red,
                                      width: 0.5,
                                      style: BorderStyle.solid),
                                  content: Text(
                                    "Something Went Wrong..try Again",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      letterSpacing: 1.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                              Timer(Duration(seconds: 3), () {
                                Navigator.pushNamed(context, '/buyerAccount');
                              });
                            });
                          }else if(updateBuyerFuture.toString().contains('alr')){
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.white,
                                  elevation: 10.0,
                                  shape: Border.all(
                                      color: Colors.red,
                                      width: 0.5,
                                      style: BorderStyle.solid),
                                  content: Text(
                                    "Mobile Number Registered ..select another number",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      letterSpacing: 1.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                              Timer(Duration(seconds: 3), () {
                                Navigator.pushNamed(context, '/buyerAccount');
                              });
                            });
                          }
                        }).catchError((err) {
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
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: 1.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                            _ssnController.clear();
                            _mobileController.clear();
                            Timer(Duration(seconds: 3), () {
                              Navigator.pushNamed(context, '/buyerAccount');
                            });
                          });
                          err.toString();
                        }).whenComplete(() => null);
                      } else {
                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.white,
                              elevation: 10.0,
                              shape: Border.all(
                                  color: Colors.red,
                                  width: 0.5,
                                  style: BorderStyle.solid),
                              content: Text(
                                "Fill All Fields",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: 1.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                          _ssnController.clear();
                          _mobileController.clear();
                          Timer(Duration(seconds: 3), () {
                            Navigator.pushNamed(context, '/buyerAccount');
                          });
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
