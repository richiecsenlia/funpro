import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import Axios from 'axios'
import { Form, Button, Card } from 'react-bootstrap'

function CreateNote() {
    const url = "https://funpro-production.up.railway.app/notes/create"

    const navigate = useNavigate()
    const [data, setData] = useState({
        title: "",
        body: "",
    })

    function submit(e) {
        e.preventDefault()
        console.log(data)
        Axios.post(url, {
            noteTitle: data.title,
            noteBody: data.body,
        })
            .catch(function (err) {
                alert(err)
            })
            .then(res => {
                console.log(res.data)
        })
        navigate(-1)
    }

    function handle(e) {
        const newData = { ...data }
        newData[e.target.id] = e.target.value
        setData(newData)
        console.log(newData)
    }

    return (
        <div style={{ margin: '1rem', width: "20rem" }}>
			<p>Create Note</p>
			<Card>
				<Form style={{ margin: "10px" }} onSubmit={(e) => submit(e)}>
                    <Form.Group style={{ width: "100%" }}>
                        <Form.Label>Judul Note :</Form.Label>
                        <Form.Control onChange={(e) => handle(e)} type="text" id="title" autoComplete="off" maxLength="10" />
                    </Form.Group>
                    <Form.Group style={{ width: "100%" }}>
                        <Form.Label>Isi Note :</Form.Label>
                        <Form.Control onChange={(e) => handle(e)} as="textarea" id="body" autoComplete="off" maxLength="50" rows={6} />
                    </Form.Group>
					<Button type="submit" style={{ margin: 'auto'}}>Submit</Button>
				</Form>
			</Card>
			
		</div>
    )
}

export default CreateNote