var Comics = React.createClass({
  render: function() {
    var comics = this.props.comics.map(function(comic) {
      return <Comic key={comic.id} title={comic.title} image_url={comic.imageUrl} comic_id={comic.id} isFavourited={comic.isFavourited} handleFavouriteClick={this.props.handleFavouriteClick} index={comic.index}/>
    }.bind(this));
    return(
      <div id="comics">
        <ul>
        { comics }
        </ul>
      </div>
    )
  },
})
