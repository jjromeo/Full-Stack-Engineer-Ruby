var Comics = React.createClass({
  render: function() {
    var comics = this.props.comics.map(function(comic) {
      return <li>{comic.title}</li>
    }.bind(this));
    return(
      <div id="comics">
      <ul>
        { comics }
        </ul>
      </div>
    )
  },

  getInitialState: function() {
    return { comics: this.props.comics }
  }
})
