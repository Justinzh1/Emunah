class SubmittalsList extends React.Component {
  constructor(props) {
    super(props)
    window.people = this.props.people
    this.state = { ... props, submittals: this.props.submittals, total_submittals: this.props.submittals }
  }

  handleDelete(id) {
    var submittals = this.state.submittals.filter((submittal) => {
      return !(submittal.id === id);
    })
    this.setState({
      submittals: submittals
    })
  }

  handleKeyPress(event) {
    str = String(event.target.value);
    console.log(str)
    if (str == '') {
      this.setState({
        submittals: this.state.total_submittals
      })
    } else {
      str = str.toLowerCase()
      var submittals = this.state.submittals.filter((submittal) => {
        var title = submittal['title'].toLowerCase().includes(str)
        if (title) {
          return title 
        }
        var notes = submittal['notes'].toLowerCase().includes(str)
        if (notes) {
          return notes
        }

        return submittal['family_name'].toLowerCase().includes(str)
      });
      this.setState({
        submittals: submittals
      });
    }
  }

  render () {
  	submittals = []
  	for (var i=0; i < this.state.submittals.length; i++) {
  		var submittal = this.state.submittals[i]
      console.log(submittal.reviewed)
  		submittals.push(
  			<SubmittalsListRow 
          key={submittal.id} 
          submittal={submittal}
          entry={submittal.updated_at}
          notes={submittal.notes}
          role={this.props.role}
          reviewed={submittal.reviewed}
          is_dash={this.props.is_dash}
          family_name={submittal.family_name}
          family_id={submittal.family_id}
          path={"/families/" + submittal.family_id}
          handleDelete={(id) => this.handleDelete(id)}
          />
  		)
      submittals.push(
        <tr className="row-offset">
          <td className="no-border no-padding" colSpan={4}>
            <div className="well">
              {submittal.notes}
            </div>
          </td> 
        </tr>
      )
  	}

    var recent = (<th> Entry Date </th>)
    var status = (this.props.role == "admin") ? (<th> Status </th>) : null;
    var family = (this.props.is_dash == "true") ? (<th> Family Name </th>) : null;
    var actions = (this.props.role == "admin") ? (<th> Actions </th>) : null;

    return (
    <div>
    <div className="input-group">
        <input 
          type="text" 
          className="form-control" 
          aria-describedby="basic-addon1" 
          onChange={(e) => this.handleKeyPress(e)}
          />
        <br/>
      </div>
    <table className="table">
    	<thead>
    		<tr>
    			<th> Submittal Name </th>
          {recent}
          {status}
          {family}
    			{actions}
    		</tr>
    	</thead>
    	<tbody>
    		{submittals}
    	</tbody>
    </table>
    </div>
    ); 
  }
}

class ActionDropDown extends ClickMixin {

  constructor(props) {
    super(props);
    this.state = { ... props, dropdown: false}
    this.handleDropdown = this.handleDropdown.bind(this)
  }

  handleDropdown() {
    var drop = this.state.dropdown;
    this.setState({
      dropdown: !drop
    })
  }

  _clickDocument(e) {
    console.log("Clicked document")
    this.handleDropdown()
  }

  render() {
    var status = (!this.props.reviewed) ? 
      (<a href={this.props.getStatusLink("approve")} className="btn btn-default margin-bot">Approve</a>) :
      (<a href={this.props.getStatusLink("revoke")} className="btn btn-warning margin-bot">Revoke</a>);

    var dropped = (this.state.dropdown) ? "action-dropdown" : "action-dropdown hidden";

    return (
      <td>
        <button className="btn btn-default no-outline" onClick={this.handleDropdown} > Actions </button>
        <div className={dropped}>
          <a href={this.state.edit} className="btn btn-default margin-bot">Edit</a>
          <br/>
          {status}
          <br/>
          <button className="btn btn-danger margin-bot" onClick={() => this.props.handleDelete()}>Delete</button>
        </div>
      </td>
    )
  }
}

class SubmittalsListRow extends React.Component {

  constructor(props) {
    super(props)
    var entry = this.props.entry
    var family_name = this.props.family_name
    var edit = this.props.path + "/submittals/" + this.props.submittal.id + "/edit"
    var del = this.props.path + "/submittals/" + this.props.submittal.id
    var show = this.props.path + "/submittals/" + this.props.submittal.id
    this.state = {
      entry: entry,
      family_name: family_name,
      edit: edit,
      show: show,
      delete: del,
      expanded: false,
      dropdown: false
    }
  }

  handleDelete() {
    var token = document.getElementsByName("csrf-token")[0].content;
    if (this.state.delete != null) {
      fetch(this.state.delete, {
        method: 'DELETE',
        headers: {
          'X-CSRF-TOKEN': token
        },
        credentials: 'same-origin'
      })
    }
    this.props.handleDelete(this.props.submittal.id)
  }


  printDate(date) {
    return date.split(' ').slice(0,5).join(' ')
  }

  getStatusLink(endpoint) {
    return "/families/" + this.props.family_id + "/submittals/" + this.props.submittal.id + "/" + endpoint;
  }

  handleDropdown() {
    var drop = this.state.dropdown;
    this.setState({
      dropdown: !drop
    })
  }

	render () {
    var name = (<a href={this.state.show}> {this.props.submittal.title}  </a>);
    var recent = 
      (<td className="blue-highlight">
        {this.printDate(Date(this.state.entry))}
        </td>
      );
    var family = (this.props.is_dash == "true") ?
     (<td>
        <a href={this.props.path} className="btn btn-info">{this.state.family_name}</a>
       </td>
      ) : null;
    var status = (!this.props.reviewed) ? 
      (<a href={this.getStatusLink("approve")} className="btn btn-default margin-bot">Approve</a>) :
      (<a href={this.getStatusLink("revoke")} className="btn btn-warning margin-bot">Revoke</a>);

    var dropped = (this.state.dropdown) ? "action-dropdown" : "action-dropdown hidden";

    var actions = (this.props.role == "admin") ? 
      (<td>
        <button className="btn btn-default no-outline" onClick={() => this.handleDropdown()} > Actions </button>
        <div className={dropped}>
          <a href={this.state.edit} className="btn btn-default margin-bot">Edit</a>
          <br/>
          {status} 
          <br/>
          <button className="btn btn-danger margin-bot" onClick={() => this.handleDelete()}>Delete</button>
        </div>
       </td>
      ) : null;
    var status = (this.props.role == "admin") ?
      (<td>
        <p> {(this.props.reviewed) ? "approved" : "pending"} </p>
      </td>
      ) : null;

		return (
			<tr rowSpan={2}>
				<th scope="row">{name}</th>
        {recent}
        {status}
        {family}
        <ActionDropDown 
          getStatusLink={(e) => this.getStatusLink(e)}
          path={this.props.path}
          role={this.props.role}
          edit={this.state.edit}
          handleDelete={() => this.handleDelete()}
          />
			</tr>
		)
	}
}
