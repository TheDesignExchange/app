(function() {
  $(function() {
    var content, hiddenDiv, txt;
    txt = $('textarea');
    hiddenDiv = $(document.createElement('div'));
    content = null;
    txt.addClass('noscroll');
    hiddenDiv.addClass('hiddendiv common');
    $('body').append(hiddenDiv);
    txt.on('keyup click mouseenter', function() {
      content = $(this).val();
      content = content.replace(/\n/g, '<br>');
      hiddenDiv.html(content + '<br class="lbr">');
      $(this).css('height', hiddenDiv.height());
    });
  });

}).call(this);
