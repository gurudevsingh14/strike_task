import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/device_size.dart';
import 'package:strike_task/constants/menu_items.dart';
import 'package:strike_task/model/menu_item_model.dart';
import 'package:strike_task/model/task_model.dart';
import 'package:strike_task/providers/task_provider.dart';

import '../../../../constants/menu_items.dart';
import '../../../../model/sub_task_model.dart';

class SubTaskTile extends StatefulWidget {
  SubTask subtask;
  int? index;
  SubTaskTile({required this.subtask,this.index});

  @override
  State<SubTaskTile> createState() => _SubTaskTileState();
}

class _SubTaskTileState extends State<SubTaskTile> {
  @override
  Widget build(BuildContext context) {
    final taskDataController=Provider.of<TaskProvider>(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Slidable(
        child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
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
                    widget.subtask.done=!widget.subtask.done;
                    taskDataController.updateSubTask(taskDataController.selectedTask, widget.subtask);
                  });
                }),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: displayWidth(context)*0.73,
                    child: Text(widget.subtask.name??'',maxLines: 50,)),
                // Expanded(child: Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     PopupMenuButton<MenuItemModel>(
                //       icon: Icon(Icons.arrow_drop_down),
                //         itemBuilder: (context) => [
                //           ...menuItems.map((e) => PopupMenuItem(child: Row(children: [e.icon!,e.text!],)))
                //         ])
                //     // IconButton(padding: EdgeInsets.zero,onPressed: (){}, icon: Icon(Icons.edit,color: mutedTextColor,)),
                //     // IconButton(padding:EdgeInsets.zero,onPressed: (){}, icon: Icon(Icons.delete,color: mutedTextColor,)),
                //   ],
                // ))
              ],
            ),
          ),
        ),
        endActionPane: ActionPane(
          extentRatio: 1/2.3,
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              onPressed: (context) {
              },
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            SlidableAction(
              onPressed: (context) {
                setState(() {
                  taskDataController.deleteSubTask(taskDataController.selectedTask, widget.subtask);
                });
              },
              backgroundColor: Color(0xFF0392CF),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
          ],
        ),
      ),
    );
  }
}
