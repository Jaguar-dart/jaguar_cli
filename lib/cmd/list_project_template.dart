part of jaguar_cli.cmd;

class ListProjectTemplateCommand extends Command {
  ListProjectTemplateCommand() {}

  @override
  String get name => "list::projects";

  @override
  String get description => "Lists all projects template.\n"
      "Lists all project templates in https://github.com/jaguar-examples as template.";

  @override
  run() async {
    cli.TemplatesLister lister = new cli.TemplatesLister();
    List<String> repos = await lister.list();

    for (String repo in repos) {
      print(repo);
    }
  }
}
