import { useState } from 'react'
import Axios from 'axios'
import { Form, Button, Card } from 'react-bootstrap';

function CreateJadwal(){
	const url ="https://funpro-production-28fa.up.railway.app/jadwal"

	const [data, setData] = useState({
		name: "",
		date: "",
		time: "",
		notes: "",
	})

	function submit(e){
		e.preventDefault()
		console.log(data)
		Axios.post(url,{
			catatan: data.notes,
			id_jadwal: 1,	// do not touch
			nama_jadwal: data.name,
			tanggal: data.date,
			waktu: data.time	
		})
		.catch(function (err){
			alert("Error occurs!")
		})
		.then(res => {
			console.log(res.data)
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
						<Form.Label>Nama Jadwal :</Form.Label>
						<Form.Control onChange={(e) => handle(e)} type="text" id="name" autoComplete="off" maxLength="10"/>
					</Form.Group>

					<Form.Group style={{ width: "100%" }}>
						<Form.Label>Tanggal :</Form.Label>
						<Form.Control style={{ textAlign: 'center'}} onChange={(e) => handle(e)} type="date" id="date"/>
					</Form.Group>

					<Form.Group style={{ width: "100%" }}>
						<Form.Label>Waktu :</Form.Label>
						<Form.Control style={{ textAlign: 'center'}} onChange={(e) => handle(e)} type="time" id="time"/>
					</Form.Group>

					<Form.Group style={{ width: "100%" }}>
						<Form.Label>Catatan :</Form.Label>
						<Form.Control onChange={(e) => handle(e)} as="textarea" id="notes" autoComplete="off" maxLength="50" rows={6}/>
					</Form.Group>
					<Button type="submit" style={{ margin: 'auto'}}>Submit</Button>
				</Form>
			</Card>
			
		</div>
	)
}

export default CreateJadwal