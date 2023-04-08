// app/javascript/application.js
import "jquery";
import "bootstrap";

window.Rails = require("@rails/ujs");
require("@rails/activestorage").start();
require("channels");
Rails.start();
