import 'package:flutter/material.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/menu_items.dart';
import 'package:strike_task/model/menu_item_model.dart';

import '../../../../constants/menu_items.dart';

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
            Text('Lorem ipsum dolor sit amet'),
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton<MenuItemModel>(
                  icon: Icon(Icons.arrow_drop_down),
                    itemBuilder: (context) => [
                      ...menuItems.map((e) => PopupMenuItem(child: Row(children: [e.icon!,e.text!],)))
                    ])
                // IconButton(padding: EdgeInsets.zero,onPressed: (){}, icon: Icon(Icons.edit,color: mutedTextColor,)),
                // IconButton(padding:EdgeInsets.zero,onPressed: (){}, icon: Icon(Icons.delete,color: mutedTextColor,)),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
