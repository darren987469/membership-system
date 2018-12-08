class AdminUsersContainer extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      users: [],
      links: {}
    }
    this.getUsersRequest = this.getUsersRequest.bind(this)
    this.promoteToAdminRequest = this.promoteToAdminRequest.bind(this)
  }

  getUsersRequest() {
    Request.request({}, {
      url: `/api/v1/admin/users?page=1&per_page=10`,
      success: (data) => {
        this.setState({
          users: data.results,
          links: data.links
        })
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
