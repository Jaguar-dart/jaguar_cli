part of jaguar_cli.cmd;

class VersionCommand extends Command {
  VersionCommand() {}

  @override
  String get name => "version";

  @override
  String get description => "Displays version of Jaguar.dart\n";

  @override
  run() async {
    print('Jaguar.dart CLI 0.0.26');
  }
}
