import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/db/sql_helper.dart';
import 'package:tr_store/models/product_model.dart';
import 'package:tr_store/services/api_services.dart';

final productListDataProvider = FutureProvider<List<ProductItemModel>>((ref) async {
  return ref.watch(productListProvider).getProductList();
});

// final cartItemListProvider= Provider<>((ref)=> SQLHelper);
//
// final cartItemListDataProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
//   return ref.watch(cartItemListProvider).getItems();
// });