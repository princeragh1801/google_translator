import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_translator_app/models/language_model.dart';
import 'package:google_translator_app/services/apis.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        _showBottomSheet(context);
      },
      child: Container(
          height: 60,
          width: size.width * 0.4,
          decoration: const BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Center(
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          )),
    );
  }

  _showBottomSheet(BuildContext context) {
    final languages = APIs.availableLanguages;
    final size = MediaQuery.of(context).size;
    bool isSearching = false;
    final List<Languages> searchList = [];

    return showBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: size.height * .05),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              // search box
              Container(
                height: 50,
                width: size.width * .8,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: TextFormField(
                  onTap: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  onChanged: (value) {
                    searchList.clear();
                    for (var i in languages) {
                      if (i.name!.toLowerCase().contains(value.toLowerCase())) {
                        searchList.add(i);
                        setState(() {
                          searchList;
                          log('Data : ${searchList.first}');
                        });
                      }
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Search Country',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder()),
                ),
              ),

              // language list
              SizedBox(
                height: size.height * .7,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: isSearching ? searchList.length : languages.length,
                  itemBuilder: (context, index) {
                    Languages language =
                        isSearching ? searchList[index] : languages[index];
                    return 
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          height: 50,
                          width: size.width * .8,
                          decoration: const BoxDecoration(
                              color: Colors.black38,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Text(
                            language.name!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}
