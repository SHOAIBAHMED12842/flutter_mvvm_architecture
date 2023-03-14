import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:provider_mvvm_architecture/data/app_excaptions.dart';
import 'package:provider_mvvm_architecture/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices{
  @override
  Future getGetApiResponse(String url) async{
    dynamic responsejson;
    try{
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
       responsejson = returnResponse(response);
    }on SocketException{
      throw FetchDataException('No Internet Exception');
    }
    return responsejson;
  }

  @override
  Future getPostApiResponse(String url,dynamic data) async {
     dynamic responseJson ;
    try {

      Response response = await post(
        Uri.parse(url),
        body: data
      ).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    }on SocketException {

      throw FetchDataException('No Internet Connection');
    }

    return responseJson ;
  }
   dynamic returnResponse (http.Response response){

    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException('Error accured while communicating with server'+
            'with status code' +response.statusCode.toString());

    }
  }

}