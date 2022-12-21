import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:intl/intl.dart';
class PostCard extends StatelessWidget {
  final snap;
  const PostCard({super.key,required this.snap});

  @override
  Widget build(BuildContext context) {
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
                    backgroundImage: NetworkImage(snap['profImage'])
                  ),
                  Expanded(
                    child:Padding(
                      padding:const EdgeInsets.only(
                        left:8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snap['username'],
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
               SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.width*0.65,
                child:Image.network(snap['postUrl']) ,),
                Row(
                  children: [
                    IconButton(
                      onPressed: (){},
                       icon:const Icon(Icons.favorite
                       )),
                         IconButton(
                      onPressed: (){},
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
                        child: Text('${snap['likes'].length} likes',
                        style: Theme.of(context).textTheme.bodyText2,),
                      ),
                      Container(
                        width: double.infinity,
                        padding:const EdgeInsets.only(top: 8),
                        child: RichText(text: TextSpan(
                          style: const TextStyle(color: primaryColor),
                          children: [
                            TextSpan(
                              text:snap['username'],
                              style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                              text: ' ${snap['description']}',
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
                          format(snap['datePublished'].toDate()),
                          style: TextStyle(color: Colors.grey[400],fontSize: 16),),),
                    ]),
                )
        ],
      ),
    );
  }
}