import { useState, useEffect} from 'react'
import ExpenseCard from "./ExpenseCard"
import axios from "axios"
import React from 'react'
import { Card, Button} from 'react-bootstrap'

function ListJadwal(props){
	// const url = "https://funpro-production.up.railway.app"
	const url = "http://localhost:8080"
	const [list, setList] = useState([])
	useEffect(() => {
		const username = localStorage.getItem("username")
		if(username == null){
			return
		}
		axios.get(url+"/expenseall/"+username)
		.then(res => {
			console.log(res.data)
			setList(res.data)
		})
	}, []);
    
    
	const handleDelete = (id) => {
		axios.delete(url+"/delete/" + id)
		.then(res => {
			console.log(res.data)
			window.location.reload();
		})
	}

	const cards = list.map(item => {
		return(
			<Card key = {item.id} style={{ width: '300px' }}>
				<ExpenseCard
					usage={item.expenseUsage}
					date={item.expenseDate}
					total={item.expenseTotal}
				/>
				<Button onClick={() => handleDelete(item.id)}>Delete</Button>
			</Card>
		)
	})
	if(list.length == 0){
		return <p>Belum Ada Pengeluaran</p>
	}
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