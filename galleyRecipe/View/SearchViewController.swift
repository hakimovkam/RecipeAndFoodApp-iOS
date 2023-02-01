import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    private let searchController = UISearchController(searchResultsController: nil)//  1- создаем серчбар

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "UIKit Soup"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.font = UIFont(name: "Poppins-Regular", size: 16)
        searchBar.setImage(UIImage(named: "Union"), for: UISearchBar.Icon.search, state: .normal)
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextPositionAdjustment.horizontal = 10
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = .clear
        searchBar.layer.cornerRadius = 16
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1).cgColor
        return searchBar
    }()
    
    private var galleryCollectionView = GalleryCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.searchController = searchController
        setupEmptyView()
        configCollectionView()
        searchBar.delegate = self
        galleryCollectionView.set(cells: ChipsBar.chipsButton())
        
    }

    func setupEmptyView() {
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: searchBar.rightAnchor , constant: 16),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configCollectionView() {
        view.addSubview(galleryCollectionView)
        view.backgroundColor = .white
        
        galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalToConstant: 75).isActive = true // размер ячейки по высоте
    }

}

class GalleryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cells = [ChipsBar]()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = .white // цвет фона коллекции
        delegate = self
        dataSource = self
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
        translatesAutoresizingMaskIntoConstraints = false
        contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12) //от стенок
        
        //убираем скролл индикатор
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    // наполнение ячеек инфой из массива ChipsBar
    func set(cells: [ChipsBar]) {
        self.cells = cells
    }
    
    // количество ячеек в секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return 8
       return cells.count
    }
    
    
    var previousSelected : IndexPath?
    var currentSelected : Int?
    // настрйока ячейки, секции, текста
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as! GalleryCollectionViewCell
        
        if currentSelected != nil && currentSelected == indexPath.row
                {
                    cell.backgroundColor = UIColor.green
                }else{
                    cell.backgroundColor = UIColor.white //изначально белые
                }
        cell.nameLabel.text = cells[indexPath.row].firstLineCollView
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

            // выделяет зленым. при смене ячейки остатся красной. новая ячейка зеленая
            if previousSelected != nil{
                if let cell = collectionView.cellForItem(at: previousSelected!){
                    cell.backgroundColor = UIColor.systemPink
                }
            }
            currentSelected = indexPath.row
            previousSelected = indexPath

            // For reload the selected cell
     // reloadItems(at: [indexPath]) // выделяет но не отменяет выделение
       reloadData()// выделение пропадает совсем
        }
    
    // размер ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 74, height: 32)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "GalleryCollectionViewCell"
    
    // настройка шрифта
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular) // размер шрифта , шрифт
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(nameLabel)
        
        backgroundColor = .white // цвет фона конопки
        
        // nameLabel constraints
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 50).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 16
        self.layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        self.clipsToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct ChipsBar {
    var firstLineCollView: String
    //var secondLineCollectViewFlags: String
    
    static func chipsButton() -> [ChipsBar] {
        
        let firstItem = ChipsBar(firstLineCollView: "soups")
        
        let secondItem = ChipsBar(firstLineCollView: "salads")
        
        let thirdItem = ChipsBar(firstLineCollView: "meat")
        
        let fouthItem = ChipsBar(firstLineCollView: "deserts")
        
        let fiveItem = ChipsBar(firstLineCollView: "bakery")
        
        let six = ChipsBar(firstLineCollView: "1")

        let seven = ChipsBar(firstLineCollView: "2")

        let eight = ChipsBar(firstLineCollView: "3")
        
        let firstItemf = ChipsBar(firstLineCollView: "soupsf")
        
        let secondItemf = ChipsBar(firstLineCollView: "saladsf")
        
        let thirdItemf = ChipsBar(firstLineCollView: "meatf")
        
        let fouthItemf = ChipsBar(firstLineCollView: "desertsf")
        
        let fiveItemf = ChipsBar(firstLineCollView: "bakeryf")
        
        let sixf = ChipsBar(firstLineCollView: "1f")

        let sevenf = ChipsBar(firstLineCollView: "2f")

        let eightf = ChipsBar(firstLineCollView: "3f")
        
        
        return [firstItem, secondItem, thirdItem, fouthItem, fiveItem, six, seven, eight
        , firstItemf, secondItemf, thirdItemf, fouthItemf, fiveItemf, sixf, sevenf, eightf]
    }
}
