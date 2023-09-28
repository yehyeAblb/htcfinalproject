
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yehyefirebasee/models/fb/product_model.dart';

class ProductFbController{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String table= 'product';
  ///Create
  Future<bool> create(ProductModel product) async{
   await _firestore.collection(table).doc(product.id).set(product.toJson())
       .catchError((onError) => false
   );


   return true;
  }
  ///Read
  Stream<QuerySnapshot<ProductModel>> read() async*{
    yield* _firestore.collection(table)
        .withConverter<ProductModel>(
        fromFirestore: (snapshot, options) {
          ///From Json => Model
          return ProductModel.fromJson(snapshot.data()!);
        },
        toFirestore: (value, options) {
          /// To Json => Map
          return value.toJson();
        },)

        .snapshots();
  }
  ///Update
  Future<bool> update(ProductModel product) async{
    await _firestore.collection(table)
        .doc(product.id)
        .update(product.toJson())
        .catchError((onError)=>false);
    return true;
  }
  ///Delete
  Future<bool> delete(ProductModel product) async{
    await _firestore.collection(table)
        .doc(product.id)
        .delete()
        .catchError((onError)=>false);
    return true;
  }

}