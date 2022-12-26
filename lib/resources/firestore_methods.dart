import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_flutter/models/post.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';


class FirestoreMethods{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Future<String> uploadPost(
    String description,
    String username,
    String profImage,
    Uint8List file,
    String uid,
  )async{
    String res="Some error occured";
   try{
    
    String photoUrl=await StorageMethods().uploadImageToStorage('posts', file, true);
    String postId= const Uuid().v1();
    Post post=Post(
      description:description,
      uid: uid,
      username: username,
      datePublished: DateTime.now(),
      postId: postId,
      postUrl: photoUrl,
      profImage: profImage,
      likes: [],
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res='success';
   }
   catch(err){
    res=err.toString();
   }
   return res;
  }
  

  Future<void> likePost(String postId, String uid, List likes) async {
    //String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
       await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
       await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      //res = 'success';
    } catch (err) {
       print(err.toString());
    }
  
  }

 Future<void> postComment(String postId,String text,String uid,String name,String profilePic) async{
   try{
   if(text.isNotEmpty){
      String commentId=const Uuid().v1();
     await _firestore.collection('posts').doc(postId).collection('comments').doc('commentId').set({
        'profilePic':profilePic,
        'name':name,
        'uid':uid,
        'text':text,
        'commentId':commentId,
        'datePublished':DateTime.now(),

      });
    }else{
      print('Text is empty');
    }
   }
   catch(e){
    print(e.toString());
   }
 }
}