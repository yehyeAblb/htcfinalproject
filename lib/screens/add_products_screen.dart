import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import 'package:yehyefirebasee/Helpers/pickers_helper.dart';
import 'package:yehyefirebasee/firebasa/fb_storage_controller.dart';
import 'package:yehyefirebasee/firebasa/product_fb_controller.dart';
import 'package:yehyefirebasee/widget/my_button.dart';
import 'package:yehyefirebasee/widget/my_text_field.dart';

import '../models/fb/product_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen>
    with PickersHelper {
  late TextEditingController nameEditingController;
  late TextEditingController priceEditingController;
  late TextEditingController descriptionEditingController;
  @override
  void initState() {
    nameEditingController = TextEditingController();
    priceEditingController = TextEditingController();
    descriptionEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    priceEditingController.dispose();
    descriptionEditingController.dispose();
    super.dispose();
  }

  List<File> productImages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddProduct'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.w),
        children: [
          SizedBox(
            height: 20.h,
          ),
          MyTextField(controller: nameEditingController, hint: 'productName'),
          SizedBox(
            height: 20.h,
          ),
          MyTextField(controller: priceEditingController, hint: 'price'),
          SizedBox(
            height: 20.h,
          ),
          MyTextField(
              controller: descriptionEditingController, hint: 'description'),
          SizedBox(
            height: 20.h,
          ),
          InkWell(
            onTap: () async {
              productImages.addAll(await pickImages());
              setState(() {});
            },
            child: Container(
              height: 120.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListView.separated(
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100.w,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(
                            productImages[index],
                            fit: BoxFit.cover,
                          ),
                          PositionedDirectional(
                              top: -10,
                              end: -10,
                              child: IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Color(0xffFF4F4F)),
                                onPressed: () {
                                  setState(() {
                                    productImages.remove(productImages[index]);
                                  });
                                },
                              ))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 10.w,
                    );
                  },
                  itemCount: productImages.length),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          MyButton(
            text: 'ADD',
            loading: loading,
            onTap: () async => await _perfromAction,
          )
        ],
      ),
    );
  }

  bool loading = false;
  Future<void> get _perfromAction async {
    if (checdData) {
      await _action;
    }
  }

  Future<void> get _action async {
    setState(() => loading = true);
    String path = const Uuid().v4();
    List<String> links = [];
    for (var item in productImages) {
      var link =
          await FbStorageController().uploadFile(item, path: 'product1/$path ');

      if (link != null) {
        links.add(link);
      }
    }

    await ProductFbController().create(ProductModel(
        id: path,
        name: nameEditingController.text,
        price: num.parse(priceEditingController.text),
        description: descriptionEditingController.text,
        images: links));
    if (context.mounted) {
      Navigator.pop(context);
    }
    setState(() => loading = false);
  }

  bool get checdData {
    if (nameEditingController.text.isEmpty &&
        priceEditingController.text.isEmpty) {
      return false;
    }
    return true;
  }
}
