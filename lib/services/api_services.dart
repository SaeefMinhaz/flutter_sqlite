import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:tr_store/db/sql_helper.dart';
import 'package:tr_store/models/product_model.dart';
import 'package:tr_store/services/api_endpoints.dart';

class ApiServices{

  Future<List<ProductItemModel>> getProductList() async {
    Response response = await get(Uri.parse(ApiUrls().productListEndpoint));
    if (response.statusCode == 200){
      final List result = jsonDecode(response.body);
      return result.map(((e) => ProductItemModel.fromJson(e))).toList();
    }else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final productListProvider= Provider<ApiServices>((ref)=>ApiServices());

// final cartItemListProvider= Provider<SQLHelper>((ref)=>SQLHelper());