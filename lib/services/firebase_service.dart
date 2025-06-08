import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fotpulse/models/user_model.dart';
import 'dart:io';



class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  User? get currentUser => _auth.currentUser;

  // Get user data
  Future<UserModel?> getUserData() async {
    try {
      if (currentUser != null) {
        print('Getting user data for UID: ${currentUser!.uid}');
        DocumentSnapshot doc = await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .get();
        
        if (doc.exists) {
          print('User document exists: ${doc.data()}');
          return UserModel.fromJson(doc.data() as Map<String, dynamic>);
        } else {
          print('User document does not exist');
          // Create a basic user document if it doesn't exist
          UserModel newUser = UserModel(
            uid: currentUser!.uid,
            name: currentUser!.displayName ?? 'User',
            email: currentUser!.email ?? '',
          );
          await updateUserData(newUser);
          return newUser;
        }
      } else {
        print('No current user found');
      }
      return null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  // Update user data
  Future<bool> updateUserData(UserModel user) async {
    try {
      if (currentUser != null) {
        print('Updating user data for UID: ${currentUser!.uid}');
        print('User data: ${user.toJson()}');
        
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .set(user.toJson(), SetOptions(merge: true));
        
        print('User data updated successfully');
        return true;
      } else {
        print('No current user found for update');
      }
      return false;
    } catch (e) {
      print('Error updating user data: $e');
      return false;
    }
  }

  // Upload profile image
  Future<String?> uploadProfileImage(File imageFile) async {
    try {
      if (currentUser != null) {
        String fileName = 'profile_${currentUser!.uid}_${DateTime.now().millisecondsSinceEpoch}';
        Reference ref = _storage.ref().child('profile_images/$fileName');
        UploadTask uploadTask = ref.putFile(imageFile);
        TaskSnapshot snapshot = await uploadTask;
        return await snapshot.ref.getDownloadURL();
      }
      return null;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  // Delete user account and data
  Future<bool> deleteUserAccount() async {
    try {
      if (currentUser != null) {
        String uid = currentUser!.uid;
        
        // Delete user data from Firestore
        await _firestore.collection('users').doc(uid).delete();
        print('User document deleted from Firestore');
        
        // Delete profile image from Storage if exists
        try {
          await _storage.ref().child('profile_images').child(uid).delete();
          print('Profile image deleted from Storage');
        } catch (e) {
          print('No profile image to delete or error: $e');
        }
        
        // Delete user account from Firebase Auth
        await currentUser!.delete();
        print('User account deleted from Auth');
        
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting user account: $e');
      return false;
    }
  }

  // Delete specific user data (for admin functionality)
  Future<bool> deleteUserData(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).delete();
      print('User data deleted for UID: $uid');
      return true;
    } catch (e) {
      print('Error deleting user data: $e');
      return false;
    }
  }

  // Get all users (READ - for admin panel)
  Future<List<UserModel>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      List<UserModel> users = [];
      
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        users.add(UserModel.fromJson(doc.data() as Map<String, dynamic>));
      }
      
      return users;
    } catch (e) {
      print('Error getting all users: $e');
      return [];
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}