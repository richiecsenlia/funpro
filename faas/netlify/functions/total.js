const querystring = require("querystring");

exports.handler = async (event, context) => {
  // Only allow POST

  // When the method is POST, the name will no longer be in the event’s
  // queryStringParameters – it’ll be in the event body encoded as a query string
  
  const list = JSON.parse(event.body) || []
  console.log(list)
  console.log(event.body)
  var total = 0;
  if(list.length != 0){
    list.map((item)=>{
        total =total + item;
    })
  }

  return {
    headers: {
        "Access-Control-Allow-Origin": "*", // Allow from anywhere 
    },
    statusCode: 200,
    body: `${total}`,
  };
};