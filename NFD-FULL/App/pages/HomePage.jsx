import React from 'react';
import HomeHeader from '../home/components/HomeHeader.jsx';
import HomeContent from '../home/components/HomeContent.jsx';
import HomeFooter from '../home/components/HomeFooter.jsx';

export default function HomePage(){
  return (
    <div>
      <HomeHeader />
      <HomeContent />
      <HomeFooter />
    </div>
  )
}
