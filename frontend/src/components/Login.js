import React, { useState }  from 'react';
import { useFormik } from 'formik';
import axios, { AxiosError } from "axios";
 
 const LoginForm = () => {
  const formik = useFormik({
     initialValues: {

     },
     onSubmit: async (values) => {
        console.log("Values: ", values);
    
        try {
          const response = await axios.get(
            "http://localhost:8000/user",
            {params :{
              username: values.username,
              password: values.password
            }}
          );

        localStorage.setItem('username', response.data[0].username);
        window.location.reload(false)
        } catch (err) {
          console.log("Error: ", err);
          alert(err)
        }
      },
   });
   return (
     <form onSubmit={formik.handleSubmit}>
       <label htmlFor="username">Username</label>
       <input
         id="username"
         name="username"
         type="username"
         onChange={formik.handleChange}
         value={formik.values.username}
       />
       <label htmlFor="password">Password</label>
       <input
         id="password"
         name="password"
         type="password"
         onChange={formik.handleChange}
         value={formik.values.password}
       />
       <button type="submit">Submit</button>
     </form>
   );
 };

 export default LoginForm;