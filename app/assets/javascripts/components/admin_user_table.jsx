function AdminUserTable(props) {
  const { users, currentUser, promoteToAdminRequest } = props
  return(
    <table className="w3-table-all" style={{ marginTop: '30px' }}>
      <thead>
        <tr className="w3-grey">
          <th>Email</th>
          <th>Membership</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        {
          users.map(user =>
            <UserTableRow
              key={ user.id }
              user= { user }
              currentUser={ currentUser }
              promoteToAdminRequest={ promoteToAdminRequest }
            />
          )
        }
      </tbody>
    </table>
  )
}

function UserTableRow(props) {
  const { user, currentUser, promoteToAdminRequest } = props
  let button = null
  if(user.id != currentUser.id && (user.role === 'normal' || user.role === 'premium')){
    button =
      <button onClick={() => promoteToAdminRequest(user.id)} className="w3-button w3-teal w3-ripple">
        Promote to Admin
      </button>
  }
  return(
    <tr>
      <td>{user.email}</td>
      <td>{user.role}</td>
      <td>{button}</td>
    </tr>
  )
}
