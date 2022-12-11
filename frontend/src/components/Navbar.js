import React from 'react';
import { useNavigate } from 'react-router-dom';
import { AuthContext } from '../App';


function Navbar(){
	const {state: authState, dispatch } = React.useContext(AuthContext);
	const navigate = useNavigate()
	const loggedOut = <><button onClick={() => navigate('login')}>Login</button><button onClick={() => navigate('register')}>Register</button></>
	const loggedIn = <button onClick={() =>
	 dispatch({
		type:"LOGOUT"
	 })
	}>Logout</button>
	
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
			{authState.isAuthenticated? loggedIn : loggedOut}
		</div>
	)
}
export default Navbar