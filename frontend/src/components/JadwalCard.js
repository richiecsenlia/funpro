import axios from "axios"

function JadwalCard(props){
    function handleDelete(id){
		axios.delete('http://localhost:8000/delete-jadwal/' + id).then(res => {
            console.log("delete " + id)
        })
	}
    return(
        <div>
            <p>Nama Jadwal: {props.name}</p>
            <p>Tanggal: {props.date}</p>
            <p>Waktu: {props.time}</p>
            <p>Catatan: {props.notes}</p>
            <button onClick={handleDelete(props.id)}>Delete</button>
        </div>
    )
}
export default JadwalCard