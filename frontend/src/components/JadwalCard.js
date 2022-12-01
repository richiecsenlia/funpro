function JadwalCard(props){

    return(
        <div>
            <p>Nama Jadwal: {props.name}</p>
            <p>Tanggal: {props.date}</p>
            <p>Waktu: {props.time}</p>
            <p>Catatan: {props.notes}</p>
        </div>
    )
}
export default JadwalCard