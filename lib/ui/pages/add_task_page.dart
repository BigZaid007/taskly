import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../theme.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final taskContoller = Get.put(TaskController());
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  DateTime currentDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(Duration(minutes: 15)))
      .toString();
  int _selectRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectRepeat = 'None';
  List<String> repeatList = ['Daily', 'Weekly', 'Monthly', 'None'];
  int _selectColor = 0;
  List<Color> ColorsList = [
    magentaClr,
    Color(0xffa61e4d),
    bluishClr,
    Color(0xffe3447c),
    Color(0xff40c057)
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: context.theme.backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Add Task',
            style: GoogleFonts.lato(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(
              height: 2,
            ),
            InputField(inputLabel: 'Title', textType: 'Add Title',textEditingController:titleController ,),
            InputField(inputLabel: 'Description', textType: 'Add Description',textEditingController: desController,),
            InputField(
              onTap: () {
                print('test2');
              },
              inputLabel: DateFormat.yMd().format(currentDate),
              textType: 'Date',
              widget: IconButton(
                  onPressed: () {
                    _getDate();
                  },
                  icon: const Icon(Icons.calendar_today)),
            ),
            Row(
              children: [
                Expanded(
                  child: InputField(
                    inputLabel: _startTime,
                    textType: 'Start Time',
                    widget: IconButton(
                      onPressed: () {
                        _getTime(isStart: true);
                      },
                      icon: Icon(FontAwesomeIcons.stopwatch),
                    ),
                  ),
                ),
                Expanded(
                  child: InputField(
                    inputLabel: _endTime,
                    textType: 'End Time',
                    widget: IconButton(
                      onPressed: () {
                        _getTime(isStart: false);
                      },
                      icon: Icon(FontAwesomeIcons.stopwatch),
                    ),
                  ),
                ),
              ],
            ),
            InputField(
                inputLabel: '$_selectRemind Minutes Early',
                textType: 'Remind',
                widget: DropdownButton(
                  items: remindList
                      .map<DropdownMenuItem<String>>(
                          (value) => DropdownMenuItem(
                                child: Text('$value'),
                                value: value.toString(),
                              ))
                      .toList(),
                  icon: const Icon(FontAwesomeIcons.arrowDown),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectRemind = int.parse(newValue!);
                    });
                  },
                )),
            InputField(
                inputLabel: '$_selectRepeat',
                textType: 'Repeat',
                widget: DropdownButton(
                  items: repeatList
                      .map<DropdownMenuItem<String>>(
                          (value) => DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              ))
                      .toList(),
                  icon: const Icon(
                    FontAwesomeIcons.arrowDown,
                  ),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectRepeat = newValue.toString();
                    });
                  },
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text('Color',
                    style: GoogleFonts.roboto(
                        fontSize: 26, fontWeight: FontWeight.w900)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                        5,
                        (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 3),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectColor = index;
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: ColorsList[index],
                                  child: _selectColor == index
                                      ? const Icon(Icons.check)
                                      : null,
                                ),
                              ),
                            )),
                  ),
                  GestureDetector(
                    onTap: () {
                     validateData();
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Done',
                            style: GoogleFonts.roboto(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                          const Icon(FontAwesomeIcons.checkToSlot)
                        ],
                      ),
                      width: 150,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: magentaClr),
                    ),
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  validateData() {
    if (titleController.text.isNotEmpty && desController.text.isNotEmpty) {
      _addTask();
      Get.back();
    }
    else
      print('error');
  }

  _addTask() async {

    int value=await taskContoller.addTask(task:Task(
        title: titleController.text,
        note: desController.text,
        color: _selectColor,
        date: DateFormat.yMd().format(currentDate),
        endTime: _endTime,
        startTime: _startTime,
        isCompleted: 0,
        remind: _selectRemind,
        repeat: _selectRepeat
    ));

    print(value);

  }

  _getDate() async {
    DateTime? _pickedTime;
    _pickedTime = await showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      context: context,
    );
    if (_pickedTime != null) {
      setState(() {
        currentDate = _pickedTime!;
      });
    }
  }

  _getTime({required bool isStart}) async {
    TimeOfDay? _pickedTime;
    _pickedTime=await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: isStart
            ? TimeOfDay.fromDateTime(DateTime.now())
            : TimeOfDay.fromDateTime(
                DateTime.now().add(const Duration(minutes: 10))));
    String formattedTime=_pickedTime!.format(context);
    if(isStart)
      {
        setState(() {
          _startTime=formattedTime;
        });
      }
    else if(!isStart)
    {
      setState(() {
        _endTime=formattedTime;
      });
    }


  }
}
