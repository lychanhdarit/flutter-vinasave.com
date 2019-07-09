import 'package:app_vinasave/src/models/product.dart';
import 'package:app_vinasave/src/pages/product_detail_page.dart';
import 'package:app_vinasave/src/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductList extends StatelessWidget {
  final List<Product> products;

  const ProductList({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          behavior: null,
          child: Container(
            padding: EdgeInsets.all(10),
            color: index % 2 == 0 ? Colors.white : Colors.cyan[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  child: Image.network(
                    products[index].picture,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(products[index].name,style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Giá:" + products[index].price.toString()),
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text(
                              "Giá sản phẩm mới: " +
                                  products[index].price_old.toString() +
                                  " đ",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
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
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                          productId: products[index].id,
                        )));
          },
        );
      },
      itemCount: products.length,
    );
  }
}

class ProductPage extends StatefulWidget {
  @override
  ProductState createState() => ProductState();
}

class ProductState extends State<ProductPage> {
  WidgetCustom widgetCustom = new WidgetCustom();
  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: fetchProducts(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return snapshot.hasData
                ? ProductList(products: snapshot.data)
                : Center(
                    child: Text("Đang tải dữ liệu..."),
                  );
          },
        ),
      ),
      drawer: widgetCustom.buildDrawer(context),
    );
  }
}
