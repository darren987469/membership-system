class ProductsContainer extends React.Component {
  constructor(props) {
    super(props)
    const { data } = props
    this.state = {
      currentUser: props.currentUser,
      products: data.results,
      currentPage: data.page,
      totalPages: data.total_pages,
      perPage: data.per_page,
      totalCount: data.total_count,
      pageEntriesInfo: data.page_entries_info
    }
    this.getProducts = this.getProducts.bind(this)
  }

  getProducts(page, perPage) {
    const params = `page=${page}&per_page=${perPage}`
    Request.request({}, {
      url: `/api/v1/products?${params}`,
      success: (data) => {
        this.setState({
          products: data.results,
          currentPage: data.page,
          totalPages: data.total_pages,
          perPage: data.per_page,
          totalCount: data.total_count,
          pageEntriesInfo: data.page_entries_info
        })
      }
    })
  }

  render() {
    const { currentUser, products, currentPage, perPage, totalPages, pageEntriesInfo } = this.state
    let productRows = []
    for(let i = 0; i < products.length; i = i + 4) {
      productRows.push(
        <div key={i} className="w3-row-padding w3-padding-16 w3-center">
          { products[i] && <ProductWithImage key={ products[i].id } product={ products[i] } /> }
          { products[i+1] && <ProductWithImage key={ products[i+1].id } product={ products[i+1] } /> }
          { products[i+2] && <ProductWithImage key={ products[i+2].id } product={ products[i+2] } /> }
          { products[i+3] && <ProductWithImage key={ products[i+3].id } product={ products[i+3] } /> }
        </div>
      )
    }
    const pages = Pagination.paginate(currentPage, totalPages)
    return(
      <div>
        { productRows }
        <div className="w3-center">
          <div className="w3-bar">
            {
              pages.map(
                page => <a key={ page } className="w3-button" onClick={ () => { this.getProducts(page, perPage) } }>{ page }</a>
              )
            }
          </div>
        </div>
        <div className="w3-center">
          { pageEntriesInfo }
        </div>
      </div>
    )
  }
}

function ProductWithImage(props) {
  const { product } = props
  const amount = product.price - product.discount_amount
  const amountUI = amount === product.price ?
    <span>${amount}</span> :
    <span>
      <strong className="w3-text-red">${amount}</strong><br></br>
      <s>${product.price}</s>
    </span>
  const image = product.images[0]
  return(
    <div className="w3-quarter">
      { image && <img src={ image.url } alt={ product.name } style={{ weight: '150px', height: '100px' }}/> }
      <h3>{ product.name }</h3>
      <p>{ amountUI }</p>
    </div>
  )
}
