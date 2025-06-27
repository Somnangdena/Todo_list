import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/config/theme.dart';

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
        startActionPane: ActionPane(motion: DrawerMotion(), children: [
          SlidableAction(
            onPressed: (context) => onTapDone.call(context),
            backgroundColor: Colors.green,
            icon: Icons.done_rounded,
            label: 'Done',
            borderRadius: BorderRadius.circular(16),
          ),
        ]),
        endActionPane: ActionPane(motion: DrawerMotion(), children: [
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
                          color: Colors.white),
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
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${task!.startTime} - ${task!.endTime}",
                        style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(fontSize: 13, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    task?.note ?? "",
                    style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontSize: 15, color: Colors.grey[100]),
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
                      color: Colors.white),
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
