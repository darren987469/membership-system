class Request {
  static request(params = {}, options = {}) {
    let defaultOptions = {
      method: 'GET',
      contentType: 'application/json',
      data: JSON.stringify(params)
    }
    $.ajax({ ...defaultOptions, ...options })
  }
  static paginationParams(page, perPage) {
    return `page=${page}&per_page=${perPage}`
  }
}

const ADMIN_USERS_PATH = '/api/v1/admin/users'
const PRODUCTS_PATH = '/api/v1/products'
