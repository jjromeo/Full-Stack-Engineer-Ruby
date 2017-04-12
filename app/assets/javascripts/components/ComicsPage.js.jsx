var ComicsPage = React.createClass({
  perPage: 15,
  comicLimit: 30,
  page: 1,
  set: 1,

  render: function() {
    return(
      <div>
        <div id="search_header" className="box_shadow">
          <img src="/assets/marvel_logo.png"/>
          <input type="text" value={this.state.searchValue} onKeyPress={this.handleKeyPress} onChange={this.updateSearchValue} placeholder="Search for marvel characters or teams..." autoFocus></input>
        </div>
        { this.state.allComics.length > 0 ?
          <Comics comics={this.state.currentComics} handleFavouriteClick={this.handleFavouriteClick}/>
          :
          <div id="no_comics">
            <h2>Sorry, no comics were found</h2>
          </div>
        }
        <p id="current_page_text">Current page: {this.state.pageNumber}</p>
        <button className="pagination_button left box_shadow" disabled={this.state.disableButtons} onClick={this.previousPage}>PREVIOUS PAGE</button>
        <button className="pagination_button right box_shadow" disabled={this.state.disableButtons} onClick={this.nextPage}>NEXT PAGE</button>
      </div>
    )
  },

  getInitialState: function() {
    return { allComics: this.indexComics(this.props.comics), currentComics: this.currentComics(this.props.comics, this.page), images: this.props.images, pageNumber: 1, disableButtons: '' };
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
    this.setState({ pageNumber: this.state.pageNumber + 1 });
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
      this.setState({ pageNumber: this.state.pageNumber - 1 });
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
        var indexedComics = this.indexComics(comics);
        this.setState({ allComics: indexedComics, disableButtons: ''});
        this.refreshCurrentComics();
      }.bind(this)
    });
  },

  indexComics: function(comics) {
    var indexedComics = comics.map(function(comic, index){
      comic.index = index;
      return comic;
    })
    return indexedComics;
  },

  updateSearchValue: function(event) {
    this.setState({ searchValue: event.target.value });
  },

  handleFavouriteClick(comicIndex, isFavourited) {
    var comic = this.state.allComics[comicIndex];
    comic.isFavourited = isFavourited;
  },

  handleKeyPress: function(event) {
    if(event.key == 'Enter') {
      this.page = 1;
      this.set = 1;
      this.setState({ pageNumber: 1 })
      this.getComics();
    }
  }
})
