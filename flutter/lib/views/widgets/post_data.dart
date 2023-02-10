import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testing/model/post_model.dart';
import 'package:get/get.dart';

import '../../controllers/post_controller.dart';
import '../post_details.dart';


class PostData extends StatefulWidget {
  const PostData({
    Key? key, required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {



  final PostController _postController = Get.put(PostController());
   Color likedPost = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.post.user!.name!,
            style: GoogleFonts.poppins(),
          ),
          Text(widget.post.user!.email!,
            style: GoogleFonts.poppins(
                fontSize: 10
            ),
          ),
          SizedBox(height: 10,),
          Text(widget.post.content!),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                children: [
                  IconButton(onPressed: () async {
                    await  await _postController.likeAndDislike(widget.post.id);
                    _postController.getAllPosts();

                  }, icon: Icon(
                    widget.post.liked! ? Icons.thumb_down : Icons.thumb_up,
                    color: widget.post.liked! ? Colors.blue : Colors.black,
                  ),

                  ),
                  IconButton(onPressed: (){
                    Get.to(() => PostDetails(
                      post: widget.post,
                    ));

                  }, icon: Icon(Icons.message),),
                ],
          ),

                Row(
                  children: [
                    IconButton(onPressed: () async {
                      await  await _postController.likeAndDislike(widget.post.id);
                      _postController.getAllPosts();

                    }, icon: Icon(
                       Icons.edit,
                      color: Colors.black,
                    ),

                    ),
                    IconButton(onPressed: (){
                      Get.to(() => PostDetails(
                        post: widget.post,
                      ));

                    }, icon: Icon(Icons.delete),),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

}