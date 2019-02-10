import $ from 'jquery';

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
  return (
    decodeURIComponent(
      (new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(
        location.search
      ) || [null, ''])[1].replace(/\+/g, '%20')
    ) || null
  );
}

function deletePost(id) {
  var shouldDelete = confirm('Are you sure you want to delete this post?');

  if (!shouldDelete) return;

  fetch(`/posts/${id}`, {
    method: 'DELETE',
  }).then(() => {
    window.location = '/posts';
  });
}

function isLocalHost(hostname) {
  return !!(
    hostname === 'localhost' ||
    hostname === '[::1]' ||
    hostname.match(/^127(?:\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}$/)
  );
}

if (!isLocalHost(window.location.hostname) && location.protocol != 'https:') {
  location.href =
    'https:' + window.location.href.substring(window.location.protocol.length);
}

window.deletePost = deletePost;

$(document).ready(() => {
  // if ((window.location.pathname !== '/') || (window.location.pathname !== '/posts') ||
  //     (getURLParameter('page') !== null && +getURLParameter('page') !== 1)) {
  //   // const offset = $('#nav').offset().top;
  //   // if (offset > window.scrollY)
  //   //   $('html, body').animate({ scrollTop: $('#nav').offset().top }, 500); //.scrollTop(window.innerHeight);
  //   $('#header').css({ height: '15rem' });
  //   $('#chevron-down').css({ display: 'none' });
  // }

  if (
    window.location.pathname !== '/posts' ||
    (window.location.pathname === '/posts' && window.location.search !== '')
  ) {
    $('#header').css({ height: '15rem' });
    $('#chevron-down').css({ display: 'none' });
  }

  $('#chevron-down').click(() => {
    const offset = $('#nav').offset().top;
    $('html, body').animate({ scrollTop: offset }, 750);
  });

  $('#nav-slider').css({
    left: getActiveNavLink().position().left,
    width: getActiveNavLink().outerWidth(),
  });

  $('.nav__link--text').each(function() {
    const self = $(this);
    self.hover(
      () => {
        $('#nav-slider')
          .stop()
          .animate(
            { left: self.position().left, width: self.outerWidth() },
            125
          );
      },
      () => {
        const link = getActiveNavLink();
        $('#nav-slider')
          .stop()
          .animate(
            { left: link.position().left, width: link.outerWidth() },
            125
          );
      }
    );
  });

  if (
    window.location.pathname === '/' ||
    window.location.pathname === '/posts'
  ) {
    $('#page-slider').css({ left: $('#active-page').position().left + 8 });

    $('.pagination__button').each(function() {
      const self = $(this);
      self.hover(
        () => {
          $('#page-slider')
            .stop()
            .animate({ left: self.position().left + 8 }, 250);
        },
        () => {
          const active = $('#active-page');
          $('#page-slider')
            .stop()
            .animate({ left: active.position().left + 8 }, 250);
        }
      );
    });
  }

  window.toggleLoginForm = function() {
    $('#login-form').toggleClass('login-form--show');
  };
});
