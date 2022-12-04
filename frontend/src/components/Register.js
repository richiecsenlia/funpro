import React from 'react';
import { useFormik } from 'formik';
import axios from "axios";
 
 const SignupForm = () => {
   const formik = useFormik({
     initialValues: {
       username: 'Enter your username here (max 20 characters)',
       email: 'Enter your email here',
     },
     onSubmit: async (values) => {
      console.log("Values: ", values);
  
      try {
        const response = await axios.post(
          "http://localhost:8000/user",
          values
        );
      localStorage.setItem('username',response.data[0].username)
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
       <label htmlFor="email">Email Address</label>
       <input
         id="email"
         name="email"
         type="email"
         onChange={formik.handleChange}
         value={formik.values.email}
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

 export default SignupForm;