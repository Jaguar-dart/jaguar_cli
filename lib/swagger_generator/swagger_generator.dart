library jaguar_cli.swagger_generator;

import 'dart:async';

import 'dart:io';
import 'package:build/build.dart';
import 'package:yaml/yaml.dart';
import 'package:jaguar_generator/swagger/builder/builder.dart';

class SwaggerGenerator {
  String _projectName;

  final List<String> _apis = [];

  SwaggerGenerator() {
    _readProjectName();
    _readConfig();
  }

  void _readProjectName() {
    File pubspec = new File('./pubspec.yaml');

    if (!pubspec.existsSync()) {
      throw new Exception('pubspec.yaml not found!');
    }

    String content = pubspec.readAsStringSync();
    Map<String, dynamic> doc = loadYaml(content);

    _projectName = doc['name'] as String;
  }

  void _readConfig() {
    File pubspec = new File('./jaguar.yaml');

    if (!pubspec.existsSync()) {
      throw new Exception('jaguar.yaml configuration file not found!');
    }

    String content = pubspec.readAsStringSync();
    Map<String, dynamic> _config = loadYaml(content) as Map<String, dynamic>;

    {
      dynamic apis = _config['apis'];

      if (apis is List<String>) {
        _apis.addAll(apis);
      }
    }
  }

  Phase get apiPhase => new Phase()
    ..addAction(new SwaggerBuilder(), new InputSet(_projectName, _apis));

  PhaseGroup get phaseGroup {
    PhaseGroup phaseGroup = new PhaseGroup();

    phaseGroup.addPhase(apiPhase);

    return phaseGroup;
  }
}
