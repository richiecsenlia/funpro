import logo from './logo.svg';
import './App.css';
import { BrowserRouter, Routes, Route } from "react-router-dom";

import Home from "./pages/Home";
import AllExpense from "./pages/AllExpense";
import Contact from "./pages/Contact";
import NoPage from "./pages/NoPage";
import CreateJadwal from './components/CreateJadwal'
import Navbar from './components/Navbar'
import ListJadwal from './components/ListJadwal';

function App() {
  return (
    <BrowserRouter>
      <Navbar/>
      <Routes>
        
          <Route index element={<Home />} />
          <Route path="allExpense" element={<AllExpense />} />
          <Route path="contact" element={<Contact />} />
          <Route path="create-jadwal" element={<CreateJadwal />}/>
          <Route path="list-jadwal" element={<ListJadwal />}/>
          <Route path="*" element={<NoPage />} />
          
        
      </Routes>
    </BrowserRouter>
  );
}

export default App