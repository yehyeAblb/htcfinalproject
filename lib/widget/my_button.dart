import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton extends StatefulWidget {
  final String text;
  final Function()? onTap;
  final bool loading;
  const MyButton({
    required this.text,
    this.onTap,
    this.loading = false,
    super.key});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !widget.loading? widget.onTap : null ,
      child: Container(
        height: 45.h,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(50.r)
        ),
        child: !widget.loading ? Text(widget.text,
          style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500
              ,color: Colors.white
          ),) : CircularProgressIndicator(color: Colors.red,),
      ),
    );
  }
}
