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
    Request.request({}, {
      url: `/api/v1/products?${Request.paginationParams(page, perPage)}`,
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
    const { products, ...paginationInfo } = this.state
    return(
      <div>
        <div style={{ display: 'flex', flexFlow: 'row wrap' }}>
          { products.map(product => <ProductWithImage key={ product.id } product={ product } />) }
        </div>
        <Pagination
          {...paginationInfo}
          onClick={ this.getProducts }
        />
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
