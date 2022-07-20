import 'package:flutter/material.dart';

class SubTaskTile extends StatelessWidget {
  const SubTaskTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Checkbox(value: true, onChanged: (value){}),
            Column(
              children: [
                Text('Lorem ipsum dolor sit amet'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
