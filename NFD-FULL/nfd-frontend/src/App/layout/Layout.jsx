import React from 'react';
import { Link, Outlet, useLocation } from 'react-router-dom';
import '../styles/global.css';

export default function Layout(){
  const loc = useLocation();
  return (
    <div className="app-shell">
      <header className="header">
        <div className="brand">NFD</div>
        <nav className="nav">
          <Link to="/" className={loc.pathname==='/'? 'active' : ''}>Home</Link>
          <Link to="/about" className={loc.pathname==='/about'? 'active' : ''}>About</Link>
          <Link to="/login" className={loc.pathname==='/login'? 'active' : ''}>Login</Link>
        </nav>
      </header>
      <main className="main">
        <Outlet />
      </main>
      <footer className="footer">© {new Date().getFullYear()} NFD — Demo frontend</footer>
    </div>
  )
}
