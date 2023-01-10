import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/device_size.dart';
import 'package:strike_task/constants/priority.dart';
import 'package:strike_task/providers/category_provider.dart';
import 'package:strike_task/controller/dateTime_controller.dart';
import 'package:strike_task/model/task_model.dart';
import 'package:strike_task/providers/task_provider.dart';
import 'package:strike_task/providers/user_provider.dart';
import 'package:strike_task/view/Common/add_button.dart';
import 'package:strike_task/view/Common/custom_drop_down_field.dart';
import 'package:strike_task/view/Common/custom_round_rect_button.dart';
import 'package:strike_task/view/Common/custom_text_field.dart';
import 'package:strike_task/view/Common/date_picker_field.dart';
import 'package:strike_task/view/Common/priority_tag.dart';
import 'package:uuid/uuid.dart';
import '../../controller/priority_select_controller.dart';

class CreateTaskModal extends StatefulWidget {
  @override
  State<CreateTaskModal> createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends State<CreateTaskModal> {
  TextEditingController taskNameController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController priorityController = TextEditingController();

  TextEditingController addCategoryController = TextEditingController();

  var uuid=Uuid();

  final _formKey = GlobalKey<FormState>();
  bool loading=false;

  @override
  void dispose(){
    taskNameController.dispose();
    descriptionController.dispose();
    priorityController.dispose();
    addCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PrioritySelectController>(context);
    final dueDateController=Provider.of<DateTimeController>(context);
    final categoryController=Provider.of<CategoryProvider>(context);
    final taskController = Provider.of<TaskProvider>(context);
    final prioritySelectController = Provider.of<PrioritySelectController>(context);
    final userProvider=Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
        backgroundColor: primaryColor,
        leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios,),padding: EdgeInsets.zero,),
      ),
      body: SafeArea(
        child: Padding(
          // padding: EdgeInsets.symmetric(horizontal: 8.0),
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,right: 8.0,left: 8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // IconButton(onPressed: (){
                  //   Navigator.pop(context);
                  // }, icon: Icon(Icons.arrow_back_ios,),padding: EdgeInsets.zero,),
                  // Padding(
                  //   padding: const EdgeInsets.all(12.0),
                  //   child: Text(
                  //     'Create Task',
                  //     style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  Container(
                    width: displayWidth(context),
                    alignment: Alignment.center,
                      child: Image.asset('assets/images/create_task.png',height: displayHeight(context)*0.27,)),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                          flex: 6,
                          child: CustomDropDownField(
                            validator: (value){
                              if(value==null){
                                return "Select category";
                              }
                              return null;
                            },
                          )),
                      Flexible(
                          flex: 1,
                          child: SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                'or',
                                style: TextStyle(color: mutedTextColor),
                              ),
                            ),
                          )),
                      Flexible(flex: 6, child: AddButton(text: 'Add category',onPressed: (){
                        showDialog(context: context, builder: (context) {
                          final formKey=GlobalKey<FormState>();
                          return Form(
                            key: formKey,
                            child: AlertDialog(
                              title: CustomTextField(
                                label: "Enter Category",
                                textController: addCategoryController,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Enter category";
                                  }
                                  return  null;
                                },
                              ),
                              actions: [
                                TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel'),),
                                TextButton(onPressed: ()async{
                                  if(formKey.currentState!.validate()){
                                    await categoryController.addcategory(addCategoryController.text);
                                    addCategoryController.text="";
                                    Navigator.pop(context);
                                  }
                                }, child: Text('Ok'),)
                              ],),
                          );
                        },);
                      },)),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    label: 'Task name',
                    textController: taskNameController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter task name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    label: 'Add description',
                    textController: descriptionController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  DatePickerField(),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '  Priority',
                    style: TextStyle(color: mutedTextColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value){
                      print(value);
                      if(prioritySelectController.selectedPriority==null)
                        return "Select priority";
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isCollapsed: true,
                      filled: false,
                      prefixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: priorityList
                            .map((priority, value) => MapEntry(
                            priority,
                            SizedBox(
                                height: 35,
                                child: InkWell(
                                    onTap: () {
                                      controller.selectedPriority = priority;
                                      priorityController =
                                          TextEditingController(text: priority);
                                    },
                                    child: PriorityTag(
                                      priorityObj: value,
                                      fontSize: 16,
                                      selected:
                                      controller.selectedPriority == priority
                                          ? true
                                          : false,
                                    )))))
                            .values
                            .toList(),
                      ),
                    ),
                  ),
                  Center(
                    child: loading?CircularProgressIndicator():null,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomRoundRectButton(
        text: 'Create Task',
        width: displayWidth(context)*0.96,
        height: 50,
        fontSize: 18,
        callBack: () async {
          if(_formKey.currentState!.validate()){
            setState(() {
              loading=true;
            });
            DateTime date= dueDateController.selectedDate;
            print('--------${date.day}/${date.month}/${date.year}---------');
            await taskController.addTask(FirebaseAuth.instance.currentUser!.uid,Task(
                id: uuid.v1(),
                name: taskNameController.text,
                category: categoryController.selectedCategory,
                description: descriptionController.text,
                dueDate: DateTime(date.year,date.month,date.day,23,59,59),
                priority: priorityController.text));
                categoryController.selectedCategory=null;
                prioritySelectController.selectedPriority=null;
                dueDateController.selectedDate=DateTime.now();
                setState(() {
                  loading=false;
                });
                Navigator.pop(context);
          }
        },
      ),
    );
  }
}
