part of jaguar_cli.cmd;

class WatchCommand extends Command {
  WatchCommand() {}

  @override
  String get name => "watch";

  @override
  String get description =>
      "Builds Jaguar project automatically on file changes.\n"
      "Generates Apis, RouteGroups, Serializers, ORM beans and Validators from "
      "jaguar.yaml config file.";

  @override
  run() async {
    cli.Builder builder = new cli.Builder();
    watch(builder.phaseGroup, deleteFilesByDefault: true);
  }
}
