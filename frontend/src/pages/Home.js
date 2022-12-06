const Home = () => {
    let message;
    if (localStorage.getItem('username')===null){
      message = <h1>Hello</h1>
    } else {
      message = <h1>Hello, {localStorage.getItem('username')}</h1>
    }
    return <div>{message}</div>;
};
  
  export default Home;
  