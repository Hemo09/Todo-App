import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkaz/shared/Component/component.dart';
import 'package:inkaz/shared/Component/constrains.dart';
import 'package:inkaz/shared/Cubit/AppCubit.dart';
import 'package:inkaz/shared/Cubit/AppStates.dart';

class NewTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        var tasks = AppCubit.get(context).newTasks;
        return  Scaffold(
            body: ListView.separated(
                itemBuilder: (context, index) => buildChatItem(tasks[index],context),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(start: 30.0),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.blueGrey[200],
                  ),
                ),
                itemCount: tasks!.length));
      },

    );
  }
}
