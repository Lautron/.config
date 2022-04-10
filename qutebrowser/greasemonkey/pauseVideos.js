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
    document.getElementsByTagName('video')[0].pause()
})();
