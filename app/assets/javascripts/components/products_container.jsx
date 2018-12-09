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
    return(
      <div>
        <table>
          <thead>
            <tr>
              <td>Name</td>
              <td>Price</td>
              <td>Images</td>
            </tr>
          </thead>
          <tbody>
            {
              products.map(product => <ProductTableRow key={ product.id } product={ product }/>)
            }
          </tbody>
        </table>
      </div>
    )
  }
}

function ProductTableRow(props) {
  const { product } = props
  const amount = product.price - product.discount_amount
  const amountUI = amount === product.price ?
    <div>{amount}</div> : <div>{amount}<br></br><s>{product.price}</s></div>
  return(
    <tr>
      <td>{ product.name }</td>
      <td>{ amountUI }</td>
      <td>
        {
          product.images.map(image => <img key={ image.url } src={ image.url } width="150" height="100" />)
        }
      </td>
    </tr>
  )
}
