// ==UserScript==
// You know what? Fuck you
// *unuserscripts your userscript*
// ==/UserScript==

function addStyleSheet(style){
  var getHead = document.getElementsByTagName("HEAD")[0];
  var cssNode = window.document.createElement( 'style' );
  var elementStyle= getHead.appendChild(cssNode);
  elementStyle.innerHTML = style;
  return elementStyle;
}

addStyleSheet('@import "https://rndtrash.github.io/highlight-RMS-supporters/styles.css";');
