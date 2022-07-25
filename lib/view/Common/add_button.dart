import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class AddButton extends StatelessWidget {
  String? text;
  VoidCallback? onPressed;
  AddButton({this.text,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 135,
      child: MaterialButton(
        elevation: 0,
        color: primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
        shape: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              color: mutedlineColor,
            ),
            borderRadius: BorderRadius.circular(10)
        ),
        onPressed: onPressed,
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline,color: whiteColor,),
            SizedBox(width: 5,),
            Text(text??"",style: TextStyle(color: whiteColor),)
          ],
        ),
      ),
    );
  }
}
