// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shop_x/presentation/widgets/category_widget.dart';

List<Widget> bannerImages = [
  AspectRatio(
    aspectRatio: 1.6 / 1,
    child: Container(
        decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      //color: Colors.green[100],
      image: const DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/banner1.jpg'
              //  'https://img.freepik.com/free-psd/horizontal-banner-template-black-friday-clearance_23-2148745446.jpg?w=740&t=st=1668576393~exp=1668576993~hmac=349224a80993b8bd8a6cab6403f204fb9fd92b26e43e5ff5cc6b701d03ef65cc'
              )),
    )),
  ),
  AspectRatio(
    aspectRatio: 1.6 / 1,
    child: Container(
        decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      //color: Colors.green[100],
      image: const DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/banner2.jpg'
              //'https://as2.ftcdn.net/v2/jpg/03/39/60/67/1000_F_339606710_pFQOII8MwyEVqXK5vb4XsIaJr13cipWO.jpg'
              )),
    )),
  ),
  AspectRatio(
    aspectRatio: 1.6 / 1,
    child: Container(
        decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      //color: Colors.green[100],
      image: const DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/banner3.jpg'
              // 'https://img.freepik.com/free-psd/horizontal-banner-template-big-sale-with-woman-shopping-bags_23-2148786755.jpg?w=740&t=st=1668576526~exp=1668577126~hmac=bedb5a056cfa6eaddba72fcc0b874195c839f25a5df1c6842d274a85ddbe9983',
              )),
    )),
  ),
];

// List<Widget> categoryIcons = const [
//   CategoryIcon(
//     icon: FontAwesomeIcons.mobile,
//     text: 'Mobile',
//   ),
//   CategoryIcon(icon: FontAwesomeIcons.shirt, text: 'Clothes'),
//   CategoryIcon(icon: FontAwesomeIcons.laptop, text: 'Laptop'),
//   CategoryIcon(icon: FontAwesomeIcons.book, text: 'Book'),
//   CategoryIcon(icon: FontAwesomeIcons.camera, text: 'Camera'),
//   CategoryIcon(icon: FontAwesomeIcons.gift, text: 'Gifts'),
// ];

List<CategoryIcon> categoryIcons = const [
  // CategoryIcon(icon: 'assets/cleaning.png', text: 'Cleaning'),
  // CategoryIcon(icon: 'assets/detergent.png', text: 'Detergent'),
  // CategoryIcon(icon: 'assets/soap.png', text: 'Soap'),
  // CategoryIcon(icon: 'assets/plant1.png', text: 'Plants'),
  // CategoryIcon(icon: 'assets/hygiene.png', text: 'Hygiene Products')
  // CategoryIcon(icon: 'assets/clothes.png', text: 'Clothing'),
  // CategoryIcon(icon: 'assets/tech2.png', text: 'Smart Devices'),
  // CategoryIcon(icon: 'assets/briefcase.png', text: 'Bag'),
  // CategoryIcon(icon: 'assets/shoes.png', text: 'Shoes'),
  // CategoryIcon(icon: 'assets/electro.png', text: 'Electronics'),
];

const String img1 =
    //'https://img.udaan.com/f_auto,q_auto:good,w_1200/u/products/0e6e6kvlbeyngofgsxfv.jpg/Dettol-Skincare-Rose-Soap---Pack-of-4-';
    'assets/gridimage1.jpeg';
const img2 =
    // 'https://img.udaan.com/f_auto,q_auto:good,w_1200/u/products/43srbohbcj3u9zqwh3k2.jpg/Dettol-Original-Soap---Pack-of-1-MRP---50-00-Rs-';
    'assets/gridimage2.jpeg';
const img3 =
    //'https://img.udaan.com/f_auto,q_auto:good,w_1200/u/products/bg0kkaktvbiygdjwqcfz.857Z/Vim-With-Power-Of-Lemons-Lemon-Bar-300-gm-Pack-of-';
    'assets/gridimage3.jpeg';
const img4 =
    //'https://img.udaan.com/f_auto,q_auto:good,w_1200/u/products/kjtb0a6ztv1gapz0ww9g.007Z/Surf-Excel-Quick-Wash-Detergent-Powder---Pack-of-1';
    'assets/gridimage4.jpeg';
