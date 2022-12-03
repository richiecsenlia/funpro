import { useNavigate } from 'react-router-dom'

function Navbar(){
	const navigate = useNavigate()
	
	return(
		<div>
			<button onClick={() => navigate('')}>Home</button>
			<button onClick={() => navigate('list-jadwal')}>Lihat Jadwal</button>
			<button onClick={() => navigate('create-jadwal')}>Buat Jadwal</button>
			<button onClick={() => navigate('all-expense')}>Lihat Pengeluaran</button>
			<button onClick={() => navigate('notes')}>Lihat Note</button>
			<button onClick={() => navigate('create-expense')}>Catat Pengeluaran</button>
			<button onClick={()=> navigate('search-year')}>Search Year</button>
			<button onClick={()=> navigate('search-month')}>Search Month</button>
		</div>
	)
}

export default Navbar