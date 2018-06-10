import $ from 'jquery';
import QuillDeltaToHtmlConverter from 'quill-delta-to-html';

const quillToolbar = [
  ['bold', 'italic', 'underline', 'strike'], // toggled buttons
  ['blockquote', 'code-block'],
  [{ list: 'ordered' }, { list: 'bullet' }],
  [{ script: 'sub' }, { script: 'super' }], // superscript/subscript
  [{ indent: '-1' }, { indent: '+1' }], // outdent/indent
  [{ direction: 'rtl' }], // text direction
  [{ align: [] }],
  ['link', 'image'],
  ['clean'], // remove formatting button
];

function getActiveNavLink() {
  if (/about/.test(window.location.pathname)) {
    return $('#nav-about');
  } else if (/contact/.test(window.location.pathname)) {
    return $('#nav-contact');
  } else if (/category/.test(window.location.href)) {
    return $('#nav-categories');
  } else {
    return $('#nav-home');
  }
}

function getURLParameter(name) {
  return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [null, ''])[1].replace(/\+/g, '%20')) || null;
}

$(document).ready(() => {

  if ((window.location.pathname !== '/') || 
      (getURLParameter('page') !== null && +getURLParameter('page') !== 1)) {
    const offset = $('#nav').offset().top;
    if (offset > window.scrollY)
      $('html, body').animate({ scrollTop: $('#nav').offset().top }, 500); //.scrollTop(window.innerHeight);
  }

  $('#chevron-down').click(() => {
    const offset = $('#nav').offset().top;
    $('html, body').animate({ scrollTop: offset }, 750);
  });

  $('#nav-slider').css({ left: getActiveNavLink().position().left, width: getActiveNavLink().outerWidth() });

  $('.nav__link--text').each(function () {
    const self = $(this);
    self.hover(() => {
      $('#nav-slider').stop().animate({ left: self.position().left, width: self.outerWidth() }, 125);
    }, () => {
      const link = getActiveNavLink();
      $('#nav-slider').stop().animate({ left: link.position().left, width: link.outerWidth() }, 125);
    });
  });

  if (window.location.pathname === '/' || window.location.pathname === '/posts') {
    $('#page-slider').css({ left: $('#active-page').position().left + 8 });

    $('.pagination__button').each(function () {
      const self = $(this);
      self.hover(() => {
        $('#page-slider').stop().animate({ left: self.position().left + 8 }, 250);
      }, () => {
        const active = $('#active-page');
        $('#page-slider').stop().animate({ left: active.position().left + 8 }, 250);
      });
    });
  }

  window.toggleLoginForm = function() {
    $('#login-form').toggleClass('login-form--show');
  };

  if ($('#new-post-preview').length) {
    const editor = new Quill('#new-post-preview', {
      modules: {
        toolbar: quillToolbar,
      },
      theme: 'snow',
    });
    editor.on('text-change', function() {
      const delta = editor.getContents();
      const qdc = new QuillDeltaToHtmlConverter(
        delta.ops,
        window.opts_ || {},
      );
      const html = qdc.convert();
      $('#post-preview').html(html);
      $('#hidden-preview').val(html);
      MathJax.Hub.Queue(['Typeset', MathJax.Hub]);
    });
  }

  if ($('#new-post-body').length) {
    const editor = new Quill('#new-post-body', {
      modules: {
        toolbar: quillToolbar,
      },
      theme: 'snow',
    });
    editor.on('text-change', function() {
      const delta = editor.getContents();
      const qdc = new QuillDeltaToHtmlConverter(
        delta.ops,
        window.opts_ || {},
      );
      const html = qdc.convert();
      $('#post-body').html(html);
      $('#hidden-body').val(html);
      MathJax.Hub.Queue(['Typeset', MathJax.Hub]);
    });
  }

});
