var ComicsPage = React.createClass({
  perPage: 15,
  comicLimit: 100,
  page: 1,

  render: function() {
    return(
      <div>
        <Comics comics={this.state.comics}/>
        <button onClick={this.previousPage}>Previous Page</button>
        <button onClick={this.nextPage}>Next page</button>
      </div>
    )
  },

  getInitialState: function() {
    return { comics: this.currentComics(this.page) };
  },

  previousPage: function() {
    if(this.page > 1) {
      this.page--
      this.setState({ comics: this.currentComics(this.page)})
    }
  },

  nextPage: function() {
    if(this.page < (this.comicLimit / this.perPage)) {
      this.page++
      this.setState({ comics: this.currentComics(this.page)})
    }
  },

  currentComics: function(page) {
    offset = (page - 1) * this.perPage;
    end = offset + this.perPage;
    return this.props.comics.slice(offset, end);
  }
})
