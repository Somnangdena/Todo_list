import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/config/theme.dart';
import 'package:todo_list/service/theme_service.dart';

import '../../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task? task;
  final Function(BuildContext context) onTapDone;
  final Function(BuildContext context) onTapEdit;
  final Function(BuildContext context) onTapDel;

  const TaskTile(this.task,
      {super.key,
      required this.onTapDone,
      required this.onTapEdit,
      required this.onTapDel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Slidable(
        closeOnScroll: true,
        startActionPane: ActionPane(motion: DrawerMotion(), children: [
          SlidableAction(
            onPressed: (context) => onTapDone.call(context),
            backgroundColor: Colors.green,
            icon: Icons.done_rounded,
            label: 'Done',
            borderRadius: BorderRadius.circular(16),
          ),
        ]),
        endActionPane:
            ActionPane(extentRatio: 0.6, motion: DrawerMotion(), children: [
          SlidableAction(
            foregroundColor: Colors.white,
            onPressed: (context) => onTapEdit.call(context),
            backgroundColor: Colors.amber,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: BorderRadius.circular(16),
          ),
          SlidableAction(
            foregroundColor: Colors.white,
            onPressed: (context) => onTapDel.call(context),
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.circular(16),
          ),
        ]),
        child: Container(
          padding: EdgeInsets.all(16),
          //  width: SizeConfig.screenWidth * 0.78,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: _getBGClr(task?.color ?? 0),
          ),
          child: Row(children: [
            Container(
              width: 10,
              height: 90,
              decoration: BoxDecoration(
                  color: _get1BGClr(task?.color ?? 0),
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(right: 10),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task?.title ?? "",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _get1BGClr(task?.color ?? 0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: ThemeService().loadThemeFromBox()
                            ? white
                            : darkGreyClr,
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${task!.startTime} - ${task!.endTime}",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: ThemeService().loadThemeFromBox()
                                ? white
                                : darkGreyClr,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    task?.note ?? "",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: ThemeService().loadThemeFromBox()
                            ? white
                            : darkGreyClr,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withValues(alpha: 0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task!.isCompleted == 1 ? "COMPLETED" : "TODO",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color:
                        ThemeService().loadThemeFromBox() ? white : darkGreyClr,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr.withValues(alpha: 0.3);
      case 1:
        return pinkClr.withValues(alpha: 0.3);
      case 2:
        return yellowClr.withValues(alpha: 0.3);
      default:
        return bluishClr.withValues(alpha: 0.3);
    }
  }

  _get1BGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      default:
        return bluishClr;
    }
  }
}
