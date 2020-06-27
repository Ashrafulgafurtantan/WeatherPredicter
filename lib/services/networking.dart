import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{

  String url;
  NetworkHelper(this.url);

  Future getData() async{
    print('hell yeah');
    http.Response response= await http.get(url);
    if(response.statusCode==200) {
      String  data=response.body;
      print('data $data');

      var decode=jsonDecode(data);
      return decode;
    }
    else{
      print(response.body);
    }


  }

}