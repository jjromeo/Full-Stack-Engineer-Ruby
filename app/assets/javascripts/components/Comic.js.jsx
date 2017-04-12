var Comic = React.createClass({
  render: function() {
    return (
      <li className={this.favouriteClass()} onMouseOver={this.mouseOver} onMouseOut={this.mouseOut}>
        <div>
          <div className="front_cover">
            <img src={this.props.image_url} className="box_shadow front_cover"></img>
          </div>
          <HeartImage comic_id={this.props.comic_id} isFavourited={this.state.isFavourited} handleFavouriteClick={this.handleFavouriteClick}/>
          <div className="comic_overlay" style={{display: this.overlayState()}}>
            <span className="overlay_text">
              <div className="title">{this.props.title}</div>
              <div className="further_info">
                { this.props.edition &&
                  <span className="edition">{this.props.edition}</span>
                }
                { this.props.year &&
                  <span className="year">{this.props.year}</span>
                  }
              </div>
            </span>
          </div>
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
    return { isFavourited: this.props.isFavourited, displayOverlay: false };
  },

  favouriteClass: function() {
    return this.state.isFavourited ? 'comic favourited' : 'comic';
  },

  mouseOver: function() {
    this.setState({ displayOverlay: true });
  },

  mouseOut: function() {
    this.setState({ displayOverlay: false });
  },

  overlayState: function() {
    return this.state.displayOverlay ? 'block' : 'none';
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
      }.bind(this),
      error: function() {
        alert("An error occured, you are currently unable to favourite this comic");
      }
    });
  },

  destroyFavourite: function() {
    url = '/favourites/' + this.props.comic_id
    $.ajax({
      url: url,
      type: "DELETE",
      success: function(response) {
        this.setState({ isFavourited: false });
        this.props.handleFavouriteClick(this.props.index, false);
      }.bind(this),
      error: function() {
        alert("An error occured, you are currently unable to unfavourite this comic");
      }
    });
  }
});
