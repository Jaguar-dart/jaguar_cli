library jaguar_cli.cmd;

import 'dart:async';
import 'package:args/args.dart';
import 'package:jaguar_cli/builder/builder.dart' as cli;
import 'package:jaguar_cli/project_creator/project_creator.dart' as cli;
import 'package:build/build.dart';
import "package:console/console.dart";

class CommandCreator {
  ArgParser _parser = new ArgParser();

  CommandCreator() {
    _addBuildCmd();
    _addWatchCmd();
    _addCreateInterceptorCmd();
    _addCreateProjectCmd();
    _addCreateRouteGroupCmd();
  }

  void _addBuildCmd() {
    ArgParser build = _parser.addCommand('build');
  }

  void _addWatchCmd() {
    ArgParser watch = _parser.addCommand('watch');
  }

  void _addCreateInterceptorCmd() {
    ArgParser cmd = _parser.addCommand('create::interceptor');
    cmd.addOption('name', abbr: 'n');
  }

  void _addCreateProjectCmd() {
    ArgParser cmd = _parser.addCommand('create::project');
    cmd.addOption('repo', abbr: 'r');
    cmd.addOption('name', abbr: 'n');
  }

  void _addCreateRouteGroupCmd() {
    ArgParser cmd = _parser.addCommand('create::routegroup');
    cmd.addOption('name', abbr: 'n');
  }

  Future<Null> parse(List<String> arguments) async {
    ArgResults res = _parser.parse(arguments).command;

    if(res == null) {
      print('No recognisable command specified!');

      print(_parser.usage);
      return;
    }

    switch(res.name) {
      case 'build':
        cli.Builder builder = new cli.Builder();
        build(builder.phaseGroup, deleteFilesByDefault: true);
        break;
      case 'watch':
        cli.Builder builder = new cli.Builder();
        watch(builder.phaseGroup, deleteFilesByDefault: true);
        break;
      case 'create::project':
        final String repo = res['repo'];
        final String name = res['name'];
        cli.ProjectCreator projCre = new cli.ProjectCreator(name, repo);
        await projCre.run();
        break;
    }
  }
}