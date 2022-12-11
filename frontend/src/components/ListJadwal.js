import { useState, useEffect} from 'react'
import JadwalCard from "./JadwalCard"
import axios from "axios"
import React from 'react'
import { Card, Button} from 'react-bootstrap'
import { useNavigate } from 'react-router-dom'

function ListJadwal(){

	const navigate = useNavigate()
	const [list, setList] = useState([])
	const [feedback, setFeedback] = useState(false)

	useEffect(() => {
		axios.get('https://funpro-production-28fa.up.railway.app/jadwal/' + localStorage.getItem('username'))
		.then(res => {
			console.log(res.data)
			setList(res.data)
			setFeedback(false)
		})
	}, []);

	const handleDelete = (id) => {
		axios.delete('https://funpro-production-28fa.up.railway.app/delete-jadwal/' + id)
		.then(res => {
			console.log(res.data)
			setFeedback(true)
			sleep(1000)
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

	const sleep = ms => new Promise(
		resolve => setTimeout(resolve, ms)
	  );

	if(localStorage.getItem('username') === null){
		return(
		<div style={{ margin: '1rem'}}>
			<p>Login Required</p>
		</div>
		)
	}

	if(list.length == 0){
		return(
		<div style={{ margin: '1rem'}}>
			<p>Belum Ada Jadwal</p>
		</div>
		)
	}

	return(		
		<div style={{ margin: '1rem'}}>
			<div>
				<p>List Jadwal</p>
				{cards}
				{feedback?<p>Delete Success, please reload this page!</p>:""}
			</div>
		</div>
	)
}

export default ListJadwal