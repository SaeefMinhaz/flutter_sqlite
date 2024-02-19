import 'package:flutter/material.dart';
import 'package:tr_store/models/product_model.dart';

class ScreenProductDetails extends StatefulWidget {
  final ProductItemModel productItem;

  const ScreenProductDetails({Key? key, required this.productItem}) : super(key: key);

  @override
  State<ScreenProductDetails> createState() => _ScreenProductDetailsState();
}

class _ScreenProductDetailsState extends State<ScreenProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Item details"),
        ),
        body: _productItemView(widget.productItem));
  }

  /// product item
  Widget _productItemView(ProductItemModel itemModel) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  _itemTitleView(itemModel.title!),
                  _itemContentView(itemModel.content!),
                ],
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
        maxLines: 5,
        textAlign: TextAlign.start,
        style: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600));
  }

  /// item description view
  Widget _itemContentView(String content) {
    return Text(content,
        maxLines: 15,
        textAlign: TextAlign.justify,
        style: const TextStyle(color: Colors.black87, fontSize: 12));
  }



}

