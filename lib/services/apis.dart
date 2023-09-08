import 'dart:convert';
import 'dart:developer';
import 'package:google_translator_app/models/language_model.dart';
import 'package:google_translator_app/models/translation_model.dart';
import 'package:http/http.dart' as http;

class APIs {
  
  static Map<String, String> query = {"target": "en"};

  static List<Languages> availableLanguages = [];
  static Translations translations = Translations();

  static Future<void> getLanguages() async {
    const languageAPIKey =
      "8e4862efe7msh7f8ff90742336c4p186ce7jsn0d6188a1564f";
      const baseUrl =
        "https://google-translate1.p.rapidapi.com/language/translate/v2/languages";

    const Map<String, String> headers = {
      "Accept-Encoding": "application/gzip",
      "X-RapidAPI-Key": languageAPIKey,
      "X-RapidAPI-Host": "google-translate1.p.rapidapi.com"
    };
      try {
        Uri uri = Uri.parse(baseUrl).replace(queryParameters: query);
        final response = await http.get(
          uri,
          headers: headers,
        );
        log(response.body);
        if (response.statusCode == 200) {
          availableLanguages =
              LanguageModel.fromJson(jsonDecode(response.body)).data!.languages!;
        } else {
          throw 'unable to load data';
        }
      } catch (e) {
        throw e.toString();
      }

    
  }

  static Future<void> transalteText({required String text}) async {
    const languageAPIKey =
      "8e4862efe7msh7f8ff90742336c4p186ce7jsn0d6188a1564f";
    final headers = {
      "content-type": "application/x-www-form-urlencoded",
      "Accept-Encoding": "application/gzip",
      "X-RapidAPI-Key": languageAPIKey,
      "X-RapidAPI-Host": "google-translate1.p.rapidapi.com",
    };
    final body = {
      "q": text,
      "target": "es",
      "source": "en",
    };
    const translateUrl =
        "https://google-translate1.p.rapidapi.com/language/translate/v2";
    final url = Uri.parse(translateUrl);

    try {
      final response = await http.post(url, headers: headers, body: body);
      log(response.body);
      if (response.statusCode == 200) {
        translations = Translations.fromJson(jsonDecode(response.body));
      } else {
        throw ('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      throw ('Error: $error');
    }
  }
}
