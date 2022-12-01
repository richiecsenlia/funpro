import logo from './logo.svg';
import './App.css';
import { BrowserRouter, Routes, Route } from "react-router-dom";

import Navbar from "./components/Navbar";
import Home from "./pages/Home";
import Notes from "./components/Notes";
import CreateNote from "./components/CreateNote"

function App() {
  return (
    <BrowserRouter>
      <Navbar/>
      <Routes>
        
        <Route index element={<Home />} />
        <Route path="notes" element={<Notes />} />
        <Route path="notes/createnote" element={<CreateNote />} />
        
      </Routes>
    </BrowserRouter>
  );
}

export default App;
