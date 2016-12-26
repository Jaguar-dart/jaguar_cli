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
    cli.Builder builder = new cli.Builder();
    build(builder.phaseGroup, deleteFilesByDefault: true);
  }
}
