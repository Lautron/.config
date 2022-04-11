// To run, install GreaseMonkey or TamperMonkey extension in your browser
// Copy this code into new user script, and enable

// ==UserScript==
// @name         Pause videos
// @namespace    pause_videos
// @version      1.0
// @description  This script pauses youtube videos so they don't start playing automatically
// @author       LautronB
// @match        *://www.youtube.com/*
// @run-at 	 document-idle
// @grant        none
// ==/UserScript==

(function() {       
    console.log("loaded")
    let pauseCount = 0;
    function myFunc() {
      if (pauseCount >= 2) {
	return
      }
      videos = document.getElementsByTagName('video')
      if (!videos[0].paused || parseCount <= 2) {
	videos[0].pause()
	console.log("paused")
	pauseCount++
	setTimeout(myFunc, 1000);
      } else {
	setTimeout(myFunc, 500);
      }
    }
    myFunc()
})();
