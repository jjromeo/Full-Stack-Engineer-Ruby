var Comic = React.createClass({
  render: function() {
    return (
      <li className="comic">
        <div>
          <img src={this.props.image_url}></img>
          <HeartImage />
        </div>
      </li>
    )
  },
});
