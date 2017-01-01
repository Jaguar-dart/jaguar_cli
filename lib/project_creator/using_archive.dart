library jaguar_cli.project_creator.using_archive;

import 'dart:io';
import 'dart:async';
import "package:console/console.dart";
import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class ProjectCreatorUsingGitArchive {
  final String repo;

  final String _name;

  String get name => _name ?? repo;

  String get archiveUrl =>
      "https://github.com/jaguar-examples/$repo/archive/master.zip";

  ProjectCreatorUsingGitArchive(this._name, this.repo) {}

  Future<String> _download() async {
    Directory directory = await Directory.systemTemp.createTemp('jaguar_dart');
    http.Response resp = await http.get(archiveUrl);

    final String masterZipPath = path.join(directory.path, 'master.zip');

    File file = new File(masterZipPath);
    await file.writeAsBytes(resp.bodyBytes);

    return file.path;
  }

  Future<Null> run() async {
    Console.setTextColor(Color.BLUE.id, bright: Color.BLUE.bright);
    stdout.write('Creating $name ...');

    _progress();

    try {
      String archivePath = await _download();

      File archiveFile = new File(archivePath);

      List<int> bytes = await archiveFile.readAsBytes();

      Archive archive = new ZipDecoder().decodeBytes(bytes);

      for (ArchiveFile file in archive) {
        String newFilePath = _makePath(file.name, name);
        if (file.isFile) {
          List<int> data = file.content;
          File newFile = new File(newFilePath);
          await newFile.create(recursive: true);
          await newFile.writeAsBytes(data);
        } else {
          Directory dir = new Directory(newFilePath);
          await dir.createSync(recursive: true);
        }
      }
    } catch (e) {
      _endProgress();

      Console.setTextColor(Color.RED.id, bright: Color.RED.bright);
      print('');
      print('Project creation failed!');
      Console.resetAll();
      print(e);
      exit(1);
    }

    _endProgress();

    Console.setTextColor(Color.GREEN.id, bright: Color.GREEN.bright);
    print('');
    print('Project created successfully!');
    Console.resetAll();
  }

  String get shitPrefix => "$repo-master";

  String _makePath(String dst, String base) {
    List<String> parts = path.split(dst);

    if (parts.length != 0) {
      if (parts.first == shitPrefix) {
        parts.removeAt(0);
      }
    }
    parts.insert(0, base);
    return path.joinAll(parts);
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
