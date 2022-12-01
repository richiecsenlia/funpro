import { useState } from 'react'
import Axios from 'axios'

function CreateJadwal(){
	const url ="http://localhost:8000/jadwal"

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
		<div>
			<p>Create Jadwal</p>
			<form onSubmit={(e) => submit(e)}>
				<label>
					Nama Jadwal :
					<input onChange={(e) => handle(e)} type="text" id="name" autoComplete="off" maxLength="10"></input>
				</label>
				<label>
					Tanggal : 
					<input onChange={(e) => handle(e)} type="date" id="date"></input>
				</label>
				<label>
					Waktu : 
					<input onChange={(e) => handle(e)} type="time" id="time"></input>
				</label>
				<label>
					Catatan : 
					<input onChange={(e) => handle(e)} type="text" id="notes" autoComplete="off" maxLength="50"></input>
				</label>
				<button>Submit</button>	
			</form>
		</div>
	)
}

export default CreateJadwal