// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require jquery
//= require bootstrap
//= require_tree.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

const dropdown = new bootstrap.Dropdown(element, {
  popperConfig(defaultBsPopperConfig) {
    // const newPopperConfig = {...}
    // use defaultBsPopperConfig if needed...
    // return newPopperConfig
  }
})

// Turbolinksの読み込み完了後に初期化を行う
document.addEventListener("turbolinks:load", function() {
  // BootstrapのJavaScriptを再初期化
  var navbarToggler = document.querySelector('.navbar-toggler');
  navbarToggler.addEventListener('click', function() {
    var target = document.querySelector(navbarToggler.dataset.bsTarget);
    bootstrap.Collapse.getInstance(target).toggle();
  });
});


Rails.start()
Turbolinks.start()
ActiveStorage.start()
