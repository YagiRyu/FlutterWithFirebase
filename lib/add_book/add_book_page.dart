import 'package:flutter/material.dart';
import 'package:flutter_firebase/add_book/add_book_model.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("book"),
          ),
          body: Center(
            child: Consumer<AddBookModel>(builder: (context, model, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: "本のタイトル",
                      ),
                      onChanged: (text) {
                        model.title = text;
                      },
                    ),
                    const SizedBox(
                        height: 16
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "本の著者",
                      ),
                      onChanged: (text) {
                        model.author = text;
                      },
                    ),
                    const SizedBox(
                        height: 8
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            await model.addBook();
                            Navigator.of(context).pop(true);
                          } catch (e) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                                content: Text(e.toString())
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                        child: Text("追加する")
                    )
                  ],
                ),
              );
            }),
          )),
    );
  }
}