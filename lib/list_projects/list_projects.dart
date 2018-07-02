library jaguar_cli.list_projects;

import 'dart:async';

class _Template {
  final String name;

  final String url;

  final String description;

  const _Template(this.name, this.url, this.description);
}

const _templates = const <_Template>[
  const _Template(
      'boilerplate_mux',
      'https://github.com/jaguar-examples/boilerplate_mux',
      'Simplest Jaguar project possible. Shows routing using RouteHandlers and mux.'),
  const _Template(
      'boilerplate_reflect',
      'https://github.com/jaguar-examples/boilerplate_reflect',
      'Simplest Jaguar project possible. Shows routing using Controllers and reflection.'),
  const _Template('https', 'https://github.com/jaguar-examples/https',
      'A sample HTTPS project.'),
];

class TemplatesLister {
  TemplatesLister() {}

  void list() {
    for (final template in _templates) {
      print('');
      print('${template.name}: ${template.url}');
      print(template.description);
    }
  }
}
