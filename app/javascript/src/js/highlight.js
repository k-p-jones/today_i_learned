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
