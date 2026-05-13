// Controllers/DetalheObraViewController.swift
// GaleriaCuritibana
//
// Tela de detalhes de uma obra selecionada.
// Exibe imagem grande, metadados (título, artista, ano, estilo)
// e descrição em um UIScrollView.
// Inclui botão de compartilhamento via UIActivityViewController.

import UIKit

final class DetalheObraViewController: UIViewController {

    // MARK: - Dados

    private let obra: ObraDeArte

    // MARK: - UI

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    /// Stack vertical que organiza toda a hierarquia de conteúdo
    private let contentStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    /// Imagem da obra em tamanho maior
    private let imagemView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    /// Cor sólida exibida quando a imagem não está disponível
    private let imagemPlaceholder: UIView = {
        let v = UIView()
        v.isHidden = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let tituloLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let artistaLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .systemBrown
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /// Stack horizontal com as badges de ano e estilo
    private let metadataStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let separador: UIView = {
        let v = UIView()
        v.backgroundColor = .separator
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let descricaoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init

    init(obra: ObraDeArte) {
        self.obra = obra
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) não implementado — projeto usa View Code")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupScrollView()
        setupImagemSection()
        setupInfoSection()
        populateData()
    }

    // MARK: - Setup

    private func setupNavigationBar() {
        title = obra.artista
        navigationItem.largeTitleDisplayMode = .never

        // Botão de compartilhamento na barra de navegação
        let shareItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"),
            style: .plain,
            target: self,
            action: #selector(compartilharObra)
        )
        shareItem.tintColor = .systemBrown
        navigationItem.rightBarButtonItem = shareItem
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // contentStack: largura = scrollView, altura determinada pelo conteúdo
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func setupImagemSection() {
        // Container com altura fixa para a imagem hero
        let imagemContainer = UIView()
        imagemContainer.clipsToBounds = true
        imagemContainer.translatesAutoresizingMaskIntoConstraints = false

        imagemContainer.addSubview(imagemPlaceholder)
        imagemContainer.addSubview(imagemView)
        contentStack.addArrangedSubview(imagemContainer)

        NSLayoutConstraint.activate([
            imagemContainer.heightAnchor.constraint(equalToConstant: 300),

            imagemView.topAnchor.constraint(equalTo: imagemContainer.topAnchor),
            imagemView.leadingAnchor.constraint(equalTo: imagemContainer.leadingAnchor),
            imagemView.trailingAnchor.constraint(equalTo: imagemContainer.trailingAnchor),
            imagemView.bottomAnchor.constraint(equalTo: imagemContainer.bottomAnchor),

            imagemPlaceholder.topAnchor.constraint(equalTo: imagemContainer.topAnchor),
            imagemPlaceholder.leadingAnchor.constraint(equalTo: imagemContainer.leadingAnchor),
            imagemPlaceholder.trailingAnchor.constraint(equalTo: imagemContainer.trailingAnchor),
            imagemPlaceholder.bottomAnchor.constraint(equalTo: imagemContainer.bottomAnchor)
        ])
    }

    private func setupInfoSection() {
        let infoContainer = UIView()
        infoContainer.backgroundColor = .systemBackground
        infoContainer.translatesAutoresizingMaskIntoConstraints = false

        // Badges de metadados (ano e estilo)
        metadataStack.addArrangedSubview(makeBadge(texto: String(obra.ano), icone: "calendar"))
        metadataStack.addArrangedSubview(makeBadge(texto: obra.estilo, icone: "paintpalette"))

        infoContainer.addSubview(tituloLabel)
        infoContainer.addSubview(artistaLabel)
        infoContainer.addSubview(metadataStack)
        infoContainer.addSubview(separador)
        infoContainer.addSubview(descricaoLabel)
        contentStack.addArrangedSubview(infoContainer)

        NSLayoutConstraint.activate([
            tituloLabel.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 20),
            tituloLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 20),
            tituloLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -20),

            artistaLabel.topAnchor.constraint(equalTo: tituloLabel.bottomAnchor, constant: 6),
            artistaLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 20),
            artistaLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -20),

            metadataStack.topAnchor.constraint(equalTo: artistaLabel.bottomAnchor, constant: 16),
            metadataStack.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 20),
            metadataStack.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -20),

            separador.topAnchor.constraint(equalTo: metadataStack.bottomAnchor, constant: 20),
            separador.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 20),
            separador.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -20),
            separador.heightAnchor.constraint(equalToConstant: 1),

            descricaoLabel.topAnchor.constraint(equalTo: separador.bottomAnchor, constant: 16),
            descricaoLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 20),
            descricaoLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -20),
            descricaoLabel.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: -32)
        ])
    }

    // MARK: - Preenchimento de dados

    private func populateData() {
        tituloLabel.text   = obra.titulo
        artistaLabel.text  = obra.artista
        descricaoLabel.text = obra.descricao

        if let imagem = UIImage(named: obra.imagemNome) {
            imagemView.image     = imagem
            imagemPlaceholder.isHidden = true
        } else {
            // Sem imagem real: usa placeholder colorido com ícone centralizado
            imagemView.isHidden  = true
            imagemPlaceholder.isHidden = false
            imagemPlaceholder.backgroundColor = .placeholderObra(imagemNome: obra.imagemNome)

            let config  = UIImage.SymbolConfiguration(pointSize: 64, weight: .ultraLight)
            let iconView = UIImageView(image: UIImage(systemName: "photo.artframe", withConfiguration: config))
            iconView.tintColor = UIColor.white.withAlphaComponent(0.5)
            iconView.translatesAutoresizingMaskIntoConstraints = false
            imagemPlaceholder.addSubview(iconView)
            NSLayoutConstraint.activate([
                iconView.centerXAnchor.constraint(equalTo: imagemPlaceholder.centerXAnchor),
                iconView.centerYAnchor.constraint(equalTo: imagemPlaceholder.centerYAnchor)
            ])
        }
    }

    // MARK: - Helpers

    /// Cria uma badge visual pill com ícone SF Symbol + texto
    private func makeBadge(texto: String, icone: String) -> UIView {
        let container = UIView()
        container.backgroundColor = UIColor.systemBrown.withAlphaComponent(0.10)
        container.layer.cornerRadius = 8
        container.translatesAutoresizingMaskIntoConstraints = false

        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 5
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false

        let iconView = UIImageView(image: UIImage(systemName: icone))
        iconView.tintColor = .systemBrown
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 16).isActive = true

        let label = UILabel()
        label.text = texto
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .systemBrown
        label.numberOfLines = 1

        hStack.addArrangedSubview(iconView)
        hStack.addArrangedSubview(label)
        container.addSubview(hStack)

        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            hStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            hStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            hStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8)
        ])

        return container
    }

    // MARK: - Ação: Compartilhar

    /// Compartilha o título, artista e convite para conhecer artistas curitibanos
    @objc private func compartilharObra() {
        let texto = """
        "\(obra.titulo)" — \(obra.artista) (\(obra.ano))
        Conheça mais artistas curitibanos! 🎨
        """

        let activityVC = UIActivityViewController(
            activityItems: [texto],
            applicationActivities: nil
        )

        // No iPad o UIActivityViewController precisa de uma âncora (popover)
        if let popover = activityVC.popoverPresentationController {
            popover.barButtonItem = navigationItem.rightBarButtonItem
        }

        present(activityVC, animated: true)
    }
}
