// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

//trix editor
import 'trix/dist/trix.css';
import 'trix/dist/trix.js';

require("@rails/actiontext")
require("css/application.scss")

import hljs from 'highlight.js'
import ruby from 'highlight.js/lib/languages/ruby'
import erb from 'highlight.js/lib/languages/erb'
import bash from 'highlight.js/lib/languages/bash'
import javascript from 'highlight.js/lib/languages/javascript'
import 'highlight.js/scss/srcery.scss';

hljs.registerLanguage('ruby', ruby);
hljs.registerLanguage('erb', erb);
hljs.registerLanguage('bash', bash);
hljs.registerLanguage('javascript', javascript);

hljs.configure({ languages: ['ruby', 'erb', 'bash', 'javascript'] });

document.addEventListener('turbolinks:load', (event) => {
  document.querySelectorAll('pre').forEach((block) => {
    hljs.highlightBlock(block);
  });
});

// Prevent image attachments in posts
window.addEventListener("trix-file-accept", function(event) {
  event.preventDefault();
  alert("File attachment not supported!");
});
