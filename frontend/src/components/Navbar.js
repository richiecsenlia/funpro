import { useNavigate } from 'react-router-dom'

function Navbar(){
	const navigate = useNavigate()
	return(
		<div>
			<button onClick={() => navigate('')}>Lihat Jadwal</button>
			<button onClick={() => navigate('create-jadwal')}>Buat Jadwal</button>
			<button onClick={() => navigate('allExpense')}>Lihat Pengeluaran</button>
		</div>
	)
}

export default Navbar