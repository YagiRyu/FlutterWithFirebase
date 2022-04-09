import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/domain/book.dart';

class BookListModel extends ChangeNotifier {

  List<Book>? books;

  void fetchBookList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('books').get();

    final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      final String title = data["title"];
      final String author = data["author"];
      final String id = document.id;
      return Book(id, title, author);
    }).toList();
      this.books = books;
      notifyListeners();
    }

    Future deleteBook(Book book) {
      return FirebaseFirestore.instance.collection('books').doc(book.id).delete();
    }
}
