// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import { Turbo, cable } from "@hotwired/turbo-rails";

// eslint-disable-next-line import/no-unresolved
import "controllers"; // Stimulus

Turbo.setProgressBarDelay(100);
Rails.start();

// TODO: Unused for now
// import * as ActiveStorage from "@rails/activestorage";
// import "channels";
// ActiveStorage.start();

// document.addEventListener('turbo:load', function () {
//   console.log('turbo load')
// })
//
// document.addEventListener('turbo:render', function () {
//   console.log('turbo render')
// })
//
// document.addEventListener('turbo:visit', function () {
//   console.log('turbo visit')
// })
