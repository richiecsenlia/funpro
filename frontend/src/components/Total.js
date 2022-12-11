import { useState, useEffect} from 'react'
import axios from "axios"
import React from 'react'
import { Card, Button} from 'react-bootstrap'
import { AuthContext } from '../App';

import {useParams} from 'react-router-dom'
function Total(props){
	const url = "https://funpro-production.up.railway.app"
	// const url = "http://localhost:8080"
    const {year} = useParams()
	const [list, setList] = useState([])
    const {total,setTotal} = useState(0)
	const {state: authState, dispatch } = React.useContext(AuthContext);
    const month = ["Januari","Februari","Maret","April","Mei","Juni","Juli","Agustus","September","Oktober","November","December"]
	useEffect(() => {
		const username = authState.username
		if(username == null){
			return
		}
		axios.get(url+"/expenseinyear/"+year+"/"+username)
		.then(res => {
			console.log(res.data)
			setList(res.data)
            
        axios.post("https://funpro.netlify.app/.netlify/functions/tes",res.data)
        .then((res2)=>{
            setTotal(res2.data)
        })
		})
	}, []);
    

	const cards = list.map((item,idx) => {
		return(
			<Card key = {idx} style={{ width: '300px' }}>
				<Card.Body>

                    <Card.Title style={{ textAlign: 'center', marginBottom: '10px'}}>Pengeluaran bulan {month[idx]}</Card.Title>
                    <Card.Subtitle style={{ fontSize: '14px', marginBottom: '5px'}}>Tanggal: {item}</Card.Subtitle>
                </Card.Body>
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
			<p> total : {total}</p>
		</div>
	)
}

export default Total;