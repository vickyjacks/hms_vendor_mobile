import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../utils/constants/api_constants.dart';

class ApiServices {
  final String baseUrl = APIConstants.baseUrl;
  final headers = {'Content-Type': 'application/json', 'Authorization': authToken};

  Future<dynamic> getData(String endpoint) async {
    final Uri uri = Uri.parse('$baseUrl$endpoint');
    log("get url --- $uri");
    log("headers --- $headers");
    try {
      final response = await http.get(uri, headers: headers);
      log("+++++++++21");
      print(response.statusCode);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> postData(String endpoint, Map<String, dynamic> data) async {
    final Uri uri = Uri.parse("$baseUrl$endpoint");
    print("url :: ${uri}");
    print("header :: ${headers}");
    print("data--11--$data");
    String postApiData = jsonEncode(data); // Use the provided data instead of the hardcoded newData
    try {
      final response = await http.post(uri, headers: headers, body: postApiData);
      print("Response :11: ${response.statusCode}");
      print("Response :11: ${response.body}");
      if (response.statusCode == 201) {
        print("Response :: ${response.body}");
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> putData(String endpoint, Map<String, dynamic> data) async {
    final Uri uri = Uri.parse('$baseUrl/$endpoint');

    try {
      final response = await http.put(uri, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to put data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> deleteData(String endpoint) async {
    final Uri uri = Uri.parse('$baseUrl/$endpoint');

    try {
      final response = await http.delete(uri, headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> uploadDocumentsAndPostApi({required String apiUrl, required var documentDetails, Map<String, String>? postData, bool isPostData = true}) async {
    final Uri uri = Uri.parse("$baseUrl$apiUrl");
    try {
      // Create a multipart request
      print("uri----$uri");
      print("postData----$postData");
      print("documentDetails----$documentDetails");
      print("Header----$authToken");
      var request = http.MultipartRequest('POST', uri);
      // request.headers['Authorization'] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2ZW5kb3JfaWQiOiI2NTgzMjQ1MTIyNGFmODE4NzVjZGMxNjciLCJlbWFpbCI6ImFua2l0a3k3NzhAZ21haWwuY29tIiwiaWF0IjoxNzA0NjM3MDQ4fQ.HdFc8_hs0rMCnZiZU5wO3xJf3C6nRf8N-J_ECgFFMuQ";
      request.headers['Authorization'] = authToken;
      for (int i = 0; i < documentDetails.length; i++) {
        var documentFile = await http.MultipartFile.fromPath(documentDetails[i]['uploadKey'], documentDetails[i]['documentPath']);
        request.files.add(documentFile);
      }

      // Attach the other POST data
      if (isPostData == true) {
        request.fields.addAll(postData!);
      }

      // Send the request
      var response = await request.send();
      final responseBody = await response.stream.bytesToString();
      dynamic jsonData = jsonDecode(responseBody);
      print("33333---${response.statusCode}");
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print("jsonData---${jsonData}");
        return jsonData;
      } else {
        return jsonData;
      }
    } catch (error) {
      print('Error123: $error');
    }
  }

  Future<void> uploadFileApi({required data,required String endPoint}) async {
    final Uri url = Uri.parse("$baseUrl$endPoint");
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url.toString()));
      log("url---$url");
      log("token---$authToken");
      var newHeader = {
        'Content-Type': 'application/json',
        'Authorization': authToken,
      };
      request.headers.addAll(newHeader);

      for (int i = 0; i < data.length; i++) {
        print("data----${data[i]['value']}");
        var documentFile = await http.MultipartFile.fromPath(data[i]['key'], data[i]['value']);
        request.files.add(documentFile);
      }
      final response = await request.send();
      print("Status Code :: ${response.statusCode}");
       final responseBody = await response.stream.bytesToString();
      dynamic jsonData = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        print("jsonData---$jsonData");
        return jsonData;
        print('File uploaded successfully');
      } else {
        return jsonData;
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  Future<void> uploadFileApis({required List<Map<String, dynamic>> data, required String endPoint}) async {
    final Uri url = Uri.parse("$baseUrl$endPoint");
    try {
      final request = http.MultipartRequest('POST', url);
      log("Request URL: $url"); // Log the complete URL for debugging
      log("Authorization Token: $authToken"); // Log authorization token

      var newHeader = {
        'Authorization': authToken,
      };
      request.headers.addAll(newHeader);

      for (int i = 0; i < data.length; i++) {
        print("data----${data[i]['value']}");
        var documentFile = await http.MultipartFile.fromPath(data[i]['key'], data[i]['value']);
        request.files.add(documentFile);
      }

      final response = await request.send();
      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        dynamic jsonData = jsonDecode(responseBody);
        print("Response Data: $jsonData"); // Log response data for debugging
        print('File uploaded successfully');
        return jsonData;
      } else {
        print('File upload failed with status code: ${response.statusCode}');
        throw Exception('File upload failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading file: $e');
      throw Exception('Error uploading file: $e');
    }
  }



}
