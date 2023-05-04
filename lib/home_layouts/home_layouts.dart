import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkaz/Archive%20Tasks/archiveTasks.dart';
import 'package:inkaz/Done%20Tasks/DoneTasks.dart';
import 'package:inkaz/new%20Tasks/New_tasks.dart';
import 'package:inkaz/shared/Component/component.dart';
import 'package:inkaz/shared/Component/constrains.dart';
import 'package:inkaz/shared/Cubit/AppCubit.dart';
import 'package:inkaz/shared/Cubit/AppStates.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class home_layouts extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var validateKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController TimeController = TextEditingController();
  TextEditingController DateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabase) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = BlocProvider.of(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              leading: Icon(cubit.Icon[cubit.currentIndex] ,),
              backgroundColor: Colors.deepPurple,
              title: Text(cubit.textAppBar[cubit.currentIndex]),
            ),
            body: ConditionalBuilderRec(
              condition: state is! AppGetLoadingDatabase,
              fallback: (context) =>
                  Center(child: const CircularProgressIndicator()),
              builder: (context) => cubit.screen[cubit.currentIndex],
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.deepPurple,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeNavBar(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: (Icon(Icons.menu)), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: (Icon(Icons.done)), label: 'Done'),
                BottomNavigationBarItem(
                    icon: (Icon(Icons.archive)),
                    label: 'Archive'),
              ],
            ),
            floatingActionButton: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.deepPurple,
              ),
              width: 150,
              child: FloatingActionButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(AppCubit.get(context).fabIcon),
                    Text(
                      'Add Task',
                    )
                  ],
                ),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                onPressed: () {
                  if (AppCubit.get(context).isBottomSheetShown) {
                    if (validateKey.currentState!.validate()) {
                     cubit.insertToDatabase(titleController.text, TimeController.text, DateController.text);
                      //   Navigator.pop(context);
                      //   isBottomSheetShown = false;
                      //   /*     setState(() {
                      //   fabIcon = Icons.edit;
                      // });*/
                    }
                  } else {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) => Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                key: validateKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultTextForm(
                                        label: 'Title',
                                        controller: titleController,
                                        prefix: Icons.title,
                                        hint: 'Enter Title',
                                        type: TextInputType.text,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Title Must Not Be Empty';
                                          }
                                        }),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    defaultTextForm(
                                        hint: 'Enter Time',
                                        type: TextInputType.text,
                                        prefix: Icons.timelapse,
                                        controller: TimeController,
                                        label: 'Time',
                                        ontap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) {
                                            TimeController.text = value!
                                                .format(context)
                                                .toString();
                                            print(value
                                                .format(context)
                                                .toString());
                                          }).catchError((error) {
                                            print(
                                                'Error when pass time is ${error.toString()}');
                                          });
                                        },
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Time Must Not Be Empty';
                                          }
                                        }),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    defaultTextForm(
                                        hint: 'Enter Date',
                                        type: TextInputType.datetime,
                                        prefix: Icons.calendar_month_sharp,
                                        controller: DateController,
                                        label: 'Date',
                                        ontap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.parse(
                                                      '2023-07-12'))
                                              .then((value) {
                                            DateController.text =
                                                DateFormat.yMMMd()
                                                    .format(value!);
                                          }).catchError((error) {
                                            print(
                                                'Error when pass Date is ${error.toString()}');
                                          });
                                        },
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Date Must Not Be Empty';
                                          }
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .closed
                        .then(
                      (value) {
                        AppCubit.get(context)
                            .ChangeBootpmSheet(IsShow: false, icon: Icons.edit);
                        /*  setState(() {
                        fabIcon = Icons.edit;
                      });*/
                      },
                    );

                    AppCubit.get(context)
                        .ChangeBootpmSheet(IsShow: true, icon: Icons.add);
                    /*     setState(() {
                    fabIcon = Icons.add;
                  });*/
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
