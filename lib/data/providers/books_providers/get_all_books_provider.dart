import 'package:aplikasi_baca/common/result_state.dart';
import 'package:aplikasi_baca/common/services/book_service.dart';
import 'package:aplikasi_baca/data/models/book_model.dart';
import 'package:flutter/material.dart';

class GetAllBooksProvider extends ChangeNotifier {
  final BookService _bookService = BookService();

  late ResultState _state;
  late List<BookModel> _listBookModel;
  String _message = '';

  ResultState get state => _state;
  List<BookModel> get listBookModel => _listBookModel;
  String get message  => _message;

  GetAllBooksProvider() {
    _fetchListBook();
  }

  Future<dynamic> _fetchListBook () async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await _bookService.getAllBooks();

      if(response.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return response;
      }

      _state = ResultState.hasData;
      notifyListeners();

      return response;
    } catch (error) {
      _state = ResultState.error;
      notifyListeners();

      return _message = '$error';
    }
  } 
}