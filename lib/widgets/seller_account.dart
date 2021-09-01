import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_db/models/model_user.dart';
import 'package:flutter_db/shared_widgets/buttons.dart';
import 'package:flutter_db/shared_widgets/form_text_field.dart';
import 'package:image_picker/image_picker.dart';

class SellerAccount extends StatelessWidget {
  const SellerAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SellerPage();
  }
}

class SellerPage extends StatefulWidget {
  const SellerPage({Key? key}) : super(key: key);

  @override
  _SellerPageState createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  final _companyNameFieldController = TextEditingController();
  final _fNameFieldController = TextEditingController();

  final _updateSellerAccount = GlobalKey<FormState>();

  /*...Make sure the field has value entered ...*/
  String _companyValue = '';
  String _companyLatestValue() {
    return _companyValue = ((_companyNameFieldController.text).isNotEmpty &&
            (_companyNameFieldController.text).length > 0
        ? _companyNameFieldController.text
        : '');
  }

  /*...Make sure the field has value entered ...*/
  String _fNameValue = '';
  String _fNameLatestValue() {
    return _fNameValue = ((_fNameFieldController.text).isNotEmpty &&
            (_fNameFieldController.text).length > 0
        ? _fNameFieldController.text
        : '');
  }

  String? logoFromGallery;
  File? _logoFile;
  Uint8List? logoUint8List;
  String? _logoImage;

