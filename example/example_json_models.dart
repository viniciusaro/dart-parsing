part of 'example.dart';

class PortabilityStep {
  final String title;
  final String detail;
  final PortabilityStepMore more;
  final PortabilityStepInput input;

  PortabilityStep({
    required this.title,
    required this.detail,
    required this.more,
    required this.input,
  });
}

class PortabilityStepMore {
  final String hint;
  final String title;
  final String description;

  PortabilityStepMore({
    required this.hint,
    required this.title,
    required this.description,
  });
}

class PortabilityStepInput {
  final PortabilityStepInputType type;
  final List<PortabilityStepInputOption> options;

  PortabilityStepInput({
    required this.type,
    required this.options,
  });
}

enum PortabilityStepInputType {
  optionButtons;
}

class PortabilityStepInputOption {
  final String title;
  final String detail;
  final int value;
  final bool exclusive;

  PortabilityStepInputOption(
    (String title, String detail, int value, bool exclusive) tuple,
  )   : this.title = tuple.$1,
        this.detail = tuple.$2,
        this.value = tuple.$3,
        this.exclusive = tuple.$4;
}
