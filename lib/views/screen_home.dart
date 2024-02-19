import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/dataprovider/data_provider.dart';
import 'package:tr_store/db/sql_helper.dart';
import 'package:tr_store/models/product_model.dart';
import 'package:tr_store/utils/tr_constants.dart';
import 'package:tr_store/views/screen_cart_items.dart';
import 'package:tr_store/views/screen_product_details.dart';

class ScreenHome extends ConsumerWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final productListData = ref.watch(productListDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: _appBarView(context),
      ),
      body: productListData.when(
          data: (productListData) {
            List<ProductItemModel> productList =
                productListData.map((e) => e).toList();
            return _productListView(context, productList);
          },
          error: (err, s) => Text(err.toString()),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }

  /// app title with cart icon navigation
  Widget _appBarView(BuildContext context) {
    return Row(
      children: [
        const Text(TrConstants.homeTitle),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.shopping_cart,
          ),
          onPressed: () {
            _navigateToCart(context);
          },
        ),
      ],
    );
  }

  /// product list view
  Widget _productListView(
      BuildContext context, List<ProductItemModel> productList) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        _navigateToProductDetails(context, productList[index]);
                      },
                      child: _productItemView(context, productList[index]),
                    );
                  }))
        ],
      ),
    );
  }

  /// product item
  Widget _productItemView(BuildContext context, ProductItemModel itemModel) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(itemModel.thumbnail!),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  _itemTitleView(itemModel.title!),
                  _itemContentView(itemModel.content!),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.blue,
                ),
                onPressed: () {
                  _getItemCheck(context, itemModel);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// item title view
  Widget _itemTitleView(String content) {
    return Text(content,
        maxLines: 1,
        style: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600));
  }

  /// item description view
  Widget _itemContentView(String content) {
    return Text(content,
        maxLines: 2,
        textAlign: TextAlign.justify,
        style: const TextStyle(color: Colors.black87, fontSize: 12));
  }

  /// item navigation to product details
  void _navigateToProductDetails(BuildContext context, ProductItemModel item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ScreenProductDetails(
          productItem: item,
        ),
      ),
    );
  }


  /// cart view navigation
  void _navigateToCart(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ScreenCartItems(),
      ),
    );
  }

  /// add to cart db insert
  Future<void> _addItemToCart(
      BuildContext context, ProductItemModel item) async {
    await SQLHelper.createItem(item.title!, item.content, item.userId!);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(TrConstants.addedToCart)));
  }

  /// item exist check
  Future<void> _getItemCheck(
      BuildContext context, ProductItemModel itemModel) async {
    List<Map<String, dynamic>> item = [];
    try {
      item = await SQLHelper.getItem(itemModel.userId!);
      if (item.length > 0) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text(TrConstants.alreadyAddedToCart)));
      } else {
        _addItemToCart(context, itemModel);
      }
    } catch (error) {
      _addItemToCart(context, itemModel);
    }
  }


}
