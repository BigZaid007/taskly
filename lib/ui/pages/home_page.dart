import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../../services/notification_services.dart';
import '../../services/theme_services.dart';
import '../theme.dart';
import '../widgets/task_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TaskController taskController = Get.put(TaskController());

  ThemeServices theme = ThemeServices();
  DateTime currentDate = DateTime.now();
  Color tile = const Color(0xff324AB2);
  late NotifyHelper notify;
  late Task task;

  @override
  void initState() {
    super.initState();
    notify = NotifyHelper();
    notify.initializeNotification();
    taskController.getAllTaske();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () async {
            await Get.to(() => const AddTaskPage());
            taskController.getAllTaske();
          },
          child: const Icon(
            FontAwesomeIcons.pencil,
            color: Colors.white,
          ),
        ),
        backgroundColor: context.theme.backgroundColor,
        appBar: _appBar(context),
        body: SingleChildScrollView(
          child: Container(
            height: 900,
            child: Column(
              children: [
                _taskBar(),
                dateBar(),
                _showTask(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _taskBar() {
    String _currentDate =
        DateFormat('MMMM dd,yyyy').format(DateTime.now()).toString();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _currentDate.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Today',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _noTask() {
    return taskController.taskList.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('images/listaa.svg',
                  color: Colors.red.withOpacity(0.5),
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                  semanticsLabel: 'Todo List'),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'No Tasks Today',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.grey,
                    fontSize: 20),
              ),
              const Text(
                'Add Your First Task',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.grey,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 130,
              ),
            ],
          )
        : _showTask();
  }

  dateBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
      child: DatePicker(
        DateTime.now(),
        width: 70,
        initialSelectedDate: DateTime.now(),
        height: 100,
        dateTextStyle: GoogleFonts.roboto(
            fontSize: 22, fontWeight: FontWeight.w900, color: Colors.grey),
        dayTextStyle: GoogleFonts.roboto(
            fontSize: 18, fontWeight: FontWeight.w900, color: Colors.grey),
        monthTextStyle: GoogleFonts.alatsi(
            fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
        onDateChange: (newDate) {
          setState(() {
            currentDate = newDate;
          });
        },
        selectedTextColor: Colors.white,
        selectionColor: Colors.red,
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
          child: GestureDetector(
            onTap: () {},
            child: CircleAvatar(backgroundImage: AssetImage('images/boy.jpg')),
          ),
        )
      ],
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: IconButton(
        onPressed: () {
          ThemeServices().switchTheme();
        },
        icon: Get.isDarkMode
            ? Icon(Icons.wb_sunny_outlined)
            : Icon(FontAwesomeIcons.moon),
        color: Get.isDarkMode ? Colors.white70 : Colors.black,
      ),
    );
  }

  Widget _showTask() {
    return Expanded(
      child: Obx(() {
        if (taskController.taskList.isEmpty) {
          return Center(
            child: _noTask(),
          );
        } else {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var task = taskController.taskList[index];
              // var hour=task.startTime.toString().split(':')[0];
              // var min=task.startTime.toString().split(':')[1];
              // notify.scheduledNotification(int.parse(hour), int.parse(min), task);

              if (task.repeat == 'Daily' ||
                  task.date == DateFormat.yMd().format(currentDate) ||
                  ((task.repeat == 'Weekly' && currentDate.difference(DateFormat.yMd().parse(task.date!)).inDays % 7 == 0)) || (task.repeat=='Monthly' && (DateFormat.yMd().parse(task.date!).day)==currentDate.day )) {
                return GestureDetector(
                  onTap: () {
                    _showBottomSheet(context, task);
                  },
                  child: AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1000),
                    child: SlideAnimation(
                        verticalOffset: 300,
                        child: FadeInAnimation(child: TaskTile(task))),
                  ),
                );
              }

              return Container();
            },
            itemCount: taskController.taskList.length,
            padding: const EdgeInsets.all(5.0),
          );
        }
      }),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Get.isDarkMode ? Colors.black : Colors.white),
        width: MediaQuery.of(context).size.width,
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height / 4
            : MediaQuery.of(context).size.height / 3,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            if (task.isCompleted == 1)
              Container()
            else
              GestureDetector(
                onTap: () {
                  setState(() {
                    task.isCompleted = 1;
                    notify.cancelNotification(task);
                    Get.back();
                  });
                },
                child: Container(
                    height: 65,
                    width: 350,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: tile),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 24,
                        )
                      ],
                    )),
              ),
            const SizedBox(
              height: 3,
            ),
            GestureDetector(
              onTap: () {
                taskController.deleteTasks(task);
                notify.cancelNotification(task);
                Get.back();
              },
              child: Container(
                  height: 65,
                  width: 350,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      color: tile),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Delete',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Icon(
                        FontAwesomeIcons.trash,
                        color: Colors.red,
                        size: 24,
                      )
                    ],
                  )),
            ),
            const SizedBox(
              height: 3,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                  height: 65,
                  width: 350,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      color: tile),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                        size: 24,
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}
