import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Reusable.dart';
import 'Shered/cubit/States.dart';
import 'Shered/cubit/cubit.dart';

class Done extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
        listener: (context , state){}
        , builder: (context , state){
          var tasks = AppCubit.get(context).doneTasks;
      return ConditionalBuilder(
        condition: tasks.length >0,
        builder: (context) =>  ListView.separated(itemBuilder: (context,index)=>buildTaskItem(tasks[index],context),
            separatorBuilder: (context,index)=>Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 20.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.blueGrey[300],
              ),
            )
            , itemCount: tasks.length),
        fallback: (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Icon(
            Icons.menu,
            size: 90,
            color: Colors.grey,
          ),
              Text("No tasks done yet",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),

      );
    }
    );
  }

}
