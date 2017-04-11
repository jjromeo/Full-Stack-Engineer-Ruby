var ComicsPage = React.createClass({
  perPage: 15,
  comicLimit: 90,
  page: 1,
  set: 1,

  render: function() {
    return(
      <div>
        <input type="text" value={this.state.searchValue} onChange={this.updateSearchValue} placeholder="Search for a character"></input>
        <button onClick={this.getComics} >Search!</button>
        <Comics comics={this.state.currentComics}/>
        <p>Current page: {this.state.pageNumber}</p>
        <button disabled={this.state.disableButtons} onClick={this.previousPage}>Previous Page</button>
        <button disabled={this.state.disableButtons} onClick={this.nextPage}>Next page</button>
      </div>
    )
  },

  getInitialState: function() {
    return { allComics: this.props.comics, currentComics: this.currentComics(this.props.comics, this.page), images: this.props.images, pageNumber: 1, disableButtons: '' };
  },

  previousPage: function() {
    if(this.page > 1) {
      this.page--;
      this.refreshCurrentComics();
    } else if(this.set > 1) {
      this.set--;
      this.page = this.maxPage();
      this.getComics();
    }
    this.decreasePageNumber();
  },

  nextPage: function() {
    if(this.page < this.maxPage()) {
      this.page++;
      this.refreshCurrentComics();
    } else {
      this.set++;
      this.page = 1
      this.getComics();
    }
    this.setState({pageNumber: this.state.pageNumber + 1})
  },

  refreshCurrentComics: function() {
    this.setState({ currentComics: this.currentComics(this.state.allComics, this.page)});
  },

  currentComics: function(comics, page) {
    offset = (page - 1) * this.perPage;
    end = offset + this.perPage;
    return comics.slice(offset, end);
  },

  maxPage: function() {
    return Math.ceil(this.comicLimit / this.perPage);
  },

  decreasePageNumber: function() {
    if(this.state.pageNumber > 1) {
      this.setState({pageNumber: this.state.pageNumber - 1});
    }
  },

  getComics: function() {
    this.setState({ disableButtons: true });
    $.ajax({
      data: {
        set: this.set,
        character: this.state.searchValue
      },
      url: '/comics/fetch',
      type: "GET",
      dataType: "json",
      success: function (comics) {
        this.setState({ allComics: comics, disableButtons: ''});
        this.refreshCurrentComics();
      }.bind(this)
    });
  },

  updateSearchValue: function(event) {
    this.setState({ searchValue: event.target.value });
  }
})
