import React from 'react';
import { Formik} from 'formik';
import axios from "axios";
import { AuthContext, url } from '../App';
import { useNavigate } from 'react-router-dom';
 const SignupForm = () => {
  const {dispatch} = React.useContext(AuthContext);
  const navigate = useNavigate()
  return (
     <Formik
     initialValues={{ username: '', email :'',password: '' }}
     onSubmit= {async (values,actions) => {
      console.log("Values: ", values);
      try {
        const response = await axios.post(
          url+"/user",
          values
        );
        actions.setSubmitting(false);
        dispatch({
          type: "LOGIN",
          payload: response.data[0]
        })
        navigate('/')
      } catch (err) {
        console.log("Error: ", err);
        actions.setStatus(err.message)
        actions.setSubmitting(false);
      }
    }}>
      {formik => (
          <form onSubmit={formik.handleSubmit}>
          {formik.status && <div id="feedback">Error : {formik.status}</div>}
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
            <button type="submit" disabled={formik.isSubmitting}>
              {formik.isSubmitting ? (
                "Loading..."
              ) : (
                "Register"
              )}
            </button>
          </form>)
        }
     </Formik>
   );
 };

 export default SignupForm;