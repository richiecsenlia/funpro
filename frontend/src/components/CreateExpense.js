import { useState,React } from 'react'
import Axios from 'axios'
import { Form, Button, Card } from 'react-bootstrap';
import { AuthContext } from '../App';

function CreateExpense(){
	// const url ="http://localhost:8080/expense/"
	const url = "https://funpro-production.up.railway.app/expense/"
	const {state: authState, dispatch } = React.useContext(AuthContext);
    
	const [data, setData] = useState({
		total: 0,
		usage: "",
		date: "",
		
	})

	function submit(e){
		e.preventDefault()
		console.log(data)
		const username = authState.username
		if(username == null){
			return
		}
		Axios.post(url,{
			expenseTotal: parseInt(data.total),
			expenseUsage: data.usage,
			expenseDate: data.date,
			expenseUsername : username
		})
		.catch(function (err){
			alert("Error occurs!")
		})
		.then(res => {
			console.log(res.data)
			alert("Berhasil disimpan")
		})
		
	}

	function handle(e){
		const newData = {...data}
		newData[e.target.id] = e.target.value
		setData(newData)
		console.log(newData)
	}

	return(
		<div style={{ margin: '1rem', width: "20rem" }}>
			<p>Create Jadwal</p>
			<Card>
				<Form style={{ margin: "10px" }} onSubmit={(e) => submit(e)}>
					<Form.Group style={{ width: "100%" }}>
						<Form.Label>Usage :</Form.Label>
						<Form.Control onChange={(e) => handle(e)} type="text" id="usage" autoComplete="off" maxLength="10"/>
					</Form.Group>

					<Form.Group style={{ width: "100%" }}>
						<Form.Label>Tanggal :</Form.Label>
						<Form.Control style={{ textAlign: 'center'}} onChange={(e) => handle(e)} type="date" id="date"/>
					</Form.Group>

					<Form.Group style={{ width: "100%" }}>
						<Form.Label>Total :</Form.Label>
						<Form.Control style={{ textAlign: 'center'}} onChange={(e) => handle(e)} type="number" id="total"/>
					</Form.Group>

					<Button type="submit" style={{ margin: 'auto'}}>Submit</Button>
				</Form>
			</Card>
			
		</div>
	)
}

export default CreateExpense