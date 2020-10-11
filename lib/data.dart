import 'package:flutter/foundation.dart';

class Profile with ChangeNotifier {
  final String name;
  final String classname;
  final String email;

  Profile({
    @required this.classname,
    @required this.name,
    @required this.email,
    // @required this.imageUrl,
    //  this.isFavorite = false,
  });
}
