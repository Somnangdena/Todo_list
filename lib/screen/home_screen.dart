import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/config/theme.dart';
import 'package:todo_list/controllers/task_controller.dart';
import 'package:todo_list/screen/add_task_bar.dart';
import 'package:todo_list/screen/edit_task_screen.dart';
import 'package:todo_list/screen/notified_page.dart';
import 'package:todo_list/service/notification_service.dart';
import 'package:todo_list/service/theme_service.dart';

import '../models/task.dart';
import '../widgets/button.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper = NotifyHelper();

  @override
  void initState() {
    super.initState();
    //notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _addTaskBar(),
            // _addDateBar(),
            _addDateBar(),
            SizedBox(
              height: 10,
            ),
            _showTasks(),
          ],
        ),
      ),
    );
  }

  _showTasks() {
    return Obx(() {
      return SlidableAutoCloseBehavior(
        closeWhenOpened: true,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              Task task = _taskController.taskList[index];
              //print(task.toJson());
              // if (task.repeat == "Daily") {
              //   // var date = DateFormat.jm().parse(task.startTime!);
              //   // var myTime = DateFormat("HH:mm").format(date);
              //   //print(myTime);
              //   DateFormat inputFormat =
              //       DateFormat("h:mm a"); // 12-hour format with AM/PM
              //   DateTime parsedTime = inputFormat.parse(task.startTime!);
              //   DateFormat outputFormat = DateFormat("HH:mm"); // 24-hour format
              //   String formattedTime = outputFormat.format(parsedTime);
              //   notifyHelper.scheduledNotification(
              //       int.parse(formattedTime.toString().split(":")[0]),
              //       int.parse(formattedTime.toString().split(":")[1]),
              //       task);
              //   //print(formattedTime);
              //   return AnimationConfiguration.staggeredList(
              //       position: index,
              //       child: SlideAnimation(
              //           child: FadeInAnimation(
              //               child: Row(
              //         children: [
              //           GestureDetector(
              //             onTap: () {
              //               // _showBottomSheet(context, task);
              //             },
              //             child: TaskTile(
              //               task,
              //               onTapDone: (context) {
              //                 _taskController.markTaskCompleted(task);
              //                 print("done");
              //               },
              //               onTapEdit: (context) {},
              //               onTapDel: (context) {
              //                 _taskController.delete(task);
              //               },
              //             ),
              //           )
              //         ],
              //       ))));
              // }

              if (task.date == DateFormat.yMd().format(_selectedDate)) {
                if (task.repeat == "Daily") {
                  DateFormat inputFormat =
                      DateFormat("h:mm a"); // 12-hour format with AM/PM
                  DateTime parsedTime = inputFormat.parse(task.startTime!);
                  DateFormat outputFormat =
                      DateFormat("HH:mm"); // 24-hour format
                  String formattedTime = outputFormat.format(parsedTime);
                  notifyHelper.scheduledNotification(
                      int.parse(formattedTime.toString().split(":")[0]),
                      int.parse(formattedTime.toString().split(":")[1]),
                      task);
                }
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                            child: GestureDetector(
                      onTap: () => Get.to(() => NotifiedPage(
                          label:
                              "${task.title}|${task.note}|${task.date}|${task.startTime}|${task.endTime}|${task.isCompleted}")),
                      child: TaskTile(
                        task,
                        onTapDone: (context) {
                          _taskController.markTaskCompleted(task);
                        },
                        onTapEdit: (context) {
                          Get.to(() => EditTaskScreen(task: task));
                        },
                        onTapDel: (context) {
                          Get.defaultDialog(
                            titlePadding: EdgeInsets.only(top: 30),
                            backgroundColor:
                                Get.isDarkMode ? Colors.grey.shade900 : white,
                            title: 'Delete Task',
                            middleText:
                                'Are you sure you want to delete this task?',
                            textCancel: 'Cancel',
                            textConfirm: 'Delete',
                            confirmTextColor: Colors.white,
                            buttonColor: Colors.red,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            onConfirm: () {
                              _taskController.delete(task);
                              Get.back();
                            },
                            onCancel: () {
                              Get.back();
                            },
                          );
                        },
                      ),
                    ))));
              } else {
                return Container();
              }
            }),
      );
    });
  }

  _addDateBar() {
    return Container(
        margin: EdgeInsets.only(left: 15),
        child: EasyDateTimeLine(
          activeColor: primaryColor,
          initialDate: DateTime.now(),
          onDateChange: (date) {
            setState(() {
              _selectedDate = date;
            });
          },
          headerProps: EasyHeaderProps(showSelectedDate: false),
          dayProps: EasyDayProps(
            height: 100,
            width: 80,
            todayStyle: DayStyle(
                dayNumStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                monthStrStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                dayStrStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                )),
            activeDayStyle: DayStyle(
                dayNumStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600, color: white),
                ),
                monthStrStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600, color: white),
                ),
                dayStrStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600, color: white),
                )),
            inactiveDayStyle: DayStyle(
                dayNumStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                monthStrStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                dayStrStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                )),
            borderColor: Colors.grey,
          ),
        ));
  }

  _addTaskBar() {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                "Today",
                style: headingStyle,
              ),
            ],
          ),
          MyButton(
              label: " + Add Task ",
              onTap: () async {
                await Get.to(() => AddTaskBar());
                _taskController.getTask();
              })
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          /* notifyHelper.displayNotification(
              title: "Theme Chnaged",
              body: Get.isDarkMode
                  ? "Activated Light Theme"
                  : "Activated Dark Theme"); */
          // notifyHelper.scheduledNotification1();
          setState(() {});
        },
        child: Icon(
          ThemeService().loadThemeFromBox()
              ? Icons.wb_sunny_outlined
              : Icons.nightlight_round_outlined,
          size: 20,
        ),
      ),
    );
  }

  /* _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      width: double.infinity,
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      decoration: BoxDecoration(
          color: Get.isDarkMode ? darkGreyClr : white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          )),
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
          ),
          Spacer(),
          task.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  label: "Task Completed",
                  onTap: () {
                    _taskController.markTaskCompleted(task);
                    Get.back();
                  },
                  clr: bluishClr,
                  context: context),
          _bottomSheetButton(
              label: "Delete Task",
              onTap: () {
                _taskController.delete(task);
                Get.back();
              },
              clr: Colors.red[300]!,
              context: context),
          _bottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              isClose: true,
              clr: white,
              context: context),
        ],
      ),
    ));
  } */

  /* _bottomSheetButton({
    required String label,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        height: 55,
        alignment: AlignmentDirectional.center,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: isClose == true ? Colors.transparent : clr,
            border: Border.all(
                width: 2,
                color: isClose == true
                    ? Get.isDarkMode
                        ? Colors.grey[600]!
                        : Colors.grey[300]!
                    : clr),
            borderRadius: BorderRadius.circular(20)),
        child: Text(label,
            style: isClose
                ? titleStyle
                : titleStyle.copyWith(color: Colors.white)),
      ),
    );
  } */

  /*  _addDateBar() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectedTextColor: white,
        selectionColor: primaryColor,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }
 */
}
