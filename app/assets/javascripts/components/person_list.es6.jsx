class PeopleList extends React.Component {
  constructor(props) {
    super(props)
    this.state = { ... props }
  }

  handleDelete(id) {
    console.log("Delete " + id)
    var people = this.state.people.filter((person) => {
      return !(person.id === id);
    })
    this.setState({
      people: people
    })
  }

  render () {
  	people = []
  	for (var i=0; i < this.state.people.length; i++) {
  		var person = this.state.people[i]
  		people.push(
  			<PeopleListRow 
          key={person.id} 
          person={person} 
          handleDelete={(id) => this.handleDelete(id)}
          />
  		);
  	}
    return (
    <table className="table">
    	<thead>
    		<tr>
    			<th> Person Name </th>
    			<th> Actions </th>
    		</tr>
    	</thead>
    	<tbody>
    		{people}
    	</tbody>
    </table>
    ); 
  }
}

class PeopleListRow extends React.Component {

  constructor(props) {
    super(props)
    var edit = "people/" + this.props.person.id + "/edit"
    var del = "people/" + this.props.person.id
    this.state = {
      edit: edit,
      delete: del
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
    this.props.handleDelete(this.props.person.id)
  }

	render () {
    var show = "/person/" + this.props.person.id
    var edit = "/person/" + this.props.person.id + "/edit";
		return (
			<tr>
				<th scope="row">{this.props.person.full_name}</th>
				<td>
          <a href={show} className="btn btn-default">Show</a>
          <a href={edit} className="btn btn-default">Edit</a>
          <button className="btn btn-danger" onClick={() => this.handleDelete()}>Delete</button>
        </td>
			</tr>
		)
	}
}
