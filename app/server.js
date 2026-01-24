const express = require("express");
const app = express();

app.get("/health", (req, res) => {
  res.json({ status: "ok" });
});

app.get("/", (req, res) => {
  res.send("DevSecOps Project 1 running");
});

app.listen(3000, () => {
  console.log("Server running on port 3000");
});
