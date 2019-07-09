import 'package:app_vinasave/src/models/product.dart';
import 'package:app_vinasave/src/pages/product_page.dart';
import 'package:app_vinasave/src/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Column(children: <Widget>[
      Container(
        width: double.infinity,
        child: Image.network(
          product.picture,
          fit: BoxFit.cover,
        ),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text("Giá: " + product.price.toString() + " đ"),
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    "Giá sản phẩm mới: " + product.price_old.toString() + " đ",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Divider(
                    color: Colors.grey,
                    indent: 15,
                  ),
                  width: 120,
                )
              ],
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: null,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.orange,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                    Text(
                      'Thêm vào giỏ hàng',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: null,
              child: Container(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.red,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_right,
                      color: Colors.white,
                    ),
                    Text('Mua ngay', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    ]));
  }
}

class ProductDetailPage extends StatefulWidget {
  final int productId;
  ProductDetailPage({this.productId}) : super();
  ProductDetailState createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetailPage> {
  WidgetCustom widgetCustom = new WidgetCustom();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/logo.png',
          fit: BoxFit.cover,
          height: 40,
        ),
        backgroundColor: Color.fromRGBO(255, 238, 0, 1),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductPage()));
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: fetchProduct(http.Client(), widget.productId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ProductDetail(product: snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
      drawer: widgetCustom.buildDrawer(context),
    );
  }
}
