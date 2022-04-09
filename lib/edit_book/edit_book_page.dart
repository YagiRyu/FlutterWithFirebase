import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/book.dart';
import 'edit_book_model.dart';

class UpdateBookPage extends StatelessWidget {

  final Book book;
  UpdateBookPage(this.book);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UpdateBookModel>(
      create: (_) => UpdateBookModel(book),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("編集"),
          ),
          body: Center(
            child: Consumer<UpdateBookModel>(builder: (context, model, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: "本のタイトル",
                      ),
                      onChanged: (text) {
                        model.setTitle(text);
                      },
                      controller: model.titleController,
                    ),
                    const SizedBox(
                        height: 16
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "本の著者",
                      ),
                      onChanged: (text) {
                        model.setAuthor(text);
                      },
                      controller: model.authorController,
                    ),
                    const SizedBox(
                        height: 8
                    ),
                    ElevatedButton(
                        onPressed: model.isUpdated() ? () async {
                          try {
                            await model.update();
                            Navigator.of(context).pop(model.title);
                          } catch (e) {
                            final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString())
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        } : null,
                        child: Text("更新する")
                    )
                  ],
                ),
              );
            }),
          )),
    );
  }
}