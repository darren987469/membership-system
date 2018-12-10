class Pagination extends React.Component {
  paginate(currentPage, totalPage) {
    let window = 2
    let left = currentPage - window
    let right = currentPage + window
    let range = []
    let rangeWithDots = []

    for(let i = 1; i <= totalPage; i++) {
      if(i == 1 || i == totalPage || i >= left && i < right)
        range.push(i)
    }

    let l
    for(let i of range) {
      if(l) {
        if(i - l === 2) {
          rangeWithDots.push(l + 1)
        } else if(i - l !== 1) {
          rangeWithDots.push('...')
        }
      }
      rangeWithDots.push(i)
      l = i
    }
    return rangeWithDots
  }

  render() {
    const { currentPage, totalPages, perPage, pageEntriesInfo, onClick } = this.props
    const pages = this.paginate(currentPage, totalPages)
    return(
      <div>
        <div className="w3-center">
          <div className="w3-bar">
            {
              pages.map(
                page => <a key={ page } className="w3-button" onClick={ ()=> { onClick(page, perPage) } } >{ page }</a>
              )
            }
          </div>
        </div>
        <div className="w3-center">
            { pageEntriesInfo }
        </div>
      </div>
    )
  }
}

/*
for(let i = 1, l = 20; i <= l; i++) {
  pagination = new Pagination()
  console.log(`Select page ${i}:`, pagination.paginate(i, l))
}

Selected page 1: [1, 2, 3, "...", 20]
Selected page 2: [1, 2, 3, 4, "...", 20]
Selected page 3: [1, 2, 3, 4, 5, "...", 20]
Selected page 4: [1, 2, 3, 4, 5, 6, "...", 20]
Selected page 5: [1, 2, 3, 4, 5, 6, 7, "...", 20]
Selected page 6: [1, "...", 4, 5, 6, 7, 8, "...", 20]
Selected page 7: [1, "...", 5, 6, 7, 8, 9, "...", 20]
Selected page 8: [1, "...", 6, 7, 8, 9, 10, "...", 20]
Selected page 9: [1, "...", 7, 8, 9, 10, 11, "...", 20]
Selected page 10: [1, "...", 8, 9, 10, 11, 12, "...", 20]
Selected page 11: [1, "...", 9, 10, 11, 12, 13, "...", 20]
Selected page 12: [1, "...", 10, 11, 12, 13, 14, "...", 20]
Selected page 13: [1, "...", 11, 12, 13, 14, 15, "...", 20]
Selected page 14: [1, "...", 12, 13, 14, 15, 16, "...", 20]
Selected page 15: [1, "...", 13, 14, 15, 16, 17, "...", 20]
Selected page 16: [1, "...", 14, 15, 16, 17, 18, 19, 20]
Selected page 17: [1, "...", 15, 16, 17, 18, 19, 20]
Selected page 18: [1, "...", 16, 17, 18, 19, 20]
Selected page 19: [1, "...", 17, 18, 19, 20]
Selected page 20: [1, "...", 18, 19, 20]
*/
