import 'package:flutter/material.dart';
 class CommentCard extends StatefulWidget {
  const CommentCard({super.key});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 18),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"),
            radius: 18,
          ),
          Expanded(
            child: Padding(padding: const EdgeInsets.only(left:16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(text: TextSpan(
                  children: [
                    TextSpan(
                      text: "username",
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                     TextSpan(
                      text: "some description to insert",
                    ),
                  ]
                )),
                Padding(
                  padding: const EdgeInsets.only(top:4),
                  child: Text(
                    '23/12/22',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12
                    ),),
                )
              ],
            ),),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child:const Icon(Icons.favorite,size: 16,)
          )
        ],
      ),
    );
  }
}