import { useNavigate } from 'react-router-dom'

function Navbar(){
	const navigate = useNavigate()
	const logout = localStorage.removeItem('username')
	let loggedIn;
	if (localStorage.getItem('username')===null){
		loggedIn = <button onClick={() => navigate('login')}>Login</button>
	} else {
		loggedIn = <button onClick={logout}>Logout</button>
	}
	return(
		<div>
			<button onClick={() => navigate('')}>Lihat Jadwal</button>
			<button onClick={() => navigate('create-jadwal')}>Buat Jadwal</button>
			<button onClick={() => navigate('allExpense')}>Lihat Pengeluaran</button>
			<button onClick={() => navigate('register')}>Register</button>
			{loggedIn}
		</div>
	)
}

export default Navbar