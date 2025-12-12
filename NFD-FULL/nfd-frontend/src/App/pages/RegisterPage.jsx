import React from 'react';
export default function RegisterPage(){
  return (
    <div style={{maxWidth:420, margin:'0 auto'}}>
      <h2>Register</h2>
      <form>
        <div style={{marginBottom:8}}>
          <label>Name</label>
          <input style={{width:'100%',padding:8,marginTop:4}} type="text" />
        </div>
        <div style={{marginBottom:8}}>
          <label>Email</label>
          <input style={{width:'100%',padding:8,marginTop:4}} type="email" />
        </div>
        <div style={{marginBottom:8}}>
          <label>Password</label>
          <input style={{width:'100%',padding:8,marginTop:4}} type="password" />
        </div>
        <button type="submit">Create account</button>
      </form>
    </div>
  )
}
