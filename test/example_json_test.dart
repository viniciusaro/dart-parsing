import 'package:parsing/parsing.dart';
import 'package:test/test.dart';

import '../example/example.dart';

final json = """
{
	"current": "HAS_HEALTH_INSURANCE",
	"title": "Você possui **outro plano de saúde**?",
	"detail": "Blá",
	"more": {
		"hint": "Não sabe o que é adesão coletiva?",
		"title": "Planos por adesão coletiva",
		"description": "São planos adquiridos através de uma administradora de benefícios e vinculados a uma associação de classe (Exemplos de administradoras de benefícios: Qualicorp, Affix, Plena, entre outras)."
	},
	"input": {
		"type": "OPTION_BUTTONS",
		"options": [{
			"title": "Mais de 1 ano",
			"detail": "Detalhe dsadsadas",
			"value": "1",
			"exclusive": "true"
		},{
			"title": "Mais de 2 ano",
			"value": "2",
			"exclusive": "true"
		}]
	}
}
""";

final subject = """
"title": "Mais de 1 ano",
"detail": "Detalhe dsadsadas",
"value": "1",
"exclusive": "true"
""";

StringPrefix2 stringThrough(String other) =>
    StringPrefix2((e) => !e.endsWith(other));

class FieldParser<A> with Parser<StringCollection, A> {
  final String name;
  final Parser<StringCollection, A> content;

  FieldParser(this.name, this.content);

  @override
  (A, StringCollection) run(StringCollection input) {
    final fieldNameParser = StringPrefix2((e) {
      return e != "\"$name\": \"";
    });

    final (_, fieldNameRest) = fieldNameParser.run(input);
    final (content, contentRest) = this.content.run(fieldNameRest);

    final endLineParser = StringPrefix2((e) {
      return !e.endsWith("\n");
    });

    final (_, rest) = endLineParser.run(contentRest);
    return (content, rest);
  }
}

final portabilityOption = //
    FieldParser("title", stringThrough(","))
        .take(FieldParser("detail", stringThrough(",")))
        .take(FieldParser("value", IntParser2()))
        .take(FieldParser("exclusive", BoolParser2()))
        .map(PortabilityStepInputOption.new);

void main() {
  test("test", () {
    final tuple = portabilityOption.run(subject.collection).$1;
    print("result: $tuple");
  });
}