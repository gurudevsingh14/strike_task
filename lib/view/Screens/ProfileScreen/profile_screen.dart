import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/device_size.dart';
import 'package:strike_task/view/Common/custom_round_rect_button.dart';
import 'package:strike_task/view/Common/percentage_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/user-profile-bg.jpg'),
          Positioned(
            top: 10,
              left: 10,
              child: CircleAvatar(backgroundColor: primaryColor,radius:23,child: IconButton(color: Colors.white,highlightColor: Colors.black45,onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_outlined))))
        ],
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        alignment: Alignment.bottomCenter,
        height: displayHeight(context) * 0.82,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: displayHeight(context) * 0.75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),
              ),
            ),
            Positioned(
              top: displayHeight(context) * 0.02,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                elevation: 10,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/dp.jpg'),
                  backgroundColor: primaryColor,
                ),
              ),
            ),
            Positioned(
              top: displayHeight(context) * 0.14,
              child: Container(
                width: displayWidth(context),
                child: Column(
                  children: [
                    Text(
                      "Gurudev Singh",
                      style: TextStyle(
                          fontSize: 24,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                      maxLines: 2,
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      height: 85,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [CircleAvatar(
                              radius: 23,
                              backgroundColor: Colors.blue.withOpacity(0.3),
                              child: Icon(Icons.create_new_folder_outlined,color: Colors.blue,),
                            ),
                              Text('37',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              Text('Created Tasks',style: TextStyle(fontSize: 12,color: mutedTextColor),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [CircleAvatar(
                              radius: 23,
                              backgroundColor: Colors.green.withOpacity(0.3),
                              child: Icon(Icons.task_outlined,color: Colors.green,),
                            ),
                              Text('37',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              Text('Completed Tasks',style: TextStyle(fontSize: 12,color: mutedTextColor),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [CircleAvatar(
                              radius: 23,
                              backgroundColor: Colors.orange.withOpacity(0.3),
                              child: Icon(Icons.local_fire_department_rounded,color: Colors.orange,),
                            ),
                              Text('37',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              Text('Highest Streak',style: TextStyle(fontSize: 12,color: mutedTextColor),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12,),
                    Divider(thickness: 1,),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14,vertical: 8),
                        alignment: Alignment.topCenter,
                        // height: 100,
                        width: displayWidth(context)*0.95,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  Text('Today\'s Progress',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black45),),
                                  Row(
                                  children: [
                                    Icon(Icons.local_fire_department_sharp,color: Colors.deepOrangeAccent,),
                                    Text('48',style: TextStyle(color: Colors.deepOrangeAccent,),),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        Text('Completed',style: TextStyle(color: mutedTextColor),),
                                        SizedBox(width: 8,),
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.green.shade300),
                                          child: Text('33',style: TextStyle(color: whiteColor),),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 8,),
                                    // Row(
                                    //   children: [
                                    //     Text('Due Date Passed',style: TextStyle(color: textColor)),
                                    //     SizedBox(width: 8,),
                                    //     Container(
                                    //       padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                                    //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.blue.shade300),
                                    //       child: Text('12',style: TextStyle(color: whiteColor)),
                                    //     )
                                    //   ],
                                    // ),
                                    Row(
                                      children: [
                                        Text('Pending',style: TextStyle(color: mutedTextColor)),
                                        SizedBox(width: 8,),
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.yellow.shade300),
                                          child: Text('30',style: TextStyle(color: whiteColor)),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    CustomRoundRectButton(text: 'Check Tasks', height: 30,width: displayWidth(context)*0.36,radius: 40,),
                                  ],
                                ),
                                Spacer(),
                                PercentageIndicator(
                                  radius: displayWidth(context)*0.12,
                                  percentage: 0.7,
                                  lineWidth: 10,
                                ),
                                SizedBox(width: 20,),
                              ],
                            ),
                          ]
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          // height: 50,
                          width: displayWidth(context)*0.95,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green.withOpacity(0.5),
                                ),
                                child: Icon(Icons.archive_outlined,color: Colors.green,),
                              ),
                              SizedBox(width: 20,),
                              Text('Archived'),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios,size: 18,),
                            ],
                          ),
                      )
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
