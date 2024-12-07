import 'package:aplikasi_baca/data/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookService {
  Future<void> createBook(BookModel book) async {
    try {
      final docRef = await FirebaseFirestore.instance.collection('books').add(book.toMap());
      print('Book created with ID: ${docRef.id}');
    } catch (error) {
      print('Failed to create book: $error');
    }
  }

  Future<List<BookModel>> getAllBooks() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('books').get();

      return querySnapshot.docs.map((doc) {
        return BookModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (error) {
      print('Failed to fetch all books: $error');
      return [];
    }
  }

  Future<List<BookModel>> getBooksByCreatorId(String creatorId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('books')
          .where('creator_id', isEqualTo: creatorId)
          .get();

      return querySnapshot.docs.map((doc) {
        return BookModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (error) {
      print('Failed to fetch books: $error');
      return [];
    }
  }

  Future<BookModel?> getBookById(String bookId) async {
    try {
      final doc = await FirebaseFirestore.instance.collection('books').doc(bookId).get();

      if (doc.exists) {
        return BookModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        print('Book not found');
        return null;
      }
    } catch (error) {
      print('Failed to fetch book: $error');
      return null;
    }
  }

  Future<void> updateBook(String bookId, Map<String, dynamic> updates) async {
    try {
      updates['updated_at'] = DateTime.now().toIso8601String();

      await FirebaseFirestore.instance.collection('books').doc(bookId).update(updates);
      print('Book updated');
    } catch (error) {
      print('Failed to update book: $error');
    }
  }

  Future<void> deleteBook(String bookId) async {
    try {
      await FirebaseFirestore.instance.collection('books').doc(bookId).delete();
      print('Book deleted');
    } catch (error) {
      print('Failed to delete book: $error');
    }
  }
}