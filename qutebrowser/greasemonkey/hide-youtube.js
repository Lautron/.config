// ==UserScript==
// @name         hide youtube
// @namespace    *
// @version      0.1
// @description  remove video suggestions from youtube
// @author       Lautaro
// @match        https://www.youtube.com/*
// @grant        none
// @license      MIT
// ==/UserScript==

(function () {
  let html = document.getElementById("page-manager");
  html.remove();
})();

//exclude      https://www.youtube.com/watch*
