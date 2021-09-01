import 'package:flutter/material.dart';


class StandardElevatedButton extends StatelessWidget {
  const StandardElevatedButton({Key? key, this.style, this.child, this.onPressed}): super(key: key);
  final ButtonStyle? style ;
  final Widget? child;
  final Function()? onPressed ;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: () {},
      style: ButtonStyle(
        textStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(MaterialState.hovered)) {
            return TextStyle();
          }
          return TextStyle();
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).colorScheme.primary.withOpacity(0.5);
          }
          return Colors.white;
        }),
      ),
      focusNode: FocusNode(),
      clipBehavior: Clip.hardEdge,
      child: child,
    );
  }
}

class UserAccountImageButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? icon;
  //final IconData buttonIcon;

  const UserAccountImageButton({this.icon,this.onPressed}) ;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: icon );
  }
}
