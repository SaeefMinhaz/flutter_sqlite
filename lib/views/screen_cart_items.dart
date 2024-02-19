import 'package:flutter/material.dart';
import 'package:tr_store/db/sql_helper.dart';

class ScreenCartItems extends StatefulWidget {
  const ScreenCartItems({Key? key}) : super(key: key);

  @override
  State<ScreenCartItems> createState() => _ScreenCartItemsState();
}

class _ScreenCartItemsState extends State<ScreenCartItems> {

  List<Map<String, dynamic>> _cartItemList = [];

  void _cartListFetch() async{
    final data = await SQLHelper.getItems();
    setState(() {
      _cartItemList = data;
    });
  }

  @override
  void initState(){
    super.initState();
    _cartListFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Cart page"),
      ),
      body: ListView.builder(
        itemCount: _cartItemList.length,
        itemBuilder: (context, index) => Card(
          elevation: 2,
          margin: const EdgeInsets.all(8),
          child: ListTile(
            title: _itemTitleView(_cartItemList[index]['title']),
            subtitle: _itemContentView(_cartItemList[index]['description']),
            trailing: SizedBox(
              width: 48,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete,),
                    onPressed: () async{
                      await _deleteItem(_cartItemList[index]['id']);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget _itemTitleView(String content){
    return Text(
        content,
        maxLines: 1,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600)
    );
  }

  Widget _itemContentView(String content){
    return Text(
        content,
        maxLines: 2,
        textAlign: TextAlign.justify,
        style: const TextStyle(
            color: Colors.black87,
            fontSize: 12));
  }

  Future<void> _deleteItem(int id) async{
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Successfully deleted")
        )
    );
    _cartListFetch();
  }



}
