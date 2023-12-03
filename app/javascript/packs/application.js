
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";
import "../stylesheets/new.css";


 alert('session編集');

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
      var headerImage = document.getElementById('header-image');
      var headerImageInput = document.getElementById('user_header_image');
      headerImage.addEventListener('click', function() {
        headerImageInput.click();
      });
    
      // アイコン画像のクリックイベント
      var iconImage = document.getElementById('icon-image');
      var iconImageInput = document.getElementById('user_icon_image');
      iconImage.addEventListener('click', function() {
        iconImageInput.click();
      });
    });
    
    document.addEventListener('DOMContentLoaded', (event) => {
      // 要素を取得
      const button = document.getElementById('follow-btn');
    
      // マウスオーバー時のイベントハンドラ
      button.addEventListener('mouseover', (event) => {
        // マウスオーバー時に行いたい処理
        console.log('unfollow');
      });
    
      // マウスアウト時のイベントハンドラ
      button.addEventListener('mouseout', (event) => {
        // マウスアウト時に行いたい処理
        console.log('following');
      });
    });

    

Rails.start()
Turbolinks.start()
ActiveStorage.start()
