import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/news_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get news by category - Fixed the Firestore query issue
  Stream<List<NewsModel>> getNewsByCategory(String category) {
    try {
      return _db
          .collection('news')
          .where('category', isEqualTo: category)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => NewsModel.fromFirestore(doc.data(), doc.id))
              .toList());
    } catch (e) {
      print('Error getting news by category: $e');
      // Return empty stream on error
      return Stream.value([]);
    }
  }

  // Get all news - Fixed ordering issue
  Stream<List<NewsModel>> getAllNews() {
    try {
      return _db
          .collection('news')
          .snapshots()
          .map((snapshot) {
            var newsList = snapshot.docs
                .map((doc) => NewsModel.fromFirestore(doc.data(), doc.id))
                .toList();
            
            // Sort by publishedAt in Dart instead of Firestore
            newsList.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
            return newsList;
          });
    } catch (e) {
      print('Error getting all news: $e');
      return Stream.value([]);
    }
  }

  // Get trending news (limit to 5) - Fixed query
  Stream<List<NewsModel>> getTrendingNews() {
    try {
      return _db
          .collection('news')
          .limit(5)
          .snapshots()
          .map((snapshot) {
            var newsList = snapshot.docs
                .map((doc) => NewsModel.fromFirestore(doc.data(), doc.id))
                .toList();
            
            // Sort by publishedAt in Dart
            newsList.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
            return newsList;
          });
    } catch (e) {
      print('Error getting trending news: $e');
      return Stream.value([]);
    }
  }

  // Add a method to add sample data for testing
  Future<void> addSampleNews() async {
    try {
      final sampleNews = [
        {
          'title': 'New Academic Program Launched',
          'description': 'University introduces innovative computer science program with AI focus.',
          'imageUrl': 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=400&h=300&fit=crop',
          'category': 'Academic',
          'publishedAt': Timestamp.now(),
          'content': 'The university has launched a new academic program focusing on artificial intelligence and machine learning. This program aims to prepare students for the future of technology.',
        },
        {
          'title': 'Football Team Wins Championship',
          'description': 'University football team secures victory in regional championship.',
          'imageUrl': 'https://images.unsplash.com/photo-1431324155629-1a6deb1dec8d?w=400&h=300&fit=crop',
          'category': 'Sport',
          'publishedAt': Timestamp.now(),
          'content': 'Our football team has won the regional championship after a thrilling final match. The team showed exceptional skill and teamwork throughout the tournament.',
        },
        {
          'title': 'Annual Cultural Festival',
          'description': 'Join us for the biggest cultural celebration of the year.',
          'imageUrl': 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=400&h=300&fit=crop',
          'category': 'Event',
          'publishedAt': Timestamp.now(),
          'content': 'The annual cultural festival will feature performances, food stalls, and cultural exhibitions from various communities. Don\'t miss this amazing celebration!',
        },
      ];

      for (var news in sampleNews) {
        await _db.collection('news').add(news);
      }
      
      print('Sample news added successfully');
    } catch (e) {
      print('Error adding sample news: $e');
    }
  }

  // Check if collection exists and has data
  Future<bool> hasNewsData() async {
    try {
      final snapshot = await _db.collection('news').limit(1).get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking news data: $e');
      return false;
    }
  }
}