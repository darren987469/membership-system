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
              products.map(
                product =>
                <tr key={ product.id }>
                  <td>{ product.name }</td>
                  <td>{ product.price }</td>
                  <td>
                    {
                      product.images.map(image => <img key={ image.url } src={ image.url } width="150" height="100" />)
                    }
                  </td>
                </tr>
              )
            }
          </tbody>
        </table>
      </div>
    )
  }
}
