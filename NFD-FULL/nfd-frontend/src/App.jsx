import React from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Layout from './App/layout/Layout.jsx';
import HomePage from './App/pages/HomePage.jsx';
import AboutPage from './App/pages/AboutPage.jsx';
import LoginPage from './App/pages/LoginPage.jsx';
import RegisterPage from './App/pages/RegisterPage.jsx';

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<HomePage />} />
          <Route path="about" element={<AboutPage />} />
          <Route path="login" element={<LoginPage />} />
          <Route path="register" element={<RegisterPage />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}
