import 'package:flutter/material.dart';
import 'package:strike_task/view/Screens/CalendarScreen/calendar_screen.dart';
import 'package:strike_task/view/Common/catergory_card.dart';
import 'package:strike_task/view/Screens/HomeScreen/home_screen.dart';
import 'package:strike_task/view/Screens/ProfileScreen/profile_screen.dart';

import '../view/Screens/TimelineScreen/timeline_screen.dart';

//colors
// const primaryColor=Color(0xFB29C979);
final primaryColor=Colors.teal.shade400;
const primayDarkColor=Color(0xFB21A362);
const primayLightColor=Color(0xFB47D990);
const whiteColor=Colors.white;
const blackColor=Colors.black;
final mutedlineColor=Colors.grey.shade300;
final mutedTextColor=Colors.grey.shade500;
//fonts
const lato="Lato";

//screen list
final screens=[HomeScreen(),CalendarScreen(),TimelineScreen(),ProfileScreen()];