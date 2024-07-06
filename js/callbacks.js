import { readFile } from 'fs'
import request from 'request'

readFile('./file.txt', (err, data) => {
    if(err) throw new Error('Error Reading File')
    console.log('File Readed Buffer =>', data)
})


const getRandomDog = (numberOfDogs, cb) => {
    const apiUrl = `https://dog.ceo/api/breeds/image/random/${numberOfDogs}`
    const response = request.get(apiUrl, (err, response, body) => {
        if(err) throw new Error('Unable to Talk to the API')
        return cb('Something Happened', response.body)
    })
}


getRandomDog(5, function(err, data) {
    console.log('Executing CallBack with Data', data)
})
