import { useState, useEffect} from 'react'
import JadwalCard from "./JadwalCard"
import axios from "axios"
import React from 'react';

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
			<div key = {item.id_jadwal}>
				<JadwalCard
					id={item.id_jadwal}
					name={item.nama_jadwal}
					date={item.tanggal}
					time={item.waktu}
					notes={item.catatan}
				/>
				<button onClick={() => handleDelete(item.id_jadwal)}>Delete</button>
			</div>
		)
	})

	return(		
		<div>
			<p>List Jadwal</p>
			{cards}
		</div>
	)
}

export default ListJadwal