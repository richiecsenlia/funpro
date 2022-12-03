import { useState, useEffect} from 'react'

import React from 'react'
import { Form,Card, Button} from 'react-bootstrap'
import { useNavigate } from 'react-router-dom'

function Search(props){
	const navigate = useNavigate()
    const [tmp,setTmp] = useState(0)

	useEffect(() => {
        console.log("reload")
	}, []);
    
    
	function handle(e){
        console.log(e.target.value)
		setTmp(e.target.value)
	}
    function search(){
		navigate(props.link+tmp)
    }    

	return(		
		<div style={{ margin: '1rem', width: "20rem" }}>
			<p>{props.title}</p>
			<Card>
				<Form style={{ margin: "10px" }} onChange={(e) => handle(e)}>
					<Form.Group style={{ width: "100%" }}>
						<Form.Label>Year :</Form.Label>
						<Form.Control type="text" id="year" autoComplete="off" maxLength="10"/>
					</Form.Group>

					<Button onClick={()=> search()} style={{ margin: 'auto'}}>Submit</Button>
				</Form>
			</Card>
			
		</div>
	)
}

export default Search