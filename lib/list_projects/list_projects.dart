library jaguar_cli.list_projects;

import 'dart:async';
import 'package:github/server.dart';

class TemplatesLister {
  final GitHub github = createGitHubClient();

  TemplatesLister() {}

  Future<List<String>> list() async {
    Stream<Repository> reposStream =
        github.repositories.listOrganizationRepositories('jaguar-examples');

    List<String> ret = [];

    await for (Repository repo in reposStream) {
      String desc = repo.description.split('\n').first;

      ret.add("${repo.name}: $desc");
    }

    return ret;
  }
}
