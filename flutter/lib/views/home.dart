import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testing/controllers/post_controller.dart';
import 'widgets/post_field.dart';
import 'widgets/post_data.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Offset _tapPosition = Offset.zero;
  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  final TextEditingController _textController = TextEditingController();
  final PostController _postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Forum App'),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
        await  _postController.getAllPosts();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostField( hintText : 'what do you want to ask?', controller: _textController),
               // const SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 10,
                    )
                  ),
                    onPressed: () async {
                    await _postController.createPost(content: _textController.text.trim());

                    _textController.clear();
                    _postController.getAllPosts();
                },
                    child: Obx((){
                        return
                          _postController.isLoading.value ?
                              CircularProgressIndicator() :
                          Text('Post');
                      }
                    ),

                ),

                const SizedBox(height: 30,),
                Text('Posts'),
                const SizedBox(height: 20,),
                Obx(() {
                  return _postController.isLoading.value ? const Center(
                    child: CircularProgressIndicator(),
                  ):
                     ListView.builder(
                       shrinkWrap: true,
                         physics: NeverScrollableScrollPhysics(),
                         itemCount: _postController.post.value.length,
                         itemBuilder: (context, index){
                         return PostData(
                           post: _postController.post.value[index],
                         );
                         }
                     );
                  }
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }


  _showContextMenu(BuildContext context)async  {

    final RenderObject? overLay = Overlay.of(context)?.context.findRenderObject();

    final result = await showMenu(
        context: context,

        position: RelativeRect.fromRect(
          Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 30, 30),
          Rect.fromLTWH(0, 0, overLay!.paintBounds.size.width, overLay.paintBounds.size.height),),

        // set a list of choices for the context menu
        items: [
          const PopupMenuItem(
            value: 'Edit',
            child: Text('Edit Post'),
          ),
          const PopupMenuItem(
            value: 'Delete',
            child: Text('Delete Post'),
          ),
          const PopupMenuItem(
            value: 'Cancel',
            child: Text('Cancel'),
          ),
        ]);

    // Implement the logic for each choice here
    switch (result) {
      case 'Edit':
        debugPrint('Add To Favorites');
        break;
      case 'Cancel':
        debugPrint('Write Comment');
        break;
      case '':
        debugPrint('Hide');
        break;
    }
  }
}

