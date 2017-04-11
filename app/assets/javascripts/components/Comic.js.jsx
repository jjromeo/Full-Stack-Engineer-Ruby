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

  handleFavouriteClick: function(isFavourited) {
    this.props.handleFavouriteClick(this.props.index, isFavourited);
  },

  getInitialState: function() {
    return { isFavourited: this.props.isFavourited };
  }
});
