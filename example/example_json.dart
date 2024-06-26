part of 'example.dart';

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

final portabilityOption = SkipFirst(StringPrefixThrough("\"title\": \""))
    .take(StringPrefixUpTo("\""));
