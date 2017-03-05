library jaguar_cli.build;

import 'dart:io';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:yaml/yaml.dart';

import 'package:jaguar_generator/hook/api/import.dart';
import 'package:jaguar_generator/hook/route_group/import.dart';
import 'package:jaguar_serializer/src/generator/generator.dart';
import 'package:jaguar_validate/generator/hook/hook.dart';
import 'package:jaguar_orm/generator/hook/hook.dart';

class Builder {
  String _projectName;

  final List<String> _apis = [];

  final List<String> _serializers = [];

  final List<String> _validators = [];

  final List<String> _beans = [];

  Builder() {
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

    {
      dynamic serializers = _config['serializers'];

      if (serializers is List<String>) {
        _serializers.addAll(serializers);
      }
    }

    {
      dynamic validators = _config['validators'];

      if (validators is List<String>) {
        _validators.addAll(validators);
      }
    }

    {
      dynamic beans = _config['beans'];

      if (beans is List<String>) {
        _beans.addAll(beans);
      }
    }
  }

  Phase get apiPhase => new Phase()
    ..addAction(
        new GeneratorBuilder(const [
          const RouteGroupGenerator(),
          const ApiGenerator(),
        ]),
        new InputSet(_projectName, _apis));

  Phase get serializersPhase => new Phase()
    ..addAction(
        new GeneratorBuilder(const [
          const SerializerGenerator(),
        ]),
        new InputSet(_projectName, _serializers));

  Phase get validatorsPhase => new Phase()
    ..addAction(
        new GeneratorBuilder(const [
          const ValidatorGenerator(),
        ]),
        new InputSet(_projectName, _validators));

  Phase get beansPhase => new Phase()
    ..addAction(
        new GeneratorBuilder(const [
          const BeanGenerator(),
        ]),
        new InputSet(_projectName, _beans));

  PhaseGroup get phaseGroup {
    PhaseGroup phaseGroup = new PhaseGroup();

    phaseGroup.addPhase(apiPhase);
    phaseGroup.addPhase(serializersPhase);
    phaseGroup.addPhase(validatorsPhase);
    phaseGroup.addPhase(beansPhase);

    return phaseGroup;
  }
}
