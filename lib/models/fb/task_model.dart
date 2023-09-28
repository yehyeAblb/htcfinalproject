class TaskModel {
  String? id;
  String? title;
  String? content;
  TaskModel({
    this.id,
    this.title,
    this.content,
  });
  ///from json
 TaskModel.fromJson(Map<String,dynamic>json){
   id = json['id'];
   title = json['title'];
   content = json['content'];
 }
 Map<String,dynamic> toJson (){
   Map<String,dynamic> json = {};

   json['id'] =  id;
   json['title'] = title;
   json['content'] = content;
   return json;
 }
  }