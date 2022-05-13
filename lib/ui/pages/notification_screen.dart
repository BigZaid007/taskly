import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key, required this.notificationString})
      : super(key: key);
  String notificationString;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String noteString = '';
  String userName = 'Zaid H.Qassim';
  @override
  void initState() {
    noteString = widget.notificationString;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text('Reminder',style: TextStyle(
            color: Get.isDarkMode?Colors.white:Colors.black,fontSize: 25
          ),),
          centerTitle: true,
          backgroundColor:
              Get.isDarkMode ? context.theme.backgroundColor : Colors.red,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  'Hi, $userName',
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const Text(
              'You Have a new Reminder',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(
                              FontAwesomeIcons.noteSticky,
                              color: Colors.white,
                              size: 28,
                            ),
                            SizedBox(
                              width: 12,
                            ),

                            Text(
                              'Title',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),


                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          noteString.split('|')[0],
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        ),
                        //const SizedBox(height: 3,),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Divider(color: Colors.white,thickness: 1.2),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.description,
                              color: Colors.white,
                              size: 28,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),

                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          noteString.split('|')[1],
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        ),
                        //const SizedBox(height: 3,),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Divider(color: Colors.white,thickness: 1.2),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(
                              FontAwesomeIcons.calendarPlus,
                              color: Colors.white,
                              size: 28,
                            ),
                            SizedBox(
                              width: 12,
                            ),

                            Text(
                              'Time',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),

                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          noteString.split('|')[2],
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        ),
                        //const SizedBox(height: 3,),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Divider(color: Colors.white,thickness: 1.2),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
