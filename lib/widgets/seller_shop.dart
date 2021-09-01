import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_db/models/model_user.dart';
import 'package:flutter_db/shared_widgets/buttons.dart';
import 'package:flutter_db/shared_widgets/clay.dart';
import 'package:flutter_db/shared_widgets/form_text_field.dart';

class SellerShop extends StatelessWidget {
  const SellerShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller Shop'),
      ),
      body: Center(
        child: SellerShopView(),
      ),
    );
  }
}

class SellerShopView extends StatefulWidget {
  const SellerShopView({Key? key}) : super(key: key);

  @override
  _SellerShopViewState createState() => _SellerShopViewState();
}

class _SellerShopViewState extends State<SellerShopView> {
  final _fetchDataGlobalKey = GlobalKey<FormState>();

  String? companyName;
  String? email;
  String? fName;
  String? mobile;
  String avatar = '';

  final _emailController = TextEditingController();

  String _emailTextValue = '';
  String _getEmailText() {
    _emailTextValue = ((_emailController.text).isEmpty != true ||
            (_emailController.text).length > 0
        ? _emailController.text
        : '');
    return _emailTextValue;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.addListener(() {
      _getEmailText();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        shrinkWrap: true,
        children: [
          Form(
            key: _fetchDataGlobalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: FormTextFieldStandard(
                    textInputType: TextInputType.emailAddress,
                    controller: _emailController,
                    icon: Icons.email_outlined,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: StandardElevatedButton(
                    style: ButtonStyle(),
                    child: Text(
                      "Show Details",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    onPressed: () {
                      ModelsUsers()
                          .fetchSellerData(_emailTextValue)
                          .then((fetchedDataFuture) {
                        // If we receive data from DB
                        String companyNameStr =
                            fetchedDataFuture.elementAt(0).toString();
                        String emailStr =
                            fetchedDataFuture.elementAt(1).toString();
                        String fNameStr =
                            fetchedDataFuture.elementAt(2).toString();
                        String mobileStr =
                            fetchedDataFuture.elementAt(3).toString();
                        String avatarStr = fetchedDataFuture.elementAt(4);
                        Timer(Duration(seconds: 2), () {
                          setState(() {
                            //Important we give time to fetch data from DB
                            // Then we set new state for the page
                            companyName = companyNameStr;
                            email = emailStr;
                            fName = fNameStr;
                            mobile = mobileStr;
                            avatar = avatarStr;
                          });
                        });
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: ClayContainerDesign(
                    containerColor: Colors.grey[300],
                    borderRadius: 10,
                    customBorderRadius: BorderRadius.all(Radius.circular(20.0)),
                    curveType: CurveType.convex,
                    height: 40.0,
                    textDetails: companyName,
                    clayTextSize: 20.0,
                    clayTextColor: Colors.white,
                    clayTextColorText: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: ClayContainerDesign(
                    containerColor: Colors.grey[300],
                    borderRadius: 10,
                    customBorderRadius: BorderRadius.all(Radius.circular(20.0)),
                    curveType: CurveType.convex,
                    height: 40.0,
                    textDetails: email,
                    clayTextSize: 20.0,
                    clayTextColor: Colors.white,
                    clayTextColorText: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: ClayContainerDesign(
                    containerColor: Colors.grey[300],
                    borderRadius: 10,
                    customBorderRadius: BorderRadius.all(Radius.circular(20.0)),
                    curveType: CurveType.convex,
                    height: 40.0,
                    textDetails: fName,
                    clayTextSize: 20.0,
                    clayTextColor: Colors.white,
                    clayTextColorText: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: ClayContainerDesign(
                    containerColor: Colors.grey[300],
                    borderRadius: 10,
                    customBorderRadius: BorderRadius.all(Radius.circular(20.0)),
                    curveType: CurveType.convex,
                    height: 40.0,
                    textDetails: mobile,
                    clayTextSize: 20.0,
                    clayTextColor: Colors.white,
                    clayTextColorText: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Image.memory(
                    Base64Decoder().convert(avatar),
                    width: 200.0,
                    height: 170.0,
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}
