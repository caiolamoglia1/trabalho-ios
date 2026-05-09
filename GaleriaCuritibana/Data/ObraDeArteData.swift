// Data/ObraDeArteData.swift
// GaleriaCuritibana
//
// Fonte de dados estática com obras de artistas nascidos, residentes
// ou com forte ligação com a cidade de Curitiba.

import Foundation

/// Conjunto completo de obras exibidas na galeria.
/// Para adicionar uma obra: inclua a imagem no Assets.xcassets com o
/// mesmo nome usado em `imagemNome`, depois adicione um novo ObraDeArte aqui.
let obrasDeArte: [ObraDeArte] = [
    ObraDeArte(
        titulo: "Paisagem com Pinheiros",
        artista: "Alfredo Andersen",
        ano: 1910,
        estilo: "Impressionismo",
        imagemNome: "obra_1",
        descricao: "Alfredo Andersen (1860–1935), norueguês radicado em Curitiba, é considerado o 'Pai da Pintura Paranaense'. Suas paisagens capturam a essência dos pinheiros do planalto curitibano com traços impressionistas marcantes e uma sensibilidade única pela luz sul-brasileira."
    ),
    ObraDeArte(
        titulo: "Bairro Batel",
        artista: "Miguel Bakun",
        ano: 1945,
        estilo: "Expressionismo",
        imagemNome: "obra_2",
        descricao: "Miguel Bakun (1909–1963) foi um dos mais importantes pintores do Paraná. Filho de imigrantes ucranianos, retratou Curitiba e seus arredores com uma visão expressionista intensa e emocional, deixando uma obra densa e original no cenário paranaense."
    ),
    ObraDeArte(
        titulo: "Painel da Rodoviária",
        artista: "Poty Lazzarotto",
        ano: 1950,
        estilo: "Arte Mural / Modernismo",
        imagemNome: "obra_3",
        descricao: "Poty Lazzarotto (1924–1998) é o artista que mais marcou a identidade visual de Curitiba. Seus murais e painéis em azulejo espalhados pela cidade narram a história e a cultura paranaense de forma vibrante e acessível ao grande público."
    ),
    ObraDeArte(
        titulo: "Busto em Bronze",
        artista: "João Turin",
        ano: 1922,
        estilo: "Escultura Modernista",
        imagemNome: "obra_4",
        descricao: "João Turin (1878–1949) foi o primeiro escultor moderno do Paraná. Estudou na Europa e voltou a Curitiba trazendo influências do Art Nouveau e do modernismo. Suas esculturas enriquecem parques, praças e museus da cidade até hoje."
    ),
    ObraDeArte(
        titulo: "Retrato de Família",
        artista: "Theodoro De Bona",
        ano: 1935,
        estilo: "Realismo",
        imagemNome: "obra_5",
        descricao: "Theodoro De Bona (1904–1990) nasceu em Curitiba e aperfeiçoou-se em Roma. Destacou-se na pintura de retratos e figuras humanas com técnica realista requintada, tornando-se uma das referências mais sólidas do cenário artístico paranaense do século XX."
    ),
    ObraDeArte(
        titulo: "Cena Urbana Curitibana",
        artista: "Italo Viaro",
        ano: 1952,
        estilo: "Modernismo",
        imagemNome: "obra_6",
        descricao: "Italo Viaro (1898–1971), italiano radicado em Curitiba, foi pintor e professor que influenciou gerações de artistas paranaenses. Suas cenas urbanas registram a transformação de Curitiba no século XX com paletas vibrantes e composições dinâmicas."
    ),
    ObraDeArte(
        titulo: "Natureza Viva Paranaense",
        artista: "Elvo Benito Damo",
        ano: 1968,
        estilo: "Realismo / Naturalismo",
        imagemNome: "obra_7",
        descricao: "Elvo Benito Damo (1922–2000) é reconhecido por suas naturezas-mortas e paisagens que celebram a flora e a fauna do Paraná. Suas obras revelam um olhar sensível e uma técnica depurada ao longo de décadas de produção artística em Curitiba."
    ),
    ObraDeArte(
        titulo: "Abstração em Cores",
        artista: "Nilo Previdi",
        ano: 1975,
        estilo: "Abstracionismo",
        imagemNome: "obra_8",
        descricao: "Nilo Previdi (1921–2009) foi um dos pioneiros do abstracionismo no Paraná. Suas composições geométricas e o uso ousado de cores marcaram a transição da arte paranaense para o modernismo internacional, consolidando Curitiba no mapa da arte contemporânea brasileira."
    )
]
