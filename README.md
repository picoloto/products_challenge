# products_challenge
Projeto Mobile Flutter cujo objetivo é exibar uma lista de produtos, salvar produtos nos favoritos (localmente) e poder acessar os detalhes dos produtos.

### Especificações técnicas

- Flutter 3.27.1
- VsCode com a extensão `Flutter` e `Dart`

### Como rodar o projeto

- Clonar o repositório
    - Branch principal: main
- Rodar o comando `dart pub get` para instalar as dependências
- Se estiver no VsCode, rodar com o atalho `F5`
    - É necessário ter um emulador android ou IOS, ou um celular conectado para rodar

### Como testar o projeto

- Rodar o comando `flutter test` para rodar e acompanhar os testes.

### Arquitetura

Esse projeto usa o padrão **MVVM** de arquitetura, contando com uma camada de domínio (`models`), uma camada de apresentação (`view`) e uma camada de controle (`view_model`). 
As camadas foram divididas em funcionalidades para facilitar a escalabilidade.

Foi criada uma camada de serviço (`service`) responsável pelas requisições para as APIs.

Foi criada uma camada chamada de compartilhamento (`shared`) que fica responsável por armazenar os recursos (widgets, utils...) reutilizáveis.

### Estrutura de arquivos

```
├── lib
│   ├── model
│   │   ├── product
│   │   └── rating
│   ├── route
│   ├── service
│   │   ├── product
│   │   ├── product_local
│   │   └── rest
│   ├── shared
│   │   ├── environments
│   │   ├── theme
│   │   ├── utils
│   │   └── widgets
│   ├── view
│   │   ├── error
│   │   └── product
│   ├── view_model
│   │   ├── product_details
│   │   ├── products
│   │   └── products_local
├── test
```


### Bibliotecas utilizadas

- freezed_annotation: ^2.4.4
- json_annotation: ^4.9.0
- mobx: ^2.5.0
- shared_preferences: ^2.3.4
- freezed: ^2.5.7
- get_it: ^8.0.3
- dio: ^5.7.0
- go_router: ^14.6.2
- google_fonts: ^6.2.1
- mobx_codegen: ^2.7.0
- flutter_mobx: ^2.3.0
- shared_preferences_platform_interface: ^2.4.1
- flutter_lints: ^5.0.0
- json_serializable: ^6.9.0
- build_runner: ^2.4.14
- flutter_image_test_utils: ^1.0.0
- mockito: ^5.1.0