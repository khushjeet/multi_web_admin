import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:multi_web_admin/views/pages/side_base_page/categories_page.dart';
import 'package:multi_web_admin/views/pages/side_base_page/dashboard_page.dart';
import 'package:multi_web_admin/views/pages/side_base_page/order_page.dart';
import 'package:multi_web_admin/views/pages/side_base_page/product_page.dart';
import 'package:multi_web_admin/views/pages/side_base_page/upload_banner_page.dart';
import 'package:multi_web_admin/views/pages/side_base_page/vendar_page.dart';
import 'package:multi_web_admin/views/pages/side_base_page/withdrawal_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget _selectedItem = const DashBoardPage();

  screenSlector(item) {
    if (item.route == DashBoardPage.routeName) {
      setState(() {
        _selectedItem = const DashBoardPage();
      });
      return;
    } else if (item.route == VendarPage.routeName) {
      setState(() {
        _selectedItem = const VendarPage();
      });
      return;
    } else if (item.route == WithdrawalPage.routeName) {
      setState(() {
        _selectedItem = const WithdrawalPage();
      });
      return;
    } else if (item.route == UploadBanner.routeName) {
      setState(() {
        _selectedItem = const UploadBanner();
      });
      return;
    } else if (item.route == OrderPage.routeName) {
      setState(() {
        _selectedItem = const OrderPage();
      });
      return;
    } else if (item.route == CategoriesPage.routeName) {
      setState(() {
        _selectedItem = const CategoriesPage();
      });
      return;
    } else if (item.route == ProductPage.routeName) {
      setState(() {
        _selectedItem = const ProductPage();
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: Colors.yellow.shade900,
        appBar: AppBar(
          title: const Text("Management"),
        ),
        sideBar: SideBar(
          items: const [
            AdminMenuItem(
                title: "Multi Store Admin", icon: Icons.category, route: '/'),
            AdminMenuItem(
                title: "DashBoard",
                icon: Icons.dashboard,
                route: '/DashboardPage'),
            AdminMenuItem(
                title: "Vendors",
                icon: Icons.people_sharp,
                route: '/VendarPage'),
            AdminMenuItem(
                title: "Withdrawal",
                icon: Icons.currency_rupee,
                route: '/WithdrawalPage'),
            AdminMenuItem(
                title: "Orders",
                icon: Icons.shopping_cart_rounded,
                route: '/OrderPage'),
            AdminMenuItem(
                title: "Categories",
                icon: Icons.category,
                route: '/CategoriesPage'),
            AdminMenuItem(
                title: "Upload Banner",
                icon: Icons.hdr_plus_sharp,
                route: '/UploadBanner'),
            AdminMenuItem(
                title: "Products",
                icon: Icons.shop_rounded,
                route: '/ProductPage'),
          ],
          selectedRoute: '',
          onSelected: (item) {
            screenSlector(item);
          },
          header: Container(
            height: 50,
            width: double.infinity,
            color: const Color(0xff444444),
            child: const Center(
              child: Text(
                'Shop',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          footer: Container(
            height: 50,
            width: double.infinity,
            color: const Color(0xff444444),
            child: const Center(
              child: Text(
                'Footer',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: _selectedItem);
  }
}
