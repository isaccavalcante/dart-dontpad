import 'dart:convert'; // JSON encoder
import 'package:http/http.dart'; // client for API calls
import 'package:html/parser.dart'; // HTML parsers to generate a Document object
import 'package:html/dom.dart'; // DOM related classes for extracting data from elements

// Retrieves raw text from dontpad givel url path
Future<String> getRawText(String path) async {
  var client = Client();
  Response response = await client.get(
    'http://dontpad.com' + path
  );

  // HTML parser and query selector
  Document document = parse(response.body);
  Element element = document.querySelector('#text');
  String rawText = element.text;
  return rawText;
}

// Converts raw text into a json list, throws error is JSON is not a list
Future<List<dynamic>> getJsonList(String path) async {
  String rawText = await getRawText(path);
  List<dynamic> jsonList = jsonDecode(rawText);
  
  print(jsonList);
  return jsonList;
}

void main(){
  getJsonList("/dart-dontpad/JsonList");
}
