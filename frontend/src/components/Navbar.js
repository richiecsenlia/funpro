import { useNavigate } from 'react-router-dom'

function Navbar(){
	const navigate = useNavigate()
	return(
		<div>
			<button onClick={() => navigate('')}>Lihat Jadwal</button>
			<button onClick={() => navigate('create-jadwal')}>Buat Jadwal</button>
			<button onClick={() => navigate('allExpense')}>Lihat Pengeluaran</button>
			<button onClick={() => navigate('register')}>Register</button>
			<button onClick={() => navigate('login')}>Login</button>
		</div>
	)
}

export default Navbar