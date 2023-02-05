import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Models/category.dart';
import 'package:flutter_application_1/Models/imagePrint.dart';
import 'package:flutter_application_1/Models/material.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:flutter_application_1/Models/user.dart';
import 'package:http/http.dart';

class ProductsVM with ChangeNotifier {
  List<Print> lst = [];

  add(
    int id,
    Category category,
    User user,
    String title,
    String description,
    double price,
    int default_size,
    int default_weight,
    MaterialPrint default_material,
    List<ImagePrint> imagePrintings,
    int nbr_of_printing_hours,
  ) {
    lst.add(Print(
        id: id,
        category: category,
        user: user,
        title: title,
        description: description,
        price: price,
        default_size: default_size,
        default_weight: default_weight,
        default_material: default_material,
        imagePrintings: imagePrintings,
        nbr_of_printing_hours: nbr_of_printing_hours));
    notifyListeners();
  }

  delete(int index) {
    lst.removeAt(index);
    notifyListeners();
  }
}
