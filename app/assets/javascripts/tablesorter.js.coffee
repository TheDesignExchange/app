$(document).ready ->
  $ ->
    $.extend $.tablesorter.defaults,
      widgets: [
        "zebra"
        "columns"
      ]

    $("#myTable")
    .tablesorter()
    .tablesorterPager({container: $("#pager")});

    return