# Seguro App

MVP desenvolvido em Flutter para um desafio técnico mobile/web. O aplicativo demonstra telas responsivas de login e Home, validação de campos e navegação entre funcionalidades.

## Funcionalidades

- Tela de login com validação e formatação de CPF e validação de senha.
- Home com opções para cotar e contratar seguros de Automóvel, Residência, Vida e Acidentes Pessoais.
- Adição de membros da família durante a sessão.
- Menu lateral e opção de logout.
- Abertura das páginas dos produtos: em Android, dentro de uma WebView; na Web, em uma nova aba.
- Ícones de redes sociais ilustrativos.

> O login é demonstrativo: não há autenticação conectada a uma API ou ao Firebase. Os membros adicionados à família são mantidos apenas em memória durante a execução do app.

## Tecnologias

- Flutter 3.50.0 e Dart.
- `material_ui`, `webview_flutter`, `url_launcher` e `flutter_svg`.
- Localização configurada com `flutter_localizations`, `intl` e arquivos ARB.

## Requisitos

- Flutter 3.50.0 instalado.
- Android Studio e um emulador ou dispositivo Android configurado.
- O projeto foi executado em um emulador Android com API 34.

## Como executar

Clone o repositório e acesse a pasta do projeto:

```bash
git clone https://github.com/gavillar/seguradora_app_web.git
cd seguradora_app

Instale as dependências e execute:
flutter pub get
flutter run

flutter devices

Escolha:
flutter run -d chrome

LOGIN e authenticação devem utilizar este usuário.
CPF: 529.982.247.25
Senha: Seguradora123#
User: João da Silva
