import 'package:flutter/material.dart';
import 'package:instagram_flutter/resources/firestore_methods.dart';
import 'package:instagram_flutter/screens/comments_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key,required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating=false;

  @override
  Widget build(BuildContext context) {
    final User user=Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobileBackgroundColor,
      padding:const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding:const EdgeInsets.symmetric(
              vertical: 4,horizontal: 16
              ).copyWith(right:0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(widget.snap['profImage'])
                  ),
                  Expanded(
                    child:Padding(
                      padding:const EdgeInsets.only(
                        left:8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.snap['username'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                              ),)
                          ],
                        ),
                        ),),
                        IconButton(
                          onPressed: (){
                            showDialog(
                            context: context, 
                            builder:(context)=>Dialog(
                              child: ListView(
                                padding:const EdgeInsets.symmetric(vertical: 16),
                                shrinkWrap: true,
                                children: [
                                  'Delete',
                                ].map((e) => InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding:const EdgeInsets.symmetric(
                                      vertical: 12,horizontal: 16),
                                      child: Text(e),
                                      ),
                                ),
                                ).toList(),
                            ),));
                          },
                           icon:const Icon(Icons.more_vert))
                ],
              ),
               ),
               GestureDetector(
                
                onDoubleTap: () async{
                 await FirestoreMethods().likePost(
                  widget.snap['postId'],
                  user.uid,
                  widget.snap['likes']
                 );
                  setState(() {
                    isLikeAnimating=true;
                  });
                },
                 child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width*0.65,
                    child:Image.network(widget.snap['postUrl']) ,),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isLikeAnimating ? 1 :0,
                      child: LikeAnimation(
                        child: Icon(
                          Icons.favorite,
                          color:Colors.white,
                          size:100,
                          ), 
                          isAnimating: isLikeAnimating,
                          duration:const Duration(milliseconds: 400),
                          onEnd: () {
                            setState(() {
                              isLikeAnimating=false;
                            });
                          },
                          ),
                    )
                  ],
                 
                 ),
               ),
                Row(
                  children: [
                    LikeAnimation(
                      isAnimating: widget.snap['likes'].contains(user.uid),
                      child: IconButton(
                        onPressed: () async{
                           await FirestoreMethods().likePost(
                           widget.snap['postId'],
                           user.uid,
                           widget.snap['likes']
                        );
                        },
                         icon:widget.snap['likes'].contains(user.uid) ?
                          const Icon(Icons.favorite,color: Colors.red,) : 
                         const Icon(Icons.favorite_border)
                         )),
                        IconButton(
                      onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CommentsScreen(snap:widget.snap))),
                       icon:const Icon(Icons.comment_outlined
                       )),
                         IconButton(
                      onPressed: (){},
                       icon:const Icon(Icons.send
                       )),
                       Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            onPressed: (){},
                             icon:const Icon(Icons.bookmark_border)),))
                  ],
                ),
                Container(
                  padding:const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
                        child: Text('${widget.snap['likes'].length} likes',
                        style: Theme.of(context).textTheme.bodyText2,),
                      ),
                      Container(
                        width: double.infinity,
                        padding:const EdgeInsets.only(top: 8),
                        child: RichText(text: TextSpan(
                          style: const TextStyle(color: primaryColor),
                          children: [
                            TextSpan(
                              text:widget.snap['username'],
                              style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                              text: ' ${widget.snap['description']}',
                              ),
                          ]
                        )),
                      ),
                      InkWell(
                        onTap: () {
                          
                        },
                        child: Container(
                          padding:const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                          "View all 200 comments",
                          style: TextStyle(color: Colors.grey[400],fontSize: 16),),),
                      ),
                       Container(
                          padding:const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                          DateFormat.yMMMd().
                          format(widget.snap['datePublished'].toDate()),
                          style: TextStyle(color: Colors.grey[400],fontSize: 16),),),
                    ]),
                )
        ],
      ),
    );
  }
}