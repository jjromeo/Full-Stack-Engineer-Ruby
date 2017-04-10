var Comic = React.createClass({
  render: function() {
    return (
      <li className="comic">
        <ul>
          <li><img src={this.props.image_url}></img></li>
        </ul>
      </li>
    )
  }
});
