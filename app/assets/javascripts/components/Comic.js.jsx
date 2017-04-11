var Comic = React.createClass({
  render: function() {
    return (
      <li className="comic">
        <div>
          <img src={this.props.image_url}></img>
          <HeartImage comic_id={this.props.comic_id} isFavourited={this.state.isFavourited} handleFavouriteClick={this.handleFavouriteClick}/>
        </div>
      </li>
    )
  },

  handleFavouriteClick: function() {
    if(this.state.isFavourited) {
      this.destroyFavourite();
    } else {
      this.createFavourite();
    }
  },

  getInitialState: function() {
    return { isFavourited: this.props.isFavourited };
  },

  createFavourite: function() {
    $.ajax({
      data: {
        comic_id: this.props.comic_id
        },
      url: '/favourites',
      type: 'POST',
      success: function(response) {
        this.setState({ isFavourited: true });
        this.props.handleFavouriteClick(this.props.index, true);
      }.bind(this)
    })
  },

  destroyFavourite: function() {
    url = '/favourites/' + this.props.comic_id
    $.ajax({
      url: url,
      type: "DELETE",
      success: function(response) {
        this.setState({ isFavourited: false })
        this.props.handleFavouriteClick(this.props.index, false);
      }.bind(this)
    })
  }
});
