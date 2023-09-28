import 'package:flutter/material.dart';
import 'package:yehyefirebasee/Helpers/navigator_helper.dart';
import 'package:yehyefirebasee/screens/add_task_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../firebasa/tasks_fb_controller.dart';
import '../../models/fb/task_model.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> with NavigatorHelper {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('task'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          actions: [
            IconButton(
                onPressed: ()=> jump(context, to: const AddTaskScreen()),
                icon: const Icon(Icons.add))
          ],
        ),
        body: StreamBuilder(
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }else if( snapshot.hasData && snapshot.data!.docs.isNotEmpty){
              List<TaskModel> task = snapshot.data!.docs.map((querySnapshotOfModel) => querySnapshotOfModel.data()).toList();
              return  ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 5.h),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: ()=> jump(context, to: AddTaskScreen(task: task[index],)),
                      child: Stack(

                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey.shade300),

                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(task[index].title??''),
                                SizedBox(height: 15.h,),
                                Text(task[index].content??''),
                              ],
                            ),
                          ),
                          PositionedDirectional(
                            end: 0,
                            child: IconButton(onPressed: () async{
                              await TasksFbController().delete(task[index]);
                            }, icon:const Icon(Icons.delete,color: Colors.red,)),
                          )
                        ],

                      ),
                    );
                  }, separatorBuilder: (context, index) {
                return SizedBox(height: 15.h,);

              }, itemCount:task.length);
            }else{
              return Center(child: Text(AppLocalizations.of(context)!.noData),);
            }
          },
          stream:TasksFbController().read(),
        )



    );
  }
}
