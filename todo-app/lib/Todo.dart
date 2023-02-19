import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todolist/Shered/cubit/States.dart';
import 'package:todolist/Shered/cubit/cubit.dart';



class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is AppInsertDatabaseState)
          {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown)
                {
                  if (formKey.currentState!.validate())
                  {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                  }
                } else
                {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(
                        20.0,
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Task Title',
                                prefixIcon: Icon(Icons.title),
                              ),
                              controller: titleController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'value must be not empty';
                                }
                                return null;

                              },
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),

                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Time Title',
                                prefixIcon: Icon(
                                    Icons.watch_later_outlined),
                              ),
                              controller: timeController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'time must be not empty';
                                } else {
                                  return null;
                                }
                              },
                              onTap: () {
                                showTimePicker(
                                    context: context,
                                    initialTime:
                                    TimeOfDay.now())
                                    .then(
                                      (value) {
                                    timeController.text =
                                        value!.format(context);
                                  },
                                );
                              },
                              keyboardType: TextInputType.datetime,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),

                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Data Title',
                                prefixIcon:
                                Icon(Icons.add_comment),
                              ),
                              controller: dateController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Date must be not empty';
                                } else {
                                  return null;
                                }
                              },
                              onTap: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse(
                                        '2022-12-12'))
                                    .then((value) {
                                  dateController.text =
                                      DateFormat.yMMMd()
                                          .format(value!);
                                });
                              },
                              keyboardType: TextInputType.datetime,
                            ),
                          ],
                        ),
                      ),
                    ),
                    elevation: 20.0,
                  )
                      .closed
                      .then((value)
                  {
                    cubit.changeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });

                  cubit.changeBottomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}









