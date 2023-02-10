import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:testing/model/Comment_model.dart';

import '../constants/contants.dart';
import '../model/post_model.dart';
class PostController extends GetxController{
  Rx<List<PostModel>> post = Rx<List<PostModel>>([]);
  Rx<List<CommentModel>> comment = Rx<List<CommentModel>>([]);

 // final post = [].obs;
  final isLoading = false.obs;
  final box = GetStorage();
 // final token = box.read('token');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllPosts();
  }

  Future getAllPosts() async {

    try {
      post.value.clear();
      isLoading.value = true;
      var response =  await http.get(
        Uri.parse(url+"/feeds"),
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer ${ box.read('token')}',
        });

      if(response.statusCode ==200){
        isLoading.value = false;
        for (var item in json.decode(response.body)['feed']){
          //print(json.decode(response.body));
          post.value.add(PostModel.fromJson(item));
        }

        //print(json.decode(response.body));

      }else{
        isLoading.value = false;
        //print(json.decode(response.body));

      }

    }catch(e){
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createPost({ required String content}) async{

    try{
      var data = {'content': content};

      var response = await http.post(
        Uri.parse('$url/feed/store'),
          body: data,
          headers: {
            'Accept' : 'application/json',
            'Authorization' : 'Bearer ${ box.read('token')}',
          }
      );
   //  print(data);
      if(response.statusCode == 201){
        isLoading.value = false;
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }else{
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

    }catch(e){
      print(e.toString());
    }
  }

  Future getComment(id) async{

    try{
      comment.value.clear();
      isLoading.value = true;

      var response = await http.get(
        Uri.parse('$url/feed/comments/$id'),
          headers: {
            'Accept' : 'application/json',
            'Authorization' : 'Bearer ${ box.read('token')}',
          }
      );

      if(response.statusCode == 200){
        isLoading.value = false;

        final content  = json.decode(response.body)['comments'];
        for(var item in content){
          comment.value.add(CommentModel.fromJson(item));
        }

      }else{
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

    }catch(e){
      print(e.toString());
    }
  }

  Future createComment(id,body) async{

    try{
      isLoading.value = true;

      var data = {
        'body': body
      };

      print(body);
      print(id);

      var response =  await http.post(
        Uri.parse('${url}/feed/comment/$id'),
          headers: {
            'Accept' : 'application/json',
            'Authorization' : 'Bearer ${ box.read('token')}',
          },
        body: data,
      );

      if(response.statusCode == 200){
        isLoading.value = false;
        print(json.decode(response.body));

      }else{
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

    }catch(e){
      print(e.toString());
    }
  }

  Future likeAndDislike(id) async{
    try{


      isLoading.value = true;

      var response =  await http.post(
        Uri.parse('${url}/feed/like/$id'),
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer ${ box.read('token')}',
        },

      );
      print(response.body);
      if(response.statusCode == 201){
        isLoading.value = false;
        print(json.decode(response.body));

      }else{
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

    }catch(e){
      print(e.toString());
    }
  }
}