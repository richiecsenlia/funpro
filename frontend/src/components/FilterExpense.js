import { useState, useEffect} from 'react'
import ExpenseCard from "./ExpenseCard"
import axios from "axios"
import React from 'react'
import { Card, Button} from 'react-bootstrap'
import {useParams} from 'react-router-dom'

function FilterExpense(props){
	const {id} = useParams()
	const [list, setList] = useState([])
    // const [val, setVal] = useState(0)
    // const [tmp,setTmp] = useState(0)
	useEffect(() => {
		console.log(props.link)
		const username = localStorage.getItem("username")
		if(username == null){
			return
		}
		axios.get(props.link+id+"/"+username)
		.then(res => {
			console.log(res.data)
			setList(res.data)
		})
	
	}, []);
    
    
	// function handle(e){
    //     console.log(e.target.value)
	// 	setTmp(e.target.value)
	// }
    // function search(){
    //     console.log(tmp)
    //     setVal(tmp);
    // }    

	const cards = list.map((item,index) => {
		return(
			<Card key={index} style={{ width: '300px' }}>
				<ExpenseCard
					usage={item.expenseUsage}
					date={item.expenseDate}
					total={item.expenseTotal}
				/>
				
			</Card>
		)
	})
	if(list.length == 0){
		return <p> Belum ada pengeluaran </p>
	}
	return(		
		<div style={{ margin: '1rem', width: "20rem" }}>
			<p>List Jadwal</p>
			<div>
				{cards}
			</div>
		</div>
	)
}

export default FilterExpense