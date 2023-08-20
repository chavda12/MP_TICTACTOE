const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const Room = require("./models/room");

const app = express();
var server = http.createServer(app);
const port = process.env.port || 3000;
const io = require("socket.io")(server);

const DB =
    "mongodb+srv://chavdavarsha860:test123@cluster0.roteyba.mongodb.net/?retryWrites=true&w=majority";

io.on("connection", (socket) => {
    console.log(`desf ${socket.id}`)
        socket.emit("hey","hyyyyy");
    socket.on('createRoom', async ({ nickname }) => {
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
            console.log(roomId);
            io.to(roomId).emit("createRoomSuccess", room);
        } catch (error) {
            console.log(error);
        }
    });

    socket.on("joinRoom", async ({ nickname, roomId }) => {
        try {
            console.log(nickname, roomId);
            if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
                socket.emit("errorOccurred", "Please enter a valid room ID");
                return;
            }
            let room = await Room.findById(roomId);
            if (room.isJoin) {
                let player = {
                    nickname,
                    socketID: socket.id,
                    playerType: "0",
                };
                socket.join(roomId);
                Room.players.push(player);
                room.isJoin;
                room = await Room.save();

                io.to(roomId).emit("joinRoomSuccess", room);
                io.to(roomId).emit("updatePlayers", room.players);
                io.to(roomId).emit("updateRoom", room);
            } else {
                socket.emit(
                    "errorOccurred",
                    "The game is in progress, try again a later"
                );
            }
        } catch (error) {
            console.log(error);
        }
    });

    socket.on("tap", async ({ index, roomId }) => {
        try {
            let room = await Room.findById(roomId);
            let choice = room.turn.playerType;
            if (room.turnIndex == 0) {
                room.turn = room.players[1];
                room.turnIndex == 1;
            } else {
                room.turn = room.players[0];
                room.turnIndex == 0;
            }
            room = await room.save();
            io.to(roomId).emit("tapped", {
                index,
                choice,
                room,
            });
        } catch (error) {}
    });
    
    socket.on("winner", async ({ winnerSocketId, roomId }) => {
        try {
            let room = await Room.findById(roomId);
            let player = room.players.find(
                (playerr) => playerr.socketID == winnerSocketId
            );
            player.points += 1;
            room = await room.save();

            if (player.points >= room.maxRounds) {
                io.to(roomId).emit("endGame", player);
            } else {
                io.to(roomId).emit("pointIncrease", player);
            }
        } catch (e) {
            console.log(e);
        }
    });
});

mongoose
    .connect(DB)
    .then(() => {
        console.log("Connection Successful!");

        server.listen(port, "localhost", () => {
            console.log(`server started and running on ${port}`);
        });
    })
    .catch((e) => {
        console.log(e);
    });

//middleware
app.use(express.json());
