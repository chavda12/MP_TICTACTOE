const axios = require('axios');

const getSentence = async ()=>{
    const jokedata = await axios.get('https://api.quotable.io/random');
    return jokedata.data.content.split(" ");
}
module.exports = getSentence;