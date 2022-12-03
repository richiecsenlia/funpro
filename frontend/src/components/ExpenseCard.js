import Card from 'react-bootstrap/Card'

function ExpenseCard(props){

    return(
        <Card.Body>
            <Card.Title style={{ textAlign: 'center', marginBottom: '10px'}}>{props.usage}</Card.Title>
            <Card.Subtitle style={{ fontSize: '14px', marginBottom: '5px'}}>Tanggal: {props.date}</Card.Subtitle>
            <Card.Text style={{ textAlign: 'center', marginTop: '10px', fontSize: '14px'}}>{props.total}</Card.Text>
        </Card.Body>
    )
}
export default ExpenseCard