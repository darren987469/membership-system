class ProductsContainer extends React.Component {
  constructor(props) {
    super(props)
    const { data } = props
    this.state = {
      currentUser: props.currentUser,
      products: data.results,
      page: data.page,
      perPage: data.per_page,
      totalCount: data.total_count
    }
  }

  render() {
    const { currentUser, products } = this.state
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
    return(
      <div>{ productRows }</div>
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
