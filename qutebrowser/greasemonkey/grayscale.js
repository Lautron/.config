// ==UserScript==
// @name         grayscale websites
// @namespace    *
// @version      0.1
// @description  grayscales specified websites
// @author       Lautaro
// @match        https://www.reddit.com/*
// @match        https://www.youtube.com/*
// @match        https://web.whatsapp.com/
// @grant        none
// @license      MIT
// ==/UserScript==

(function () {
  let html = document.getElementsByTagName("html")[0];
  html.style.filter = "grayscale(1)";
})();
