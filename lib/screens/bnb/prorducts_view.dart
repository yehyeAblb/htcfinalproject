import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yehyefirebasee/Helpers/navigator_helper.dart';
import 'package:yehyefirebasee/models/fb/product_model.dart';
import 'package:yehyefirebasee/screens/add_products_screen.dart';
import 'package:yehyefirebasee/widget/my_shimmer.dart';

import '../../firebasa/product_fb_controller.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> with NavigatorHelper {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('product'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
              onPressed: () => jump(context, to: const AddProductScreen()),
              icon: const Icon(Icons.add))
        ],
      ),
      body: StreamBuilder(
        stream: ProductFbController().read(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              itemBuilder: (context, index) {
                return const MyShimmer(height: 100);
              },
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemCount: 10,
            );
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<ProductModel> products =
                snapshot.data!.docs.map((e) => e.data()).toList();
            return ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => jump(context, to: const AddProductScreen()),
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 100.h,
                              width: 100.h,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: products[index].images!.length,
                                itemBuilder: (context, w) {
                                  return CachedNetworkImage(
                                    imageUrl: products[index].images![w],
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    products[index].name ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  SizedBox(height: 20.h),
                                  Text(
                                      '\$ ${products[index].price.toString()}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      PositionedDirectional(
                        end: 0,
                        child: IconButton(
                          onPressed: () async {
                            await ProductFbController().delete(products[index]);

                            for (var item in products[index].images!) {
                              await ProductFbController().delete(item.path);
                            }
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemCount: products.length,
            );
          } else {
            return const Center(child: Text('NO DATA'));
          }
        },
      ),
    );
  }
}
