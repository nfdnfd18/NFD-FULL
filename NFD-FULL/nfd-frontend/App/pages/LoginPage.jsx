import React from 'react';
export default function LoginPage(){
  return (
    <div style={{maxWidth:420, margin:'0 auto'}}>
      <h2>Login</h2>
      <form>
        <div style={{marginBottom:8}}>
          <label>Email</label>
          <input style={{width:'100%',padding:8,marginTop:4}} type="email" />
        </div>
        <div style={{marginBottom:8}}>
          <label>Password</label>
          <input style={{width:'100%',padding:8,marginTop:4}} type="password" />
        </div>
        <button type="submit">Sign in</button>
      </form>
    </div>
  )
}
