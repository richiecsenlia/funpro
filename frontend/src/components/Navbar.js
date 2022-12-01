import { useNavigate } from 'react-router-dom'

function Navbar(){
	const navigate = useNavigate()
	return(
		<div>
			<button onClick={() => navigate('notes')}>Lihat Note</button>
		</div>
	)
}

export default Navbar