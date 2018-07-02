part of jaguar_cli.cmd;

class BeginProjectCommand extends Command {
  BeginProjectCommand() {
    argParser.addOption('name',
        abbr: 'n',
        help: 'Name of the project to create',
        defaultsTo: 'myproject');
  }

  @override
  String get name => "begin";

  @override
  String get description => "Creates a new project.\n";

  @override
  run() async {
    final String name = argResults['name'];

    final projCre = cli.BeginProject(name);
    await projCre.create();
  }
}
