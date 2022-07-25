import 'package:flutter/material.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/menu_items.dart';
import 'package:strike_task/model/menu_item_model.dart';
import 'package:strike_task/model/task_model.dart';

import '../../../../constants/menu_items.dart';
import '../../../../model/sub_task_model.dart';

class SubTaskTile extends StatefulWidget {
  SubTask subtask;
  SubTaskTile({required this.subtask});

  @override
  State<SubTaskTile> createState() => _SubTaskTileState();
}

class _SubTaskTileState extends State<SubTaskTile> {
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
            Checkbox(value: widget.subtask.done, onChanged: (value){
              setState(() {
                widget.subtask.done=value!;
              });
            }),
            Text(widget.subtask.text!),
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
