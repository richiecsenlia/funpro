import logo from './logo.svg';
import './App.css';
import { BrowserRouter, Routes, Route } from "react-router-dom";

import Home from "./pages/Home";
import AllExpense from "./pages/AllExpense";
import Contact from "./pages/Contact";
import NoPage from "./pages/NoPage";
import CreateJadwal from './components/CreateJadwal'
import Navbar from './components/Navbar'
import SignupForm from './components/Register'
import LoginForm from './components/Login';
function App() {
  return (
    <BrowserRouter>
      <Navbar/>
      <Routes>
        
          <Route index element={<Home />} />
          <Route path="allExpense" element={<AllExpense />} />
          <Route path="contact" element={<Contact />} />
          <Route path="create-jadwal" element={<CreateJadwal />}/>
          <Route path="register" element={<SignupForm />}/>
          <Route path="login" element={<LoginForm />}/>
          <Route path="*" element={<NoPage />} />
          
        
      </Routes>
    </BrowserRouter>
  );
}

export default App