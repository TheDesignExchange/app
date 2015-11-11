// http://localhost:3000/design_methods/1

var Sidebar = {
  DesignMethodSidebar: React.createClass({
    render: function() {
      return (
        <div>
          <Sidebar.Group>
            <Sidebar.Header topLevel={true}>What You'll Need</Sidebar.Header>
          </Sidebar.Group>

          <Sidebar.Group>
            <Sidebar.Header>People</Sidebar.Header>
            <Sidebar.Numeric icon="user" noun="designer" approx={true} />
            <Sidebar.Numeric icon="user" noun="user" approx={false} />
          </Sidebar.Group>

          <Sidebar.Group>
            <Sidebar.Header>Tools</Sidebar.Header>
            <Sidebar.Numeric icon="pencil" />
          </Sidebar.Group>

          <Sidebar.Group>
            <Sidebar.Header>Time</Sidebar.Header>
            <Sidebar.Numeric icon="time" />
          </Sidebar.Group>

          <Sidebar.Group>
            <Sidebar.Header>Tags</Sidebar.Header>
            No tags available
          </Sidebar.Group>

          <Sidebar.Group>
            <Sidebar.Header>Characteristics</Sidebar.Header>
            <Sidebar.Tags>
              <Sidebar.Tag href="/characteristics/10">Purpose: Persuade</Sidebar.Tag>
              <Sidebar.Tag href="/characteristics/9">Purpose: Validate</Sidebar.Tag>
              <Sidebar.Tag href="/characteristics/8">Purpose: Experiment</Sidebar.Tag>
              <Sidebar.Tag href="/characteristics/7">Scope: Horizontal slice</Sidebar.Tag>
              <Sidebar.Tag href="/characteristics/6">Aspect: Behavior</Sidebar.Tag>
              <Sidebar.Tag href="/characteristics/5">Prototyping format: Abstract</Sidebar.Tag>
              <Sidebar.Tag href="/characteristics/4">Product or service: Either</Sidebar.Tag>
              <Sidebar.Tag href="/characteristics/3">Offering format: Digital offering</Sidebar.Tag>
              <Sidebar.Tag href="/characteristics/2">Fidelity: Low</Sidebar.Tag>
              <Sidebar.Tag href="/characteristics/1">Stage of process: Mock-up</Sidebar.Tag>
            </Sidebar.Tags>
          </Sidebar.Group>
        </div>
      );
    }
  }),

  Header: React.createClass({
    propTypes: {
      topLevel: React.PropTypes.bool,
    },
    render: function() {
      if (this.props.topLevel) 
        return <h3>{this.props.children}</h3>;
      else
        return <h4>{this.props.children}</h4>;
    }
  }),

  Group: React.createClass({
    render: function() {
      return <div className="row">{this.props.children}</div>;
    }
  }),

  Numeric: React.createClass({
    propTypes: {
      approx: React.PropTypes.bool,
      icon: React.PropTypes.string,
      noun: React.PropTypes.string,
    },
    render: function() {
      var prefix = this.props.approx ? '~' : '';
      return (
        <p>
          <span className={"glyphicon glyphicon-" + this.props.icon}></span>
          <span> {prefix}1 {this.props.noun}</span>
        </p>
      );
    }
  }),
  Tags: React.createClass({
    render: function() {
      return (
        <p>{this.props.children}</p>
      );
    }
  }),

  Tag: React.createClass({
    propTypes: {
      href: React.PropTypes.string,
    },
    render: function() {
      return (
        <a href={this.props.href}>
          <span className="tag-label label-gap">{this.props.children}</span>{" "}
        </a>
      );
    }
  }),
}


ReactDOM.render(
  <Sidebar.DesignMethodSidebar />,
  document.getElementById('sidebar-react')
);
