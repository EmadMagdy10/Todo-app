import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/Reusable.dart';
import 'package:todolist/Shered/cubit/States.dart';
import 'package:todolist/Shered/cubit/cubit.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).newTasks;
          return ConditionalBuilder(
            condition: tasks.length > 0 ,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) =>
                    buildTaskItem(tasks[index], context),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 20.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.blueGrey[300],
                  ),
                ),
                itemCount: tasks.length),
            fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(
                Icons.menu,
                size: 90,
                color: Colors.grey,
              ),
                  Text("Add some tasks",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          );
        });
  }
}
