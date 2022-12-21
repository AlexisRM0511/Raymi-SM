import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as https;
import '/rest_services/response_data.dart';
import '/rest_services/sues/sue_model.dart';
import '/rest_services/sues/sue_repository.dart';

class SueService implements SueRepository {
  final String apiUrl = "https://limachay.herokuapp.com/sue";

  @override
  Future<List<SueModel>?> getSues() async {
    Uri url = Uri.parse('$apiUrl/all');
    ResponseData responseData =
        ResponseData.fromJson(json.decode((await https.get(url)).body));
    if (responseData.status == 200) {
      List<SueModel> sues = (responseData.data as List)
          .map((sue) => SueModel.fromJson(sue))
          .toList();
      return sues;
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<SueModel?> getSueById(String id) async {
    Uri url = Uri.parse('$apiUrl/$id');
    ResponseData responseData =
        ResponseData.fromJson(json.decode((await https.get(url)).body));
    if (responseData.status == 200) {
      return SueModel.fromJson(responseData.data);
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<SueModel?> createSue(SueModel sue) async {
    Uri url = Uri.parse('$apiUrl/create');
    ResponseData responseData = ResponseData.fromJson(
        json.decode((await https.post(url, body: sue.toJson())).body));
    if (responseData.status == 200) {
      return SueModel.fromJson(responseData.data);
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<String?> updateSue(SueModel sue) async {
    Uri url = Uri.parse('$apiUrl/update/${sue.id}');
    ResponseData responseData = ResponseData.fromJson(
        json.decode((await https.put(url, body: sue.toJson())).body));
    if (responseData.status == 200) {
      return "Datos actualizados correctamente";
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<String?> deleteSue(String id) async {
    Uri url = Uri.parse('$apiUrl/delete/$id');
    ResponseData responseData =
        ResponseData.fromJson(json.decode((await https.delete(url)).body));
    if (responseData.status == 200) {
      return "Usuario eliminado correctamente";
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<List<SueModel>?> getSuesByTitle(String title) async {
    Uri url = Uri.parse('$apiUrl/title/$title');
    ResponseData responseData =
    ResponseData.fromJson(json.decode((await https.get(url)).body));
    if (responseData.status == 200) {
      List<SueModel> sues = (responseData.data as List)
          .map((sue) => SueModel.fromJson(sue))
          .toList();
      return sues;
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<List<SueModel>?> getSuesByUser(String user) async {
    Uri url = Uri.parse('$apiUrl/user/$user');
    ResponseData responseData =
        ResponseData.fromJson(json.decode((await https.get(url)).body));
    if (responseData.status == 200) {
      List<SueModel> sues = (responseData.data as List)
          .map((sue) => SueModel.fromJson(sue))
          .toList();
      return sues;
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }
}
