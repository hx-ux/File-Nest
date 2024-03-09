import 'package:file_nest/src/views/controllers/HOME_Controller.dart';
import 'package:file_nest/src/views/controllers/LOG_Controller.dart';
import 'package:get/get.dart';


// TODO not used 
class HomeBindings extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<HOME_Controller>(
      () => HOME_Controller(),
    );
  }
}


class ControllBindings extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<LOG_Controller>(
      () => LOG_Controller(),
    );
  }
}





