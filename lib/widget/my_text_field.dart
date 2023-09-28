import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;


  const MyTextField({
    required this.controller,
    required  this.hint,
    this.maxLines =1,
    super.key});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {

  bool get isLong => widget.maxLines >1;
  @override
  Widget build(BuildContext context) {
    return TextField(

      controller: widget.controller,
      maxLines: widget.maxLines ,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w,vertical: isLong ? 15 :1),
        hintText: widget.hint,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isLong ? 15.r : 50.r),

          borderSide: BorderSide(
            width: 1.w,

            color: Colors.grey,


          )
        ),
        focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
       borderSide: BorderSide(
         width: 1.w,
          color:Theme.of(context).primaryColor,
        ),
        )
      ),
    );
  }
}
