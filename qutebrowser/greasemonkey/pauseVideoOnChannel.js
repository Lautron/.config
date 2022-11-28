// To run, install GreaseMonkey or TamperMonkey extension in your browser
// Copy this code into new user script, and enable

// ==UserScript==
// @name         Pause video on channel
// @namespace    pause_video_on_channel
// @version      1.0
// @description  This script pauses youtube videos so they don't start playing automatically on youtube channels
// @author       LautronB
// @match        *://www.youtube.com/c/*
// @match        *://www.youtube.com/channel/*
// @run-at 	 document-idle
// @grant        none
// ==/UserScript==

(function() {       
  //window.addEventListener("load", () => {
    console.log("loaded")
    function myFunc() {
      videos = document.getElementsByTagName('video')
      if (!videos[0].paused) {
	videos[0].pause()
	console.log("paused")
      } else {
	setTimeout(myFunc, 1000);
      }
    }
    setTimeout(myFunc, 2000);
  //})
})();
