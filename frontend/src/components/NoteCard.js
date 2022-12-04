import Card from 'react-bootstrap/Card'

function NoteCard(props) {

    return (
        <Card.Body>
            <Card.Title style={{ textAlign: 'center', marginBottom: '10px' }}>{props.title}</Card.Title>
            <Card.Text style={{ textAlign: 'center', marginTop: '10px', fontSize: '14px' }}>{props.body}</Card.Text>
        </Card.Body>
    )
}
export default NoteCard