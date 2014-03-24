var displayLinks = function(){
  $("#meal_topic_id").on("change", function(){
    var selected = $(".topic-title-select").find(":selected");
    var topicID = selected.val();
    var topicLinks = $(".topic-links");
    if (topicID == "") {
      topicLinks.slideUp();
      topicLinks.html("");
    }
    else {
      $.getJSON("../../topics/" + topicID + "/links", function(response){
        var output = "<h3>" + selected.text() + "</h3><br />";
        output += "<h4>(We recommend choosing about 3 links to send to your friends.)</h4><br /><p>";
        $.each(response, function(index, link){
          output += '<div><input id="link'+index+'" name="links[]" type="checkbox" value="'+link.id+'" />'
          output += ' <a href="' + link.url + '" target="_blank">';
          output += link.name + "</a><br />";
          console.log(link);
          output += '<div class="hidden panel">' + link.summary + '</div></div>';
        });
        output += "</p>";
        console.log(output);
        topicLinks.html(output).slideDown();
      });
    }
    topicLinks.on("mouseover", "a", function(){
      $(this).parent().find(".panel").slideDown();
    });
    topicLinks.on("mouseleave", "a", function(){
      $(this).parent().find(".panel").slideUp();
    });
  });
};

var tabAround = function(){
  $(".tab-around").on("click", function(event){
    event.preventDefault();
    var target = this.href.substring(this.href.indexOf('#goto-') + 6);
    console.log("hi");
    $("dl").find('a[href=\"#'+target+'\"]').click();
  })
}

$(document).ready(function(){
  displayLinks();
  tabAround();
});