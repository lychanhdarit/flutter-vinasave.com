import 'package:app_vinasave/src/pages/product_page.dart';
import 'package:app_vinasave/src/pages/product_thanhly_page.dart';
import 'package:flutter/material.dart';

class WidgetCustom {
  Drawer buildDrawer(context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Container(
              width: double.infinity,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    child: Center( 
                      child: Image.asset(
                        'images/logo.png',
                        fit: BoxFit.cover,
                        height: 90,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage()));
                    },
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(color: Color.fromRGBO(255, 238, 0, 1),),
            
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Trang chủ"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text("Top sản phẩm mới"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.print),
            title: Text("Xả kho thanh lý"),
            onTap: () {
                 Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductThanhLyPage()));

            },
          ),
          Divider(
            color: Colors.grey,
            indent: 16,
          ),
          ListTile(
            title: Text("Liên hệ"),
            onTap: () {},
          ),
          ListTile(
            title: Text("Giới thiệu"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
