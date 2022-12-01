import { useState } from 'react'
import Axios from 'axios'

function CreateNote() {
    const url = "http://localhost:8080/notes/create"

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

    }

    function handle(e) {
        const newData = { ...data }
        newData[e.target.id] = e.target.value
        setData(newData)
        console.log(newData)
    }

    return (
        <div>
            <p>Create Note</p>
            <form onSubmit={(e) => submit(e)}>
                <label>
                    Judul Note :
                    <input onChange={(e) => handle(e)} type="text" id="title"></input>
                </label>
                <label>
                    Isi Note :
                    <input onChange={(e) => handle(e)} type="text" id="body"></input>
                </label>
                <button>Submit</button>
            </form>
        </div>
    )
}

export default CreateNote