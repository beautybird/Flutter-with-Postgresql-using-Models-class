import 'package:flutter/material.dart';

class FormTextFieldStandard extends StatelessWidget {
  FormTextFieldStandard(
      {Key? key,
      this.controller,
      this.textInputType,
      this.textInputAction,
      this.fontSize,
      this.fontWeight,
      this.fontColor,
      this.icon,
      this.onTap,
      this.onChanged,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.tooltip,
      this.onPressed,
      this.validate,
      this.formTextFieldLabel,
      this.maxLines,})
      : super(key: key);

  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final IconData? icon;

  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final String? tooltip;
  final Function()? onPressed;
  RegExp? regExp = new RegExp(r'^[a-zA-Z0-9_]+( [a-zA-Z0-9_]+)*$');
  Iterable<RegExpMatch>? matches;
  final String? Function(String?)? validate;

  final String? formTextFieldLabel;
  final int? maxLines;

  List<bool> obsecureListValues=[];
  List<bool>? getObsecureValue() {
    obsecureListValues.add(true);
    obsecureListValues.add(false);
    return obsecureListValues;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: null,
      focusNode: FocusNode(),
      decoration: InputDecoration(
        labelText: formTextFieldLabel,
        labelStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontStyle: FontStyle.italic),
        //hintText: 'Type Your Password',
        //hintStyle: TextStyle(color: Colors.black87,fontSize: 16.0),
        prefixIcon: Icon(
          icon,
          color: Colors.teal,
        ),
        /*suffixIcon: IconButton(
          icon: Icon(Icons.text_fields),
            iconSize: 35.0,
            color: Colors.black,
            tooltip: tooltip,
            alignment: Alignment.centerRight,
            onPressed: onPressed,
          ),*/
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gapPadding: 4.0,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orangeAccent,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        errorStyle: TextStyle(color: Colors.black),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.red, width: 1.0, style: BorderStyle.solid),
        ),
      ),
      keyboardType: textInputType,
      textCapitalization: TextCapitalization.none,
      textInputAction: textInputAction,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor,
        fontStyle: FontStyle.italic,
      ),
      strutStyle: StrutStyle(),
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      autocorrect: true,
      enableSuggestions: true,
      maxLines: maxLines,
      validator: validate,
      /*(val)=> !val.contains(pattern) ||  val.isEmpty? 'Invalid Charachters': null,*/
      //onSaved: (val)=> _text = val ,
      toolbarOptions:
          ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),
      autofocus: false,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
    );
  }
}
class FormTextFieldStandardObsecured extends StatelessWidget {
  FormTextFieldStandardObsecured(
      {Key? key,
        this.controller,
        this.textInputType,
        this.textInputAction,
        this.fontSize,
        this.fontWeight,
        this.fontColor,
        this.icon,
        this.onTap,
        this.onChanged,
        this.onFieldSubmitted,
        this.onEditingComplete,
        this.tooltip,
        this.onPressed,
        this.validate,
        this.formTextFieldLabel,
        this.maxLines,
      })
      : super(key: key);

  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final IconData? icon;

  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final String? tooltip;
  final Function()? onPressed;
  RegExp? regExp = new RegExp(r'^[a-zA-Z0-9_]+( [a-zA-Z0-9_]+)*$');
  Iterable<RegExpMatch>? matches;
  final String? Function(String?)? validate;

  final String? formTextFieldLabel;
  final int? maxLines;

  List<bool> obsecureListValues=[];
  List<bool>? getObsecureValue() {
    obsecureListValues.add(true);
    obsecureListValues.add(false);
    return obsecureListValues;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: null,
      focusNode: FocusNode(),
      decoration: InputDecoration(
        labelText: formTextFieldLabel,
        labelStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontStyle: FontStyle.italic),
        //hintText: 'Type Your Password',
        //hintStyle: TextStyle(color: Colors.black87,fontSize: 16.0),
        prefixIcon: Icon(
          icon,
          color: Colors.teal,
        ),
        /*suffixIcon: IconButton(
          icon: Icon(Icons.text_fields),
            iconSize: 35.0,
            color: Colors.black,
            tooltip: tooltip,
            alignment: Alignment.centerRight,
            onPressed: onPressed,
          ),*/
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gapPadding: 4.0,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orangeAccent,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        errorStyle: TextStyle(color: Colors.black),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.red, width: 1.0, style: BorderStyle.solid),
        ),
      ),
      keyboardType: textInputType,
      textCapitalization: TextCapitalization.none,
      textInputAction: textInputAction,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor,
        fontStyle: FontStyle.italic,
      ),
      strutStyle: StrutStyle(),
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      autocorrect: true,
      enableSuggestions: true,
      maxLines: maxLines,
      validator: validate,
      /*(val)=> !val.contains(pattern) ||  val.isEmpty? 'Invalid Charachters': null,*/
      //onSaved: (val)=> _text = val ,
      toolbarOptions:
      ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),
      autofocus: false,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      obscureText: true,
    );
  }
}
