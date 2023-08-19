const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const Room = require("./models/Game");

const app = express();
var server = http.createServer(app);
const port = process.env.port || 3000;

const io = require("socket.io")(server);

const DB =
    "mongodb+srv://chavdavarsha860:test123@cluster0.roteyba.mongodb.net/?retryWrites=true&w=majority";

io.on("connection", (socket) => {
    console.log(socket.id);
    socket.on("createRoom", async ({ nickname }) => {
        try {
            console.log(nickname);
            let room = Room();
            let player = {
                socketID: socket.id,
                nickname,
                playerType: "X",
            };
            room.players.push(player);
            room.turn = player;
            room = await room.save();
            const roomId = room._id.toString;

            socket.join(roomId);
            io.to(roomId).emit('createRoomSuccess',room);
        } catch (error) {
            console.log(error);
        }
    });
});

mongoose
    .connect(DB)
    .then(() => {
        console.log("Connection Successful!");
    })
    .catch((e) => {
        console.log(e);
    });

//middleware
app.use(express.json());

server.listen(port, "localhost", () => {
    console.log(`server started and running on ${port}`);
});
