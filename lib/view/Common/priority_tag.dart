import 'package:flutter/material.dart';

class PriorityTag extends StatelessWidget {
  const PriorityTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 16),
        child: Text('high',maxLines: 2,style: TextStyle(fontSize: 12,color: Colors.red),)
    );
  }
}
