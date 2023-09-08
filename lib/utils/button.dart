import 'package:flutter/material.dart';
import 'package:google_translator_app/models/language_model.dart';
import 'package:google_translator_app/services/apis.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.str,
  });
  final String str;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  TextEditingController searchController = TextEditingController();
  List<Languages> searchList = [];
  void _onSearchTextChanged(String query) {
    setState(() {
      searchList = APIs.availableLanguages
          .where((result) =>
              result.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _showBottomSheet(BuildContext context) {
    bool isSearching = false;
    final size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: size.width * .9,
        child: BottomSheet(
          onClosing: () {},
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        isSearching = !isSearching;
                        _onSearchTextChanged(value);
                      });
                    },
                    decoration: const InputDecoration(
                        hintText: 'Search Language',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        widget.str,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchList.length,
                      itemBuilder: (context, index) {
                        return searchList.isNotEmpty
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    if (widget.str == 'To') {
                                      APIs.languageTo = searchList[index].name!;
                                    } else {
                                      APIs.languageFrom =
                                          searchList[index].name!;
                                    }
                                  });
                                  Navigator.pop(context);
                                },
                                child: Card(
                                  elevation: 3,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  margin: const EdgeInsets.all(10.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      searchList[index].name!,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(
                                child: Text('No result found!'),
                              );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return _showBottomSheet(context);
          },
        );
      },
      child: Container(
          height: 60,
          width: size.width * 0.4,
          decoration: const BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Center(
            child: Text(
              widget.str == 'From' ? APIs.languageFrom : APIs.languageTo,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          )),
    );
  }

  
}
