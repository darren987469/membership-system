class AdminUsersContainer extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      users: [],
      page: 1,
      perPage: 10,
      totalCount: null
    }
    this.getUsersRequest = this.getUsersRequest.bind(this)
    this.promoteToAdminRequest = this.promoteToAdminRequest.bind(this)
  }

  getUsersRequest() {
    const { page, perPage } = this.state
    Request.request({}, {
      url: `/api/v1/admin/users?page=${page}&per_page=${perPage}`,
      success: (data) => {
        this.setState({ users: data.results, totalCount: data.total_count })
      }
    })
  }

  promoteToAdminRequest(userId) {
    Request.request({}, {
      url: `/api/v1/admin/users/${userId}/promote_to_admin`,
      method: 'PATCH',
      success: (data) => {
        this.setState(prevState =>
          ({ users: prevState.users.map(user => user.id === data.id ? data : user) })
        )
      }
    })
  }

  componentDidMount() {
    this.getUsersRequest()
  }

  render() {
    const { currentUser } = this.props
    const { users } = this.state
    const { promoteToAdminRequest } = this

    return(
      <div>
        <AdminUserTable
          users={ users }
          currentUser={ currentUser }
          promoteToAdminRequest={ promoteToAdminRequest }
        />
      </div>
    )
  }
}
