import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom'
import axios from 'axios';

const Notes = () => {
    const navigate = useNavigate()
    const [notes, setNotes] = useState([]);

    const fetch = () => {
        axios
            .get("http://localhost:8080/notes/getall")
            .then((response) => setNotes(response.data));
    };

    useEffect(() => {
        fetch();
    }, []);

    return (
        <div>
            <h1>Note List</h1>
            <ul>
                {
                    notes.length > 0 && notes.map((note) =>
                        <li>
                            <div>
                                <p><b>{note.noteTitle}</b></p>
                                <p>{note.noteBody}</p>
                            </div>
                        </li>
                    )
                }
            </ul>
            <button onClick={() => navigate('createnote')}>Create note</button>
        </div>
    );
}

export default Notes;