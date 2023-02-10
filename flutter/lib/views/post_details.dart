import 'package:flutter/material.dart';
import 'package:testing/controllers/post_controller.dart';
import 'package:testing/model/post_model.dart';
import 'package:testing/views/widgets/input_widget.dart';
import 'widgets/post_data.dart';
import 'package:get/get.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({Key? key, required this.post}) : super(key: key);

  final PostModel post;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {

  final TextEditingController _textEditingController = TextEditingController();
  final PostController _postController = Get.put(PostController());
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
     _postController.getComment(widget.post.id);
   });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.post.user!.name!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PostData(
              post: widget.post
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Obx((){
                  return _postController.isLoading.value ?
                const  Center(
                    child: CircularProgressIndicator(),
                  )    :
                    ListView.builder(
                      itemCount: _postController.comment.value.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text(
                            _postController.comment.value[index].user!.name!
                          ),
                          subtitle: Text(_postController.comment.value[index].body!),
                        );

                      });
                }
              ),
            ),


            InputWidget(hintText: "Write something ",
                controller: _textEditingController,
                obscureText: false
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
              ),
              onPressed: () async {
                //print(widget.post.id);
               // print(_textEditingController.text.trim());
                await _postController.createComment(widget.post.id, _textEditingController.text.trim(),);

                _textEditingController.clear();
                _postController.getComment(widget.post.id);
            }, child: const Text("comment"),),

          ],
        ),
      ),
    );
  }
}
