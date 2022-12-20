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
  
}