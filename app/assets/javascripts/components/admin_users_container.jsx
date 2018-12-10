class AdminUsersContainer extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      users: props.users,
      currentPage: props.currentPage,
      totalPages: props.totalPages,
      perPage: props.perPage,
      totalCount: props.totalCount,
      pageEntriesInfo: props.pageEntriesInfo
    }
    this.getUsersRequest = this.getUsersRequest.bind(this)
    this.promoteToAdminRequest = this.promoteToAdminRequest.bind(this)
  }

  getUsersRequest(page, perPage) {
    Request.request({}, {
      url: `${ADMIN_USERS_PATH}?${Request.paginationParams(page, perPage)}`,
      success: (data) => {
        this.setState({
          users: data.results,
          currentPage: data.page,
          totalPages: data.total_pages,
          perPage: data.per_page,
          totalCount: data.total_count,
          pageEntriesInfo: data.page_entries_info
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

  render() {
    const { currentUser } = this.props
    const { users, ...paginationInfo } = this.state
    const { promoteToAdminRequest, getUsersRequest } = this

    return(
      <div>
        <AdminUserTable
          users={ users }
          currentUser={ currentUser }
          promoteToAdminRequest={ promoteToAdminRequest }
        />
        <Pagination
          {...paginationInfo}
          onClick={ getUsersRequest }
        />
      </div>
    )
  }
}
