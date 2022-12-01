import { useState } from 'react'
import JadwalCard from "./JadwalCard"
import axios from "axios"
import { useEffect } from "react"

function ListJadwal(){

	const [list, setList] = useState([])

	useEffect(() => {
		axios.get('http://localhost:8000/jadwal')
		.then(res => {
			console.log(res.data)
			setList(res.data)
		})
	}, []);

	const cards = list.map(item => {
		return(
			<JadwalCard
				id={item.id_jadwal}
				name={item.nama_jadwal}
				date={item.tanggal}
				time={item.waktu}
				notes={item.catatan}
			/>
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