// Views/ObraDeArteCell.swift
// GaleriaCuritibana
//
// Célula customizada usada pela UICollectionView da galeria.
// Exibe a imagem da obra, o título e o nome do artista em estilo "card".

import UIKit

final class ObraDeArteCell: UICollectionViewCell {

    // MARK: - Reutilização

    static let identifier = "ObraDeArteCell"

    // MARK: - Subviews

    /// Imagem da obra de arte (aspect fill, topo do card)
    private let imagemView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    /// View de cor sólida exibida quando a imagem não está disponível
    private let placeholderView: UIView = {
        let v = UIView()
        v.isHidden = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    /// Título da obra (negrito, até 2 linhas)
    private let tituloLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /// Nome do artista (cor secundária, 1 linha)
    private let artistaLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) não implementado — projeto usa View Code")
    }

    // MARK: - Layout

    private func setupUI() {
        // Estilo card: fundo branco/adaptativo com cantos arredondados
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true

        // Sombra no layer raiz para que não seja cortada pelo masksToBounds
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.12
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 6
        layer.masksToBounds = false

        contentView.addSubview(placeholderView)
        contentView.addSubview(imagemView)
        contentView.addSubview(tituloLabel)
        contentView.addSubview(artistaLabel)

        NSLayoutConstraint.activate([
            // Área da imagem: 65% da altura total da célula
            imagemView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imagemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imagemView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.65),

            // Placeholder sobrepõe a área da imagem
            placeholderView.topAnchor.constraint(equalTo: imagemView.topAnchor),
            placeholderView.leadingAnchor.constraint(equalTo: imagemView.leadingAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: imagemView.trailingAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: imagemView.bottomAnchor),

            // Título logo abaixo da imagem
            tituloLabel.topAnchor.constraint(equalTo: imagemView.bottomAnchor, constant: 8),
            tituloLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            tituloLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            // Artista abaixo do título
            artistaLabel.topAnchor.constraint(equalTo: tituloLabel.bottomAnchor, constant: 2),
            artistaLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            artistaLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            artistaLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    // MARK: - Configuração pública

    /// Preenche a célula com os dados de uma ObraDeArte
    func configure(with obra: ObraDeArte) {
        tituloLabel.text = obra.titulo
        artistaLabel.text = obra.artista

        if let imagem = UIImage(named: obra.imagemNome) {
            imagemView.image = imagem
            placeholderView.isHidden = true
        } else {
            // Sem imagem: exibe cor de placeholder + ícone SF Symbol
            imagemView.image = nil
            placeholderView.isHidden = false
            placeholderView.backgroundColor = placeholderColor(for: obra.imagemNome)
            insertPlaceholderIcon(into: placeholderView, pointSize: 28)
        }
    }

    // MARK: - Reutilização

    override func prepareForReuse() {
        super.prepareForReuse()
        imagemView.image = nil
        placeholderView.isHidden = true
        placeholderView.subviews.forEach { $0.removeFromSuperview() }
    }

    // MARK: - Helpers

    /// Cor distinta para cada obra, baseada no índice do nome (obra_1 → índice 0, etc.)
    private func placeholderColor(for imagemNome: String) -> UIColor {
        let palette: [UIColor] = [
            UIColor(red: 0.55, green: 0.36, blue: 0.26, alpha: 1), // marrom terra
            UIColor(red: 0.20, green: 0.40, blue: 0.60, alpha: 1), // azul profundo
            UIColor(red: 0.60, green: 0.20, blue: 0.20, alpha: 1), // vermelho escuro
            UIColor(red: 0.25, green: 0.50, blue: 0.35, alpha: 1), // verde musgo
            UIColor(red: 0.55, green: 0.45, blue: 0.20, alpha: 1), // ocre
            UIColor(red: 0.35, green: 0.25, blue: 0.55, alpha: 1), // roxo
            UIColor(red: 0.20, green: 0.45, blue: 0.50, alpha: 1), // azul petróleo
            UIColor(red: 0.50, green: 0.30, blue: 0.45, alpha: 1), // bordô
        ]
        let numero = imagemNome.filter { $0.isNumber }
        let index = (Int(numero) ?? 1) - 1
        return palette[index % palette.count]
    }

    /// Insere um ícone de moldura de arte centralizado no container
    private func insertPlaceholderIcon(into container: UIView, pointSize: CGFloat) {
        container.subviews.forEach { $0.removeFromSuperview() }
        let config = UIImage.SymbolConfiguration(pointSize: pointSize, weight: .ultraLight)
        let iconView = UIImageView(image: UIImage(systemName: "photo.artframe", withConfiguration: config))
        iconView.tintColor = UIColor.white.withAlphaComponent(0.6)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }
}
