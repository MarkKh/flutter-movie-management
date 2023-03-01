// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:db/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:db/models/transactions.dart';

class FormEditScreen extends StatefulWidget {
  final Transactions data;

  //Controller

  const FormEditScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<FormEditScreen> createState() => _FormEditScreenState();
}

class _FormEditScreenState extends State<FormEditScreen> {
  final formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final titleController = TextEditingController();
  final directorController = TextEditingController();
  final durationController = TextEditingController();
  final ratingController = TextEditingController();
  final categoryController = TextEditingController();
  final actorController = TextEditingController();

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  void initState() {
    super.initState();
    idController.text = widget.data.id.toString();
    titleController.text = widget.data.title.toString();
    directorController.text = widget.data.director.toString();
    durationController.text = widget.data.duration.toString();
    ratingController.text = widget.data.rating.toString();
    categoryController.text = widget.data.category.toString();
    actorController.text = widget.data.actor.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('แบบฟอร์มแก้ไขข้อมูล'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "title Name"),
                      autofocus: false,
                      controller: titleController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input title Name.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "director Name"),
                      autofocus: false,
                      controller: directorController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input director Name.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "duration"),
                      keyboardType: TextInputType.number,
                      controller: durationController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input duration.";
                        }
                        if (double.parse(str) <= 0) {
                          return "Please input duration more than 0.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "rating"),
                      keyboardType: TextInputType.number,
                      controller: ratingController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input rating.";
                        }
                        if (double.parse(str) <= 0) {
                          return "Please input rating more than 0.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "category "),
                      autofocus: false,
                      controller: categoryController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input category.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "actor Name"),
                      autofocus: false,
                      controller: actorController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input actor Name.";
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                        style: style,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var id = int.parse(idController.text);
                            var title = titleController.text;
                            var director = directorController.text;
                            var duration =
                                double.parse(durationController.text);
                            var rating = double.parse(ratingController.text);
                            var category = categoryController.text;
                            var actor = directorController.text;

                            // call provider
                            var provider = Provider.of<TransactionProvider>(
                                context,
                                listen: false);
                            Transactions item = Transactions(
                              id: id,
                              title: title,
                              director: director,
                              duration: duration,
                              rating: rating,
                              category: category,
                              actor: actor,
                            );
                            provider.updateTransaction(item);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Save data"))
                  ]),
            )));
  }
}
