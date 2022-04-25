import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        // ignore: avoid_print
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error Catch $e");
    }
  }

  postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        // ignore: avoid_print
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error Catch $e");
    }
  }

  postRequestWithFile(String url, Map data, File file) async {
    var requset = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile(
      "file",
      stream,
      length,
      filename: basename(file.path),
    );
    requset.files.add(multipartFile);
    data.forEach((key, value) {
      requset.fields[key] = value;
    });
    var myrequest = await requset.send();

    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error ${myrequest.statusCode}");
    }
  }
}
