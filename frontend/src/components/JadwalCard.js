import Card from 'react-bootstrap/Card'

function JadwalCard(props){

    return(
        <Card.Body>
            <Card.Title style={{ textAlign: 'center', marginBottom: '10px'}}>{props.name}</Card.Title>
            <Card.Subtitle style={{ fontSize: '14px', marginBottom: '5px'}}>Tanggal: {props.date}</Card.Subtitle>
            <Card.Subtitle style={{ fontSize: '14px'}}>Pukul: {props.time}</Card.Subtitle>
            <Card.Text style={{ textAlign: 'center', marginTop: '10px', fontSize: '14px'}}>{props.notes}</Card.Text>
        </Card.Body>
    )
}
export default JadwalCard