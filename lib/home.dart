import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_translator_app/services/apis.dart';
import 'package:google_translator_app/utils/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  
  String textTobeTranslated = '';
  String translatedText = '';
  @override
  void initState() {
    super.initState();
    APIs.getLanguages();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 100, right: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // padding: const EdgeInsets.only(left: 20, top: 100),
                children: [
                  const Text(
                    'Text Translation',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                        // title: APIs.languageFrom,
                        str: 'From',
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.change_circle),
                      SizedBox(
                        width: 5,
                      ),
                      CustomButton(
                        // title: APIs.languageTo,
                        str: 'To',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Translate From (${APIs.languageFrom})',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: size.width * 0.9,
                    height: size.height * 0.25,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.black38,
                    ),
                    child: TextFormField(
                      maxLines: null,
                      controller: controller,
                      onChanged: (value) {
                        setState(() {
                          APIs.transalteText(text: value);
                          translatedText =
                              APIs.translations.translatedText == null
                                  ? ''
                                  : APIs.translations.translatedText!;
                          
                        });
                        log(translatedText);
                      },
                      decoration: const InputDecoration(
                          hintText: 'Write something to translate',
                          hintStyle: TextStyle(
                            fontSize: 13,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Translate To (${APIs.languageTo})',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: size.width * 0.9,
                      height: size.height * 0.25,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Colors.black38,
                      ),
                      child: Text(
                        translatedText.isEmpty
                            ? 'Translated text shown here'
                            : translatedText,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.grey),
                      )),
                ]),
          ),
        ),
      ),
    );
  }
}
