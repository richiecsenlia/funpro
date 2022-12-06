import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { Card, Button } from 'react-bootstrap'
import axios from 'axios'
import React from 'react'
import NoteCard from './NoteCard'

const Notes = () => {
    const url = "https://funpro-production.up.railway.app/notes"

    const navigate = useNavigate()
    const [notes, setNotes] = useState([]);

    const fetch = () => {
        axios
            .get(url + "/getall")
            .then((response) => setNotes(response.data));
    };

    useEffect(() => {
        fetch();
    }, [notes]);

    const handleDelete = (id) => {
        axios.delete(url + "/delete/" + id)
            .then(res => {
                console.log(res.data)
            })
    }

    const cards = notes.filter(note => note.noteOwner === localStorage.getItem('username')).map(note => {
        return (
            <Card key={note.id} style={{ width: '300px', margin: '2rem 0'}}>
                <NoteCard
                    title={note.noteTitle}
                    body={note.noteBody}
                />
                <Button onClick={() => handleDelete(note.id)}>Delete</Button>
            </Card>
        )
    })

    return (
        <div style={{ margin: '1rem'}}>
            <h1>Note List</h1>
            {localStorage.getItem('username') === null ? 
            <p>Login Required</p>
            :
            <div>
                <button onClick={() => navigate('createnote')}>Create note</button>
                <div>
                    {cards}
                </div>
            </div>
            }          
		</div>
    );
}

export default Notes;