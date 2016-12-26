# jaguar_cli

Command line tool for jaguar-dart

## Main help

```bash
jaguar help
```

## Building project

Builds Jaguar project.  
Generates Apis, RouteGroups, Serializers, ORM beans and Validators from jaguar.yaml config file.

```bash
jaguar build
```

### Example jaguar.yaml

```yaml
apis:
    - path/to/api1.dart
    - path/to/api2.dart
    
serializers:
    - path/to/model1.dart
    - path/to/model2.dart
    
validators:
    - path/to/model1.dart
    - path/to/model2.dart
    
beans:
    - path/to/model1.dart
    - path/to/model2.dart
```

## Building project on file changes

```bash
jaguar watch
```

## Create new project

```bash
jaguar create::project --repo <some-example> --name <desired-name>
```

Browse [examples repositories](https://github.com/jaguar-examples) for examples.

## Create new interceptor

```bash
jaguar create::interceptor --name <interceptor-name> --filename <file-name>
```

