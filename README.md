# Rick and Morty App

Este projeto Flutter consome a API do Rick and Morty, exibindo personagens, detalhes, lista de episódios e permite troca de idioma (PT/EN). Abaixo, um resumo do papel de cada arquivo.

## Estrutura dos arquivos principais

### main.dart
Responsável por inicializar o app, configurar tema, internacionalização e definir a página inicial.

### models/
- **character_model.dart**: Define o modelo de personagem, com todos os campos retornados pela API.
- **episode_model.dart**: Define o modelo de episódio, usado para parsear dados de episódios (lista de todos os episódios em que o personagem está presente).

### pages/
- **home_page.dart**: Tela inicial, exibe lista de personagens, busca (por nome, sobrenome ou nome completo), navegação para card de detalhes e menu lateral. Implementada com scrolling infinito que carrega os personagens de 20 em 20. Tela obrigatória.
- **character_detail_page.dart**: Tela de detalhes do personagem, mostra informações obrigatórias para o desafio, como nome, imagem, status, gênero,  origem, última localização, primeira aparição, adicionado também o número de episódios em que o personagem aparece que, quando clicado, carrega a lista com o nome dos episódios. Tela obrigatória.
- **episode_list_page.dart**: Tela que exibe a lista de episódios em que o personagem aparece. Tela opcional.
- **menu_page.dart**: Menu lateral para seleção de idioma e futuras opções. Tela opcional.

### repository/
- **api_repository.dart**: Responsável por acessar a API do Rick and Morty usando Dio. Fornece métodos para buscar personagens e episódios.

### theme/
- **app_colors.dart**: Centraliza a paleta de cores do app (design system).
- **app_fonts.dart**: Centraliza estilos de texto/tipografia do app.

### widgets/
- **app_bar.dart**: AppBar customizada com logo central, ícone de menu/back, ícone de usuário, título do app e ícone de pesquisa.
- **character_card.dart**: Card visual para exibir personagem na lista (fiel ao design fornecido).
- **status_indicator.dart**: Widget visual para exibir o status (vivo, morto, desconhecido) do personagem (fiel ao design fornecido).
- **search_bar.dart**: Widget para barra de busca, exibida ao clicar no ícone de busca na HomePage. Permite pesquisar personagens por nome, sobrenome e nome completo.

---

> Para ver exemplos de navegação, busca e troca de idioma, consulte os GIFs na seção abaixo.

---

## Como rodar o projeto

1. Instale as dependências:
	```sh
	flutter pub get
	```
2. Execute em um emulador ou dispositivo:
	```sh
	flutter run
	```

---

## GIFs de demonstração

![Navegação: Home page > Detalhes do personagem > Lista de episódios](C:\Users\faria\FlutterProjects\rick_and_morty_app\kode-start\docs\Navegação-DetailCard-ListaDeEpisódios.gif)
![Barra de pesquisa](C:\Users\faria\FlutterProjects\rick_and_morty_app\kode-start\docs\BarraDePesquisa.gif)
![Seleção de idioma](C:\Users\faria\FlutterProjects\rick_and_morty_app\kode-start\docs\SelecionarIdioma.gif)
![Scroll Infinito](C:\Users\faria\FlutterProjects\rick_and_morty_app\kode-start\docs\InfinityScrolling.gif)

---

## Contato

Desenvolvido por Marianne Farias
https://github.com/marianne-farias
marianne.lucia@gmail.com
