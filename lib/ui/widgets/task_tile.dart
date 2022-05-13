import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../models/task.dart';
import '../theme.dart';

class TaskTile extends StatelessWidget {
  TaskTile(this.task, {Key? key}) : super(key: key);
  Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
      decoration: BoxDecoration(
        color: _bgColor(task.color),
        borderRadius: BorderRadius.circular(16),

      ),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title!,style: GoogleFonts.roboto(
                    letterSpacing: 1.2,
                    fontSize: 22,color: Colors.white,fontWeight: FontWeight.w900
                  ),),
                  const SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time,size: 20,color: Colors.grey[200],),
                      const SizedBox(width: 10,),
                      Text('${task.startTime} - ${task.endTime}',style: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[200],
                        fontSize: 15
                      ), )
                    ],
                  ),
                  SizedBox(height: 15,),
                  Text(task.note!,style: GoogleFonts.roboto(
                    fontSize: 15,fontWeight: FontWeight.w700,
                    color: Colors.white
                  ),)
                ],
              ),
            ),
          ),
          Container(decoration:BoxDecoration(
            color: _bgColor(task.color),
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.symmetric(horizontal: 8),
          height: 60,
          width: 0.5,),

          RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isCompleted == 0 ? 'TODO' : 'Completed',
                style:
                    const TextStyle(color: Colors.white, fontWeight: FontWeight.w700,fontSize: 12),
              ))
        ],
      ),
    );
  }

  _bgColor(int? color) {

    switch(color)
        {
      case 0:
        return magentaClr;

      case 1:
        return Color(0xffa61e4d);

      case 2:
        return bluishClr;

      case 3:
        return Color(0xffe3447c);

      case 4:
        return Color(0xff238034);



        }



  }
}
