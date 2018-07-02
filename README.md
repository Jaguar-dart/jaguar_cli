# jaguar_cli

Command line tool for jaguar-dart

## Main help

```bash
jaguar help
```

## Create new project

`begin` sub-command creates a new project with the name provided using `--name`
command line option.

```bash
jaguar begin --name helloworld
```

### Run the project

```bash
cd helloworld
pub get
```

```dart
dart bin/main.dart
```

Visit [`http://localhost:10000/hello`](http://localhost:10000/hello) from your
browser.

## Clone an example or boilerplate

```bash
jaguar create::project --repo boilerplate_mux --name learn_mux
```

### List available example and boilerplates

```bash
jaguar list::projects
```

The complete list is also found at [examples repositories](https://github.com/jaguar-examples)
as repositories.

