class ClickMixin extends React.Component {

	_clickDocument(e) {
		console.log("Clicked document")
		var component = React.findDOMNode(this.refs.component);
        if (e.target == component || $(component).has(e.target).length) {
            this.clickInside(e);
        } else {
            this.clickOutside(e);
        }
	}

	componentDidMount() {
		$(document).bind('click', this._clickDocument);	
	}

	componentWillUnmount() {
		$(document).unbind('click', this._clickDocument);
	}

	render () {
	}
}