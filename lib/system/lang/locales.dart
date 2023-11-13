import 'package:get/get.dart';
import 'package:top_stock_manager/system/lang/en.dart';

import 'fr.dart';

class Locales extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'fr_FR': fr,
      };
}
