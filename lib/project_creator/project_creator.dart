library jaguar_cli.project_creator;

import 'dart:io';
import 'dart:async';
import "package:console/console.dart";

class ProjectCreator {
  final String repo;

  final String _name;

  String get name => _name ?? repo;

  ProjectCreator(this._name, this.repo) {}

  Future<Null> run() async {
    List<String> gitArguments = [
      'clone',
      '--single-branch',
      'https://github.com/jaguar-examples/$repo',
    ];

    if(_name is String) {
      gitArguments.add(_name);
    }

    Console.setTextColor(Color.BLUE.id, bright: Color.BLUE.bright);
    stdout.write('Creating $name ...');

    _progress();

    ProcessResult result = await Process.run('git', gitArguments);

    if (result.exitCode != 0) {
      Console.setTextColor(Color.RED.id, bright: Color.RED.bright);
      print('');
      print('Project creation failed!');
      Console.resetAll();
      print('${result.stderr}');
      exit(1);
    }

    _endProgress();

    Console.setTextColor(Color.GREEN.id, bright: Color.GREEN.bright);
    print('');
    print('Project created successfully!');
    Console.resetAll();
  }

  StreamSubscription _progressSubscription;

  void _progress() {
    _progressSubscription =
        new Stream.periodic(const Duration(seconds: 1)).listen((_) {
      stdout.write('.');
    });
  }

  void _endProgress() {
    _progressSubscription.cancel();
    print('');
    Console.resetAll();
  }
}
