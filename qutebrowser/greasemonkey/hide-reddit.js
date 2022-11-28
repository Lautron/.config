// ==UserScript==
// @name         hide youtube
// @namespace    *
// @version      0.1
// @description  remove video suggestions from youtube
// @author       Lautaro
// @match        https://www.reddit.com/
// @grant        none
// @license      MIT
// ==/UserScript==

(function () {
  let html = document.querySelector(
    "#AppRouter-main-content > div > div > div > div > div"
  );
  html.remove();
})();
