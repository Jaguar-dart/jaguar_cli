// Copyright (c) 2016, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:jaguar_cli/jaguar_cli.dart' as jaguar_cli;
import 'package:jaguar_cli/cmd/cmd.dart';
import "package:console/console.dart";

main(List<String> arguments) {
  Console.init();

  CommandCreator cmd = new CommandCreator();
  cmd.parse(arguments);

  Console.resetAll();
}
