
import 'package:res_pay_merchant/features/dashboard/provider/model/bottom_navigator_model.dart';
class BottomNavigatorRepo {



  final List<BottomNavigatorModel> _items = <BottomNavigatorModel>[];

  BottomNavigatorRepo() {
    _items.add(
      BottomNavigatorModel(
        title: 'home',
        image:'home',
      ),
    );
    _items.add(
      BottomNavigatorModel(
        title: 'shop',
        image:'shopping-bag',
      ),
    );
    _items.add(
      BottomNavigatorModel(
        title: 'celebrity',
        image:'user',
      ),
    );
    _items.add(
      BottomNavigatorModel(
        title: 'more',
        image:'menu-dots',
      ),
    );
  }

  List<BottomNavigatorModel> fetchItems() {
    return _items;}
}