  Future<String?> _getLogoFromGallery(var logoFile) async {
    try {
      var logoPickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 60,
          preferredCameraDevice: CameraDevice.rear);
      //Read  the image as bytes
      logoUint8List = await logoPickedFile!.readAsBytes();

      //Convert the image to base64 String
      var logoBase64 = base64Encode(logoUint8List!);

      //Assign the encoded base64 string to this method's return value
      if (logoUint8List!.lengthInBytes > 0) {
        logoFromGallery = logoBase64;
        setState(() => _logoFile = File(logoPickedFile.path));
      } else {
        logoFromGallery = null;
        setState(() => _logoFile = (null));
      }
    } catch (exc) {
      logoFromGallery = null;
      setState(() => _logoFile = (null));
      exc.toString();
    }
    return logoFromGallery;
  }

  ///This to set the no product image in case seller add less than 10 products
  String? noImage;
  String? noLogoImageBase64;

  // If seller not select a logo imae..we have to set a replacement image from
  // resources
  Future<String?> getNoImageData() async {
    ByteData bytes = await rootBundle.load('res/noproduct.png');
    noImage = base64Encode(bytes.buffer.asUint8List(0, bytes.lengthInBytes));
    var noImageBase64String = getNoImageBase64String(noImage!);
    return noImage;
  }

  String? getNoImageBase64String(String noImageBase64String) {
    noLogoImageBase64 = noImageBase64String;
    return noLogoImageBase64;
  }

  /* Seller can remove any image before saving it ...Except Company Logo */
  Future replaceCompanyLogo(var image) async {
    this._logoFile = image;
    image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );
    setState(() => _logoFile = image);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Initialize the controllers and add listener to listen to any changes in
    // The text fields
    _companyNameFieldController.addListener(() {
      _companyLatestValue();
    });
    _fNameFieldController.addListener(() {
      _fNameLatestValue();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //Dispose the values of the controllers after use
    _companyNameFieldController.dispose();
    _fNameFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text('Seller Update Details Page '),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          controller: ScrollController(),
          reverse: false,
          shrinkWrap: true,
          padding: EdgeInsets.all(20.0),
          children: [
            Form(
              key: _updateSellerAccount,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FormTextFieldStandard(
                    controller: _companyNameFieldController,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontColor: Colors.black,
                    icon: Icons.local_post_office_outlined,
                    tooltip: "Company Name",
                    maxLines: 1,
                    formTextFieldLabel: "Company Name ",
                    validate: (stringEmailValue) =>
                        stringEmailValue!.isEmpty == true
                            ? "Enter Company Name"
                            : null,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FormTextFieldStandard(
                    controller: _fNameFieldController,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontColor: Colors.black,
                    icon: Icons.person,
                    tooltip: "First Name",
                    maxLines: 1,
                    formTextFieldLabel: "First Name",
                    validate: (stringEmailValue) =>
                        stringEmailValue!.isEmpty == true ? "First Name" : null,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ProductsImagesGridView(
                    imageFile: _logoFile,
                    //image:Image.file(selectedFile(_image)) ,
                    iconGallery: Icons.photo,
                    iconCamera: Icons.camera,
                    iconRemove: Icons.add_photo_alternate,
                    onPressedGallery: () => _getLogoFromGallery(_logoFile),
                    onPressedRemove: () => replaceCompanyLogo(_logoFile),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  StandardElevatedButton(
                    style: ButtonStyle(),
                    child: Text(
                      "Update",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    onPressed: () => updateSellerDetailsMethod(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateSellerDetailsMethod(BuildContext context) {
    if (_updateSellerAccount.currentState!.validate()) {
      _updateSellerAccount.currentState!.save();
      // Here we arrange all inputs data from the application
      //and forward to the update model class

      _logoImage =
          (logoFromGallery == null ? noLogoImageBase64 : logoFromGallery);

      ModelsUsers()
          .updateSellerDetails(_companyValue, _fNameValue, _logoImage!)
          .then((updateSellerFuture) {
        if (updateSellerFuture.toString().contains('upd')) {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                elevation: 10.0,
                shape: Border.all(
                  color: Colors.orange,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
                content: Text(
                  "Update Successful",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            _companyNameFieldController.clear();
            _fNameFieldController.clear();
            Timer(Duration(seconds: 4), () {
              Navigator.pushNamed(context, '/login');
            });
          });
        } else if (updateSellerFuture.toString().contains('not')) {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                elevation: 10.0,
                shape: Border.all(
                  color: Colors.orange,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
                content: Text(
                  "Update Failed",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            _companyNameFieldController.clear();
            _fNameFieldController.clear();
            Timer(Duration(seconds: 4), () {
              Navigator.pushNamed(context, '/sellerAccount');
            });
          });
        } else if (updateSellerFuture.toString().contains('exc')) {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                elevation: 10.0,
                shape: Border.all(
                  color: Colors.orange,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
                content: Text(
                  "Something Went Wrong..Try Again",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            _companyNameFieldController.clear();
            _fNameFieldController.clear();
            Timer(Duration(seconds: 4), () {
              Navigator.pushNamed(context, '/sellerAccount');
            });
          });
        }
      });
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.white,
            elevation: 10.0,
            shape: Border.all(
              color: Colors.orange,
              width: 0.5,
              style: BorderStyle.solid,
            ),
            content: Text(
              "Fill All Details",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                letterSpacing: 1.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
        _companyNameFieldController.clear();
        _fNameFieldController.clear();
        Timer(Duration(seconds: 4), () {
          Navigator.pushNamed(context, '/sellerAccount');
        });
      });
    }
  }
}

class ProductsImagesGridView extends StatelessWidget {
  final File? imageFile;
  final Image? image;
  final IconData? iconGallery;
  final IconData? iconCamera;
  final IconData? iconRemove;
  final Function()? onPressedGallery;
  final Function()? onPressedCamera;
  final Function()? onPressedRemove;

  ProductsImagesGridView({
    this.imageFile,
    this.image,
    this.iconGallery,
    this.iconCamera,
    this.iconRemove,
    this.onPressedGallery,
    this.onPressedCamera,
    this.onPressedRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.vertical,
      reverse: false,
      controller: ScrollController(
        initialScrollOffset: 0,
        keepScrollOffset: true,
        debugLabel: 'userAccount_Grid',
      ),
      primary: false,
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
      addSemanticIndexes: true,
      crossAxisCount: 4,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(2.0),
          //height: 70.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 0.5,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          alignment: Alignment.center,
          child: imageFile == null ? Text("No Logo") : Image.file(imageFile!),
        ),
        UserAccountImageButton(
          icon: Icon(
            iconGallery,
            size: 30,
            color: Colors.white,
            semanticLabel: 'userAccountGalleryImage',
          ),
          onPressed: onPressedGallery,
        ),
        UserAccountImageButton(
          icon: Icon(
            iconRemove,
            size: 30,
            color: Colors.white,
            semanticLabel: 'userAccountRemoveImage',
          ),
          onPressed: onPressedRemove,
        ),
      ],
    );
  }
}
