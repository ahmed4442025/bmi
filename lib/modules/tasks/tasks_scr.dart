import 'package:bmi_calculator/shared/components.dart';
import 'package:bmi_calculator/shared/cubit/cubit.dart';
import 'package:bmi_calculator/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Tasks extends StatelessWidget {
  Tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates states) {},
        builder: (BuildContext context, AppStates states) {
          AppCubit cubit = AppCubit.get(context);
          return mainContainer(cubit);
        }
    );
  }

  mainContainer(AppCubit cubit) => Container(
        child: cubit.allTasksP.isEmpty
            ?  Center(child: tempW())
            : buildListView(cubit),
      );

  Widget tempW()=>Container(
    // child: CircularProgressIndicator(),
    child: comp.simpleText(txt: 'Plz wait a sec . . .'),
  );

  Widget buildListView(AppCubit cubit) => ListView.separated(
      itemBuilder: (context, index) =>
          comp.buildTaskItem(cubit.allTasksP[index]),
      separatorBuilder: (context, index) => Container(
            height: 1,
            color: Colors.grey[300],
          ),
      itemCount: cubit.allTasksP.length);

  // ====== vars =======
  Components comp = Components();

// ====== methods ======

}
