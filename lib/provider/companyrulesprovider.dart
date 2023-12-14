
import 'package:cnattendance/data/source/network/model/rules/CompanyRules.dart';
import 'package:cnattendance/model/content.dart';
import 'package:cnattendance/repositories/companyrulerepository.dart';
import 'package:flutter/material.dart';

class CompanyRulesProvider with ChangeNotifier {
  final List<Content> _contentList = [];
  CompanyRuleRepository repository = CompanyRuleRepository();

  List<Content> get contentList {
    return [..._contentList];
  }

  Future<void> getContent() async {
    try {
      final response = await repository.getContent();

      makeRules(response.data);
    } catch (e) {
      rethrow;
    }
  }

  void makeRules(List<CompanyRules> data) {
    _contentList.clear();
    for (final item in data) {
      _contentList
          .add(Content(title: item.title, description: item.description));
    }
    notifyListeners();
  }
}
