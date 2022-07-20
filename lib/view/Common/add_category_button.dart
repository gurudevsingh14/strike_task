import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 135,
      child: MaterialButton(
        elevation: 0,
        color: Colors.grey.shade300,
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
        shape: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              color: mutedlineColor,
            ),
            borderRadius: BorderRadius.circular(10)
        ),
        onPressed: (){},
        child:
        Row(
          children: [
            Icon(Icons.add_circle_outline,color: whiteColor,),
            SizedBox(width: 5,),
            Text('Add Category',style: TextStyle(color: whiteColor),)
          ],
        ),
      ),
    );
  }
}
