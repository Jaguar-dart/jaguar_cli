part of jaguar_cli.cmd;

class CreateInterceptorCommand extends Command {
  CreateInterceptorCommand() {
    argParser.addOption('name', abbr: 'n', help: 'Name of the interceptor');
    argParser.addOption('filename',
        abbr: 'f', help: 'Filename for the interceptor');
  }

  @override
  String get name => "create::interceptor";

  @override
  String get description => "Creates new interceptor.\n"
      "Creates a new empty intercetor and its wrapper.";

  @override
  run() async {
    final String filename = argResults['filename'];
    final String name = argResults['name'];
    cli.InterceptorCreator cre = new cli.InterceptorCreator(name, filename);
    await cre.run();
  }
}
