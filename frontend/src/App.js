import { Route, Routes } from 'react-router-dom'
import Navbar from './components/Navbar'
import Home from './components/Home'
import CreateJadwal from './components/CreateJadwal'

function App() {
  return (
    <div>
      <Navbar/>
      <Routes>
        <Route path="/" element={<Home />}/>
        <Route path="/create-jadwal" element={<CreateJadwal />}/>
      </Routes>
    </div>
  )
}

export default App