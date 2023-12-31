
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";
import "../stylesheets/new.css";


// alert('session編集');

document.addEventListener("turbolinks:load", function() {
        const input = document.querySelector('#post_image');
        const preview = document.querySelector('#image-preview');

        input.addEventListener('change', function(event) {
          const file = event.target.files[0];
          if (file) {
            const reader = new FileReader();

            reader.onload = function(e) {
              preview.src = e.target.result;
              preview.style.display = 'block';
            };
            reader.readAsDataURL(file);
          }
        });
      });
      
      document.addEventListener("turbolinks:load", function() {
      // ヘッダー画像のクリックイベント
      var headerImage = document.getElementById('header-image-preview');
      var headerImageInput = document.getElementById('user_header_image');
      headerImage.addEventListener('click', function() {
        headerImageInput.click();
      });
    
      // アイコン画像のクリックイベント
      var iconImage = document.getElementById('icon-image-preview');
      var iconImageInput = document.getElementById('user_icon_image');
      iconImage.addEventListener('click', function() {
        iconImageInput.click();
      });
      
        // ヘッダー画像のプレビュー
        var headerImageInput = document.getElementById('user_header_image');
        var headerImagePreview = document.getElementById('header-image-preview');
        
        headerImageInput.addEventListener('change', function(event) {
          var file = event.target.files[0];
          if (file) {
            var reader = new FileReader();
            reader.onload = function(e) {
              headerImagePreview.src = e.target.result;
            };
            reader.readAsDataURL(file);
          }
        });
        
        // アイコン画像のプレビュー
        var iconImageInput = document.getElementById('user_icon_image');
        var iconImagePreview = document.getElementById('icon-image-preview');
        
        iconImageInput.addEventListener('change', function(event) {
          var file = event.target.files[0];
          if (file) {
            var reader = new FileReader();
            reader.onload = function(e) {
              iconImagePreview.src = e.target.result;
            };
            reader.readAsDataURL(file);
          }
        });
      });

    

Rails.start()
Turbolinks.start()
ActiveStorage.start()
