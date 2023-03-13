import 'package:flutter/services.dart';

class MoreLocalApi{

  Future<String> getAccountItems()  async{
    final String response = await rootBundle.loadString("assets/jsons/more/account_list.json");
    return response;
  }

  Future<String> getHelpItems() async{
    final String response = await rootBundle.loadString("assets/jsons/more/help_list.json");
    return response;
  }

  Future<String> getUpperListItems()  async{
    final String response = await rootBundle.loadString("assets/jsons/more/upper_list.json");
    return response;
  }

  Future<String> getSettingsItems() async{
    final String response = await rootBundle.loadString("assets/jsons/more/settings.json");
    return response;
  }
}
