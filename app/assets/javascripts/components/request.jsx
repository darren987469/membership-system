class Request {
  static request(params = {}, options = {}) {
    let defaultOptions = {
      method: 'GET',
      contentType: 'application/json',
      data: JSON.stringify(params)
    }
    $.ajax({ ...defaultOptions, ...options })
  }
}