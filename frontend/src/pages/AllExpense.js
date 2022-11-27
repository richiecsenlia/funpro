import {useAsync} from "react-async"

const loadExpense = async({signal}) => {
  const res = await fetch(`https://localhost:8080/expenseall`,{signal,mode :'cors'})
  console.log('Hello!');
  if (!res.ok) throw new Error(res.statusText)
  
  return res.json()
}

const TabelExpense = () =>{
  const {data,error,isPending} = useAsync({ promiseFn: loadExpense})
  if (isPending) return "Loading..."
  if(error) return `something went wrong: ${error.message}`
  if(data)
    return(
      <p>halo</p>
    )
}

const AllExpense = () => {
  return (<div><h1>expenseAll</h1>
  <TabelExpense/></div>)
  };
  
  export default AllExpense;
  