// import {Socket} from "phoenix"

// let socket = new Socket("/socket", {})
// socket.connect()

// let channel =  socket.channel("chat:foo.com", {})

// channel.on("new_message", payload => {
//   console.log(`[${payload.host}]- should be bar.com - [${payload.username}] : ${payload.message}`)
// })

// let channel2 = socket.channel("chat:bar.com", {})

// channel2.on("new_message", payload => {
//   console.log(`[${payload.host}]- should be bar.com - [${payload.username}] : ${payload.message}`)
// })

// channel.on("new_gif", payload => {
//   console.log(`[${payload.host}]- should be bar.com - [${payload.url}]`)
// })

// channel.on("gif_not_found", payload => {
//   console.log(`Gif not found - [${payload.term}]`)
// })

// channel2.on("new_gif", payload => {
//   console.log(`[${payload.host}]- should be bar.com - [${payload.url}]`)
// })

// channel2.on("gif_not_found", payload => {
//   console.log(`Gif not found - [${payload.term}]`)
// })

// channel2.join()

// channel.join()

// setInterval(() => {
//   channel.push("new_message", {host: "foo.com", username: "foo", message: "wow"})
//   channel2.push("new_message", {host: "bar.com", username: "bar", message: "woe"})
// }, 1000)

// setInterval(() => {
//   channel2.push("new_message", {host: "bar.com", username: "bar", message: "/giphy silly cat"})
// }, 5000)

