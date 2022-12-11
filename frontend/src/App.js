import React from "react";
import './App.css';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Home from "./pages/Home";
import AllExpense from "./pages/AllExpense";
import Contact from "./pages/Contact";
import NoPage from "./pages/NoPage";
import CreateJadwal from './components/CreateJadwal'
import Navbar from './components/Navbar'
import Notes from "./components/Notes";
import CreateNote from "./components/CreateNote"
import ListJadwal from './components/ListJadwal';
import 'bootstrap/dist/css/bootstrap.min.css';
import CreateExpense from './components/CreateExpense';
import ListExpense from './components/ListExpense';
import Search from './components/Search';
import FilterExpense from './components/FilterExpense';
import SignupForm from './components/Register'
import LoginForm from './components/Login';

export const url = "https://funpro-production.up.railway.app"
export const be2url = "https://funpro-production-28fa.up.railway.app"
// export const url = "http://localhost:8080"
// export const be2url = "http://localhost:8000"

// sumber : https://www.freecodecamp.org/news/state-management-with-react-hooks/
export const AuthContext = React.createContext();
const initialState = {
  isAuthenticated: false,
  username: null,
};

const reducer = (state, action) => {
  switch (action.type) {
    case "LOGIN":
      localStorage.setItem("username",action.payload.username);
      return {
        ...state,
        isAuthenticated: true,
        username: action.payload.username
      };
    case "LOGOUT":
      localStorage.clear();
      return {
        ...state,
        isAuthenticated: false,
        username : null
      };
    default:
      return state;
  }
};
function App() {
  const [state, dispatch] = React.useReducer(reducer, initialState);
  return (
    <AuthContext.Provider
      value={{
        state,
        dispatch
      }}
    >
      <BrowserRouter>
        <Navbar/>
        <Routes>
          
            <Route index element={<Home />} />
            <Route path="all-expense" element={<ListExpense />} />
            <Route path="contact" element={<Contact />} />
            <Route path="create-jadwal" element={<CreateJadwal />}/>
            <Route path="list-jadwal" element={<ListJadwal />}/>
            <Route path="notes" element={<Notes />} />
            <Route path="notes/createnote" element={<CreateNote />} />
            <Route path="create-expense" element={<CreateExpense />}/>
            <Route path= "search-year" element = {<Search
                                                  link="/search-year/"
                                                  title="Search Year"/>}/>
            <Route path= "search-month" element = {<Search
                                                  link="/search-month/"
                                                  title="Search Month"/>}/> 
            <Route path="search-year/:id" element = {<FilterExpense
                                                      link={url+"/filterexpenseyear/"}/>}/>
            <Route path="search-month/:id" element = {<FilterExpense
                                                      link={url+"/filterexpensemonth/"}/>}/>
            {!state.isAuthenticated ? <><Route path="register" element={<SignupForm />} /><Route path="login" element={<LoginForm />} /></>: <></>}
            <Route path="*" element={<NoPage />} />
          
        </Routes>
      </BrowserRouter>
    </AuthContext.Provider>
  );
}

export default App
