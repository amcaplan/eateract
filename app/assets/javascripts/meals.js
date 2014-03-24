var displayLinks = function(){
  $("#meal_topic_id").on("change", function(){
    var selected = $(".topic-title-select").find(":selected");
    var topicID = selected.val();
    var topicLinks = $(".topic-links");
    var topicDescriptions = $(".topic-descriptions");
    var topicDescriptionsContainer = $('.topic-descriptions-container');
    if (topicID == "") {
      topicLinks.slideUp();
      topicLinks.html("");
      topicDescriptionsContainer.hide();
    }
    else {
      $.getJSON("../../topics/" + topicID + "/links", function(response){
        var output = "<h3>" + selected.text() + "</h3><br />";
        var summary = "";
        var currentSummary = "";
        output += "<h4>(We recommend choosing about 3 links to send to your friends.)</h4><br /><p>";
        $.each(response, function(index, link){
          output += '<div><p><input id="link'+index+'" name="links[]" type="checkbox" value="'+link.id+'" />'
          output += ' <a href="' + link.url + '" target="_blank">';
          output += link.name + "</a>";
          output += ' <a id="show-' + index + '" href="#" class="hide-for-large-up">(+ Show summary)</a>'
          currentSummary = '<div class="hidden index-' + index + '">' + link.summary + '</div></div>';
          summary += currentSummary;
          output += '<div class="hide-for-large-up">' + currentSummary + '</div></p>';
        });
        output += "</p>";
        topicLinks.html(output).slideDown();
        topicDescriptionsContainer.slideDown();
        topicDescriptions.append(summary).slideDown();
      });
    }
    topicLinks.on("mouseover", "a", function(){
      if ($(window).width() > 1025) {
        var id = $(this).parent().find("input").attr("id").substring(4);
        console.log(topicDescriptionsContainer.find(".index-" + id));
        topicDescriptionsContainer.find(".index-" + id).show();
      }
    });
    topicLinks.on("mouseleave", "a", function(){
      if ($(window).width() > 1025) {
        var id = $(this).parent().find("input").attr("id").substring(4);
        topicDescriptionsContainer.find(".index-" + id).hide();
      }
    });
    topicLinks.on("click", 'a[href="#"]', function(event){
      event.stopPropagation();
      event.preventDefault();
      var id = $(this).attr("id").substring(5);
      $(this).parent().parent().parent().find(".index-"+id).slideToggle(100);
      if ($(this).text() == "(+ Show summary)") {
        $(this).text("(- Hide summary)");
      } else {
        $(this).text("(+ Show summary)");
      }
    });
  });
};

var tabAround = function(){
  $(".tab-around").on("click", function(event){
    event.preventDefault();
    var target = this.href.substring(this.href.indexOf('#goto-') + 6);
    $("dl").find('a[href=\"#'+target+'\"]').click();
  })
}

var checkWidth = function() {
    var windowSize = $(window).width();
    if (windowSize > 1025) {
      $(".tabs").addClass("tabs").removeClass("accordion")
      $(".content").detach().appendTo($(".tabs-content"));
      $("input[type=submit]").detach().appendTo($(".tabs-content"));
    } else {
      $(".tabs").addClass("accordion").removeClass("tabs")
    }
}

$(document).ready(function(){
  displayLinks();
  tabAround();
  checkWidth();
  $(window).resize(checkWidth);
});