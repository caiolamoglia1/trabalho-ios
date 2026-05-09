// Controllers/GaleriaViewController.swift
// GaleriaCuritibana
//
// Tela principal do app: galeria em grade com UICollectionView,
// busca em tempo real (UISearchController) e animação de toque.
//
// Padrão MVC: este controller atua como DataSource e Delegate da
// UICollectionView, mantendo a lógica de apresentação separada
// do model (ObraDeArte) e da view (ObraDeArteCell).

import UIKit

final class GaleriaViewController: UIViewController {

    // MARK: - Dados

    /// Catálogo completo das obras (nunca modificado após init)
    private let obras: [ObraDeArte] = obrasDeArte

    /// Subconjunto exibido (filtrado pela busca ou igual ao catálogo completo)
    private var filteredObras: [ObraDeArte] = obrasDeArte

    // MARK: - UI

    /// CollectionView principal com layout em grade
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemGroupedBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ObraDeArteCell.self, forCellWithReuseIdentifier: ObraDeArteCell.identifier)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    /// Barra de busca integrada ao NavigationBar
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        // false: a CollectionView continua visível durante a busca
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Buscar por título ou artista…"
        sc.searchBar.tintColor = .systemBrown
        return sc
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
    }

    /// Invalida o layout ao rotacionar para recalcular o tamanho das células
    override func viewWillTransition(
        to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator
    ) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }

    // MARK: - Setup

    private func setupNavigationBar() {
        title = "Artistas Curitibanos"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        // Impede que a tela de resultados cubra o conteúdo ao buscar
        definesPresentationContext = true
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Layout responsivo

    /// Número de colunas adaptado ao tamanho de tela e orientação
    private func numeroDeColunas() -> Int {
        let largura = collectionView.bounds.width
        if traitCollection.userInterfaceIdiom == .pad {
            // iPad: 4 colunas em landscape, 3 em portrait
            return largura > 900 ? 4 : 3
        }
        // iPhone: 3 colunas em landscape, 2 em portrait
        return largura > 500 ? 3 : 2
    }
}

// MARK: - UICollectionViewDataSource

extension GaleriaViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return filteredObras.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ObraDeArteCell.identifier,
            for: indexPath
        ) as? ObraDeArteCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: filteredObras[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension GaleriaViewController: UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let obra = filteredObras[indexPath.item]

        // Animação de feedback ao tocar: escala para 95% e volta ao normal
        if let cell = collectionView.cellForItem(at: indexPath) {
            // Feedback háptico leve (desafio adicional)
            UIImpactFeedbackGenerator(style: .light).impactOccurred()

            UIView.animate(
                withDuration: 0.12,
                animations: {
                    cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                },
                completion: { _ in
                    UIView.animate(withDuration: 0.12) {
                        cell.transform = .identity
                    } completion: { _ in
                        // Navega para a tela de detalhe após a animação
                        self.pushDetalhe(for: obra)
                    }
                }
            )
        } else {
            pushDetalhe(for: obra)
        }
    }

    // MARK: - Navegação

    private func pushDetalhe(for obra: ObraDeArte) {
        let detalhe = DetalheObraViewController(obra: obra)
        navigationController?.pushViewController(detalhe, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GaleriaViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let colunas        = CGFloat(numeroDeColunas())
        let insets         = CGFloat(16 * 2)                 // sectionInset leading + trailing
        let espacamentos   = CGFloat(16) * (colunas - 1)    // minimumInteritemSpacing
        let larguraCelula  = floor((collectionView.bounds.width - insets - espacamentos) / colunas)
        // Proporção ~2:3 para acomodar imagem (65%) + texto (35%)
        let alturaCelula   = larguraCelula * 1.45
        return CGSize(width: larguraCelula, height: alturaCelula)
    }
}

// MARK: - UISearchResultsUpdating

extension GaleriaViewController: UISearchResultsUpdating {

    /// Chamado a cada caractere digitado na barra de busca
    func updateSearchResults(for searchController: UISearchController) {
        let termo = searchController.searchBar.text ?? ""

        if termo.isEmpty {
            filteredObras = obras
        } else {
            // Filtra por título OU nome do artista (sem diferença de maiúsculas)
            filteredObras = obras.filter {
                $0.titulo.localizedCaseInsensitiveContains(termo) ||
                $0.artista.localizedCaseInsensitiveContains(termo)
            }
        }
        collectionView.reloadData()
    }
}
