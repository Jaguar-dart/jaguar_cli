part of jaguar_cli.cmd;

class CreateProjectCommand extends Command {
  CreateProjectCommand() {
    argParser.addOption('repo',
        abbr: 'r',
        help: 'Repository from https://github.com/jaguar-examples to clone',
        defaultsTo: 'boilerplate');
    argParser.addOption('name', abbr: 'n', help: 'Name of the project');
  }

  @override
  String get name => "create::project";

  @override
  String get description => "Creates new project.\n"
      "Uses one of the examples from https://github.com/jaguar-examples as template."
      "If no --repo option is specified it uses boilerplate repository as default.";

  @override
  run() async {
    final String repo = argResults['repo'];
    final String name = argResults['name'];
    cli.ProjectCreator projCre = new cli.ProjectCreator(name, repo);
    await projCre.run();
  }
}
