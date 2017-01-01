part of jaguar_cli.cmd;

class BuilderCommand extends Command {
  BuilderCommand() {}

  @override
  String get name => "build";

  @override
  String get description => "Builds Jaguar project.\n"
      "Generates Apis, RouteGroups, Serializers, ORM beans and Validators from "
      "jaguar.yaml config file.";

  @override
  run() async {
    print('Building ...');
    print('');
    cli.Builder builder = new cli.Builder();
    await build(builder.phaseGroup,
        deleteFilesByDefault: true, logLevel: Level.WARNING);
  }
}
