import 'package:flutter/material.dart';

class BookModel {
  final String id;
  final String author;
  final String category;
  final String pages;
  final String status;
  final String subtitle;
  final String photo;
  final String title;

  BookModel({required this.photo, required this.id,required this.author, required this.category, required this.pages, required this.status, required this.subtitle, required this.title});

  factory BookModel.fromjson(Map<String, dynamic> json){
    final String id = json['id'];
    final String author = json['autor'] ?? "";
    final String photo = json['photo'] ?? "";
    final String category = json['category'] ?? "";
    final String pages = json['pages'] ?? "";
    final String status = json['status'] ?? "";
    final String subtitle = json['subtitle'] ?? "";
    final String title = json['title'] ?? "";
    return BookModel(id: id, author: author, category: category, pages: pages, status: status, subtitle: subtitle, title: title, photo: photo);
  }

  Widget getPhotoBook(){
    if(photo.isEmpty){
      return Image.asset('assets/images/produto-sem-imagem.png');
    }
    return Image.network(photo);
  }
}