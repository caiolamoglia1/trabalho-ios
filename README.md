# Galeria de Artistas Curitibanos

Aplicativo iOS em Swift (UIKit, View Code) que apresenta uma galeria de obras
de artistas nascidos, residentes ou com forte ligação com a cidade de Curitiba.

## Funcionalidades

- **Galeria em grade** com `UICollectionView` responsiva (2 a 4 colunas conforme dispositivo e orientação)
- **Busca em tempo real** por título ou nome do artista via `UISearchController`
- **Tela de detalhe** com imagem em destaque, badges de metadados (ano, estilo) e descrição
- **Compartilhamento** da obra através de `UIActivityViewController`
- **Feedback háptico** ao tocar nas células
- **Suporte a Dark Mode** com cores semânticas (`.label`, `.systemBackground`, ...)
- **Placeholder colorido** quando a imagem de uma obra não está disponível

## Estrutura do projeto

```
GaleriaCuritibana/
├── AppDelegate.swift
├── SceneDelegate.swift
├── Models/
│   └── ObraDeArte.swift                  # Struct do domínio
├── Data/
│   └── ObraDeArteData.swift              # Catálogo estático de obras
├── Views/
│   └── ObraDeArteCell.swift              # Célula customizada (card)
├── Controllers/
│   ├── GaleriaViewController.swift       # Tela principal (galeria + busca)
│   └── DetalheObraViewController.swift   # Tela de detalhe da obra
├── Assets.xcassets/                      # Imagens e cores
├── Info.plist
└── LaunchScreen.storyboard
```

Arquitetura: **MVC** com View Code (sem Storyboards exceto a `LaunchScreen`).

## Requisitos

- Xcode 15.0+
- iOS 15.0+
- Swift 5.0

## Como executar

1. Clone o repositório:
   ```
   git clone https://github.com/caiolamoglia1/trabalho-ios.git
   ```
2. Abra `GaleriaCuritibana.xcodeproj` no Xcode.
3. Selecione um simulador (iPhone ou iPad) e pressione **⌘R**.

## Artistas representados

Alfredo Andersen, Miguel Bakun, Poty Lazzarotto, João Turin, Theodoro De Bona,
Italo Viaro, Elvo Benito Damo e Nilo Previdi.
