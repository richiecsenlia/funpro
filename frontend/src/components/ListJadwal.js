import { useState, useEffect} from 'react'
import JadwalCard from "./JadwalCard"
import axios from "axios"
import React from 'react'
import { Card, Button} from 'react-bootstrap'

function ListJadwal(){

	const [list, setList] = useState([])

	useEffect(() => {
		axios.get('http://localhost:8000/jadwal')
		.then(res => {
			console.log(res.data)
			setList(res.data)
		})
	}, []);

	const handleDelete = (id) => {
		axios.delete('http://localhost:8000/delete-jadwal/' + id)
		.then(res => {
			console.log(res.data)
			window.location.reload();
		})
	}

	const cards = list.map(item => {
		return(
			<Card key = {item.id_jadwal} style={{ width: '300px' }}>
				<JadwalCard
					id={item.id_jadwal}
					name={item.nama_jadwal}
					date={item.tanggal}
					time={item.waktu}
					notes={item.catatan}
				/>
				<Button onClick={() => handleDelete(item.id_jadwal)}>Delete</Button>
			</Card>
		)
	})

	return(		
		<div style={{ margin: '1rem'}}>
			<p>List Jadwal</p>
			<div>
				{cards}
			</div>
			
		</div>
	)
}

export default ListJadwal