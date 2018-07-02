import 'dart:io';
import 'dart:async';
import 'package:path/path.dart' as p;

class BeginProject {
  final String name;

  BeginProject(this.name) {
    // TODO
  }

  Future<void> create() async {
    await Directory(name).create();
    await File(p.join(name, 'pubspec.yaml')).writeAsString("""
name: $name
description: Enter your project description here
version: 2.1.1

environment:
  sdk: ">=2.0.0-dev.65.0 <3.0.0"

dependencies:
  jaguar: ^2.1.8

dev_dependencies:
  test: ^1.0.0
    """, flush: true);
    await Directory(p.join(name, 'bin')).create();
    await File(p.join(name, 'bin', 'main.dart')).writeAsString("""
import 'package:jaguar/jaguar.dart';

main() async {
  final server = new Jaguar(port: 10000);

  // A simple get route
  server.get('/hello', (_) => "Hello world!");

  server.log.onRecord.listen(print);
  await server.serve(logRequests: true);
}
    """, flush: true);
  }
}
