// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:db/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:db/models/transactions.dart';
import 'package:intl/intl.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  //Controller
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final durationController = TextEditingController();
  final directorController = TextEditingController();
  final ratingController = TextEditingController();
  final categoryController = TextEditingController();
  final actorController = TextEditingController();

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('แบบฟอร์มบันทึกข้อมูล'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      //Title
                      decoration: const InputDecoration(labelText: "Title"),
                      autofocus: false,
                      controller: titleController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input Title Name.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      //Title
                      decoration: const InputDecoration(labelText: "Director"),
                      autofocus: false,
                      controller: directorController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input director.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      //Title
                      decoration: const InputDecoration(labelText: "category"),
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
                      //Title
                      decoration: const InputDecoration(labelText: "actor"),
                      autofocus: false,
                      controller: actorController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input actor.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      //Title
                      decoration: const InputDecoration(labelText: "rating"),
                      keyboardType: TextInputType.number,
                      autofocus: false,
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
                      //Duration
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
                    ElevatedButton(
                        style: style,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var title = titleController.text;
                            var director = directorController.text;
                            var duration =
                                double.parse(durationController.text);
                            var rating = double.parse(ratingController.text);
                            var category = categoryController.text;
                            var actor = actorController.text;

                            // call provider
                            var provider = Provider.of<TransactionProvider>(
                                context,
                                listen: false);
                            Transactions item = Transactions(
                              title: title,
                              director: director,
                              duration: duration,
                              rating: rating,
                              category: category,
                              actor: actor,
                            );

                            provider.addTransaction(item);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Add data"))
                  ]),
            )));
  }
}
