library jaguar_cli.interceptor_creator;

import 'dart:io';
import 'dart:async';
import "package:console/console.dart";
import 'package:inflection/inflection.dart';

class InterceptorCreator {
  final String name;

  final String _filename;

  String get filename => _filename ?? (SNAKE_CASE.convert(name) + '.dart');

  InterceptorCreator(this.name, this._filename) {}

  Future<Null> run() async {
    Console.setTextColor(Color.BLUE.id, bright: Color.BLUE.bright);
    stdout.write('Creating interceptor $name in file $filename ...');

    _progress();

    File file = new File(filename);

    if (file.existsSync()) {
      Console.setTextColor(Color.RED.id, bright: Color.RED.bright);
      print('');
      print('');
      print('Interceptor creation failed!');
      Console.resetAll();
      print('File $filename already exists!');
      exit(1);
    }

    try {
      InterceptorWriter writer = new InterceptorWriter(name);
      file.writeAsStringSync(writer.toString(),
          flush: true, mode: FileMode.WRITE);
    } catch (e) {
      Console.setTextColor(Color.RED.id, bright: Color.RED.bright);
      print('');
      print('Interceptor creation failed!');
      Console.resetAll();
      print(e);
      exit(1);
    }

    _endProgress();

    Console.setTextColor(Color.BLUE.id, bright: Color.BLUE.bright);
    stdout.write('Formatting interceptor ... ');

    _progress();

    ProcessResult result = await Process.run('dartfmt', [filename, '-w']);

    if (result.exitCode != 0) {
      Console.setTextColor(Color.RED.id, bright: Color.RED.bright);
      print('');
      print('Interceptor creation failed!');
      Console.resetAll();
      print('${result.stderr}');
      exit(1);
    }

    _endProgress();

    Console.setTextColor(Color.GREEN.id, bright: Color.GREEN.bright);
    print('');
    print('Interceptor created successfully!');
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

class InterceptorWriter {
  final String name;

  StringBuffer _sb = new StringBuffer();

  InterceptorWriter(this.name) {
    _generate();
  }

  void _generate() {
    _writeWrapper();
    _writeInterceptor();
  }

  void _writeWrapper() {
    _sb.writeln("class Wrap$name implements RouteWrapper<$name> {");
    _sb.writeln(r"final String id;");
    _sb.writeln();

    _sb.writeln(r"final Map<Symbol, MakeParam> makeParams;");
    _sb.writeln();

    _sb.writeln("const Wrap$name({this.id, this.makeParams = const {}});");
    _sb.writeln();

    _sb.writeln("$name createInterceptor() => new $name();");
    _sb.writeln("}");
  }

  void _writeInterceptor() {
    _sb.writeln("class $name extends Interceptor {");
    _sb.writeln("$name();");
    _sb.writeln();

    _sb.writeln("void pre() {");
    _sb.writeln("}");
    _sb.writeln();

    _sb.writeln("void post() {");
    _sb.writeln("}");
    _sb.writeln();

    _sb.writeln("}");
  }

  String toString() => _sb.toString();
}
