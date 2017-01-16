// Copyright (c) 2016, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import "package:args/command_runner.dart";
import 'package:jaguar_cli/cmd/cmd.dart';
import "package:console/console.dart";

main(List<String> arguments) async {
  Console.init();

  CommandRunner runner = new CommandRunner(
      "jaguar", "Command-line tools for the Jaguar framework.");

  runner
    ..addCommand(new BuilderCommand())
    ..addCommand(new WatchCommand())
    ..addCommand(new CreateProjectCommand())
    ..addCommand(new CreateInterceptorCommand())
    ..addCommand(new VersionCommand())
    ..addCommand(new ListProjectTemplateCommand())
    ..addCommand(new SwaggerGeneratorCommand());

  try {
    await runner.run(arguments);
  } catch (e) {
    stderr.writeln(
        "Oops, something went wrong! Please report the issue to jaguar developers!");
    stderr.writeln(e);
    exitCode = 1;
  }

  Console.resetAll();
}
