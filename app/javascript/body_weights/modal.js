document.addEventListener('turbolinks:load', function() {
  const btn = document.getElementById('new-body-weight-btn');
  const bodyweight_modal = document.getElementById('body-weight-modal');

  // ボタンを押したらdisplay: blockにする //
  if (btn) {
    btn.addEventListener('click', function() {
    bodyweight_modal.style.display = 'block';
    });
  }

  // クリックした場所がbodyweight_modal以外だったらdisplay: noneにする //
  window.addEventListener('click', function(e) {
    if (e.target == bodyweight_modal) {
      bodyweight_modal.style.display = 'none';
    }
  });
});
