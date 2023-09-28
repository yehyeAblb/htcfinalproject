import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yehyefirebasee/firebasa/tasks_fb_controller.dart';
import 'package:yehyefirebasee/models/fb/task_model.dart';
import 'package:yehyefirebasee/widget/my_button.dart';
import 'package:yehyefirebasee/widget/my_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';




class AddTaskScreen extends StatefulWidget {
  final TaskModel? task;
  const AddTaskScreen({
    this.task,
    super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
 late TextEditingController titleEditingController;
 late TextEditingController contentEditingController;
@override
  void initState() {
    super.initState();
    titleEditingController = TextEditingController(text: widget.task?.title ?? '');
    contentEditingController = TextEditingController(text: widget.task?.content ?? '');
  }
  @override
  void dispose() {
    titleEditingController.dispose();
    contentEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
        child: Column(
          children: [
            MyTextField(controller: titleEditingController, hint: AppLocalizations.of(context)!.title),
            SizedBox(height: 20.h,),
            MyTextField(controller: contentEditingController, hint: AppLocalizations.of(context)!.content,
            maxLines: 7),
            SizedBox(height: 20.h,),
            MyButton(text:widget.task==null ? AppLocalizations.of(context)!.add:AppLocalizations.of(context)!.upData,
              onTap: () async => await _performAction(),
              loading: loading,
            )
          ],
        ),
      ),
    );
  }
bool loading = false;
  Future<void>_performAction()async{
  if(checkData()){
    await _action();
  }
  }
  Future<void>_action()async{
    setState(() => loading =true );
 widget.task==null ? await TasksFbController().create(TaskModel(
    title: titleEditingController.text,
    content: contentEditingController.text,
    id: const Uuid().v4()
  )): await TasksFbController().update(TaskModel(
   id: widget.task!.id,
   title: titleEditingController.text,
   content: contentEditingController.text,
 ));
    setState(() => loading =false );
  if(context.mounted){
    Navigator.pop(context);
  }
  }
  bool checkData(){
  if(titleEditingController.text.isNotEmpty&&contentEditingController.text.isNotEmpty) {
    return true;
  }
  return false;
  }
}
