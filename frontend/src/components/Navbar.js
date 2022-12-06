import { useNavigate } from 'react-router-dom'

function Navbar(){
	const navigate = useNavigate()
	
	let loggedIn;
	if (localStorage.getItem('username')===null){
		loggedIn = <button onClick={() => navigate('login')}>Login</button>
	} else {
		loggedIn = <button onClick={Logout}>Logout</button>
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

function Logout(){
	localStorage.removeItem('username')
	window.location.reload(false)
}
export default Navbar