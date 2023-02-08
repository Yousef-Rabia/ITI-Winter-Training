import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iti/models/post_model.dart';

import '../../models/user_model.dart';
import '../../services/user_service.dart';

class PostDetails extends StatefulWidget {
  PostModel post;
   PostDetails({super.key,required this.post}) ;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  late UserModel user ;
  bool isLoading = true;

  getUser(id) async {
    user = (await UserService().getUserWithId(id))!;
    isLoading = false;
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    getUser(widget.post.userId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:isLoading? const Center(child: CircularProgressIndicator(),):
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                    Text("@"+user.username,style: Theme.of(context).textTheme.bodySmall,),
                  ],
                )

              ],
            ),
            SizedBox(height: 15,),
            Text(widget.post.title??" ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.red)),
            SizedBox(height: 15,),
            Text(widget.post.body??" ",style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
