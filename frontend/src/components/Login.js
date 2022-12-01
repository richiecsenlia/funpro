import React from 'react';
import { useFormik } from 'formik';
import axios, { AxiosError } from "axios";
 
 const LoginForm = () => {
   const formik = useFormik({
     initialValues: {

     },
     onSubmit: async (values) => {
        console.log("Values: ", values);
    
        try {
          const response = await axios.post(
            "http://localhost:9000/api/v1/login",
            values
          );
    
        } catch (err) {
          console.log("Error: ", err);
        }
      },
   });
   return (
     <form onSubmit={formik.handleSubmit}>
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

 export default LoginForm;