// Models/ObraDeArte.swift
// GaleriaCuritibana
//
// Struct que representa uma obra de arte de um artista curitibano.

import Foundation

/// Representa uma obra de arte exibida na galeria.
struct ObraDeArte {
    /// Título da obra
    let titulo: String

    /// Nome completo do artista
    let artista: String

    /// Ano de criação da obra
    let ano: Int

    /// Estilo artístico (ex: Impressionismo, Arte Mural)
    let estilo: String

    /// Nome do arquivo de imagem no Assets Catalog
    let imagemNome: String

    /// Breve descrição da obra ou do artista
    let descricao: String
}
