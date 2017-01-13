part of jaguar_cli.cmd;

class swaggerGeneratorCommand extends Command {
  swaggerGeneratorCommand() {}

  @override
  String get name => "swagger::generate";

  @override
  String get description => "Generates swagger file for the API project.";

  @override
  run() async {
    print('Generating ...');
    print('');
    cli.SwaggerGenerator builder = new cli.SwaggerGenerator();
    await build(builder.phaseGroup,
        deleteFilesByDefault: true, logLevel: Level.WARNING);
  }
}