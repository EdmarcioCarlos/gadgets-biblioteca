# Biblioteca Compartilhada dos Gadgets

Componentes reutilizáveis entre os 14 gadgets da linha tática.

## Conteúdo
- `_BIBLIOTECA-3D/` → `bb_lib.scad` — Caixas paramétricas, tampas, molduras
- `_SITE/` — Scripts e hub para gerar site de documentação
- `PREVIA-AEG/` — Montagem virtual dos gadgets na réplica
- `PAINEL-ESTOQUE.html` + `ESTOQUE.js` — Painel de controle de estoque
- `PREVIA-GERAL-LUNETA.html` — Prévia dos gadgets montados na luneta

## Uso
Cada gadget clona esta biblioteca como submodule ou copia a pasta `lib/` localmente.

```bash
git submodule add https://github.com/EdmarcioCarlos/gadgets-biblioteca.git lib
```

## Gadgets que usam esta biblioteca
- [Bomba Search & Destroy](https://github.com/EdmarcioCarlos/gadget-01-bomba-sd)
- [Powerbank dos Tablets](https://github.com/EdmarcioCarlos/gadget-02-powerbank-tablets)
- [Nivel Anti-Cant](https://github.com/EdmarcioCarlos/gadget-03-nivel-anticant)
- [Cronografo](https://github.com/EdmarcioCarlos/gadget-04-cronografo)
- [Amplificador de Rede ESP-NOW](https://github.com/EdmarcioCarlos/gadget-05-amplificador-espnow)
- [ANPEQ Laser](https://github.com/EdmarcioCarlos/gadget-06-anpeq-laser)
- [Speedloader Eletrico](https://github.com/EdmarcioCarlos/gadget-07-speedloader-eletrico)
- [Granada Som e Luz](https://github.com/EdmarcioCarlos/gadget-08-granada-som-luz)
- [Alvo Acionador](https://github.com/EdmarcioCarlos/gadget-09-alvo-acionador)
- [Tracante no Silenciador](https://github.com/EdmarcioCarlos/gadget-10-tracante-silenciador)
- [Scanner UHF](https://github.com/EdmarcioCarlos/gadget-11-scanner-uhf)
- [Telemtro com Zona](https://github.com/EdmarcioCarlos/gadget-12-telemtro-zona)
- [Cyberdeck de Campo](https://github.com/EdmarcioCarlos/gadget-13-cyberdeck-campo)
- [Visao Noturna Clip-on](https://github.com/EdmarcioCarlos/gadget-14-visao-noturna-clipon)
