var checkedLinks = [];

var trackLinks = function() {
  $(".topic-links").on("change", "input", function(){
    thisValue = $(this).prop("value");
    if ($(this).prop("checked")) {
      checkedLinks.push(thisValue);
    } else {
      checkedLinks.splice(checkedLinks.indexOf(thisValue), 1);
    }
  });
};

var displayLinks = function(){
  $("#meal_topic_id").on("change", function(){
    var selected = $(".topic-title-select").find(":selected");
    var topicID = selected.val();
    var topicLinks = $(".topic-links");
    var topicDescriptions = $(".topic-descriptions");
    var topicDescriptionsContainer = $('.topic-descriptions-container');
    if (topicID == "") {
      topicLinks.slideUp().html("");
      topicDescriptionsContainer.slideUp().find(".topic-descriptions").html("");
    }
    else {
      $.getJSON("../../topics/" + topicID + "/links", function(response){
        var output = "<h3>" + selected.text() + "</h3><br />";
        var summary = "";
        var currentSummary = "";
        output += "<h4>(We recommend choosing about 3 links to send to your friends.)</h4><br /><p>";
        $.each(response, function(index, link){
          output += '<div class="link-option"><p><input id="link'+index+'" name="meal[links][]" type="checkbox" value="'+link.id +'"'
          if(checkedLinks.indexOf(link.id.toString()) > -1){ output += "checked"; }
          output += ' /> <a href="' + link.url + '" target="_blank">';
          output += link.name + "</a>";
          output += ' <span id="show-' + index + '" class="hide-for-large-up">(+ Show summary)</span>'
          currentSummary = '<div class="hidden index-' + index + '">' + link.summary + '</div></div>';
          summary += currentSummary;
          output += '<div class="hide-for-large-up">' + currentSummary + '</div></p>';
        });
        output += "</p>";
        topicLinks.html(output).slideDown();
        topicDescriptionsContainer.slideDown();
        topicDescriptions.append($(summary)).slideDown();
      });
    }
    topicLinks.on("mouseover", ".link-option", function(){
      if ($(window).width() > 1025) {
        var id = $(this).find("input").attr("id").substring(4);
        topicDescriptionsContainer.find(".index-" + id).first().show();
      }
    });
    topicLinks.on("mouseleave", ".link-option", function(){
      if ($(window).width() > 1025) {
        var id = $(this).find("input").attr("id").substring(4);
        topicDescriptionsContainer.find(".index-" + id).hide();
      }
    });
    topicLinks.on("click", 'span', function(event){
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
      $(".accordion").addClass("tabs").removeClass("accordion")
      $("form").removeClass("border-top")
      $(".content").detach().appendTo($(".tabs-content"));
      $("input[type=submit]").detach().appendTo($(".tabs-content"));
    } else {
      $(".tabs").addClass("accordion").removeClass("tabs")
      $("form").addClass("border-top")
    }
}

var removeMenuItems = function(link) {
  var parentDiv = $(this).parent();
  var parentID = parentDiv.prop("id");
  $("input[type=checkbox]").filter("#" + parentID).prop("checked", false);
  parentDiv.fadeOut(parentDiv.remove);
}

var tableize = function(queryString) {
  $.getJSON("../../recipes/search/" + queryString, function(response) {
    $(".recipes-attribution").html(response.attribution.html);
    
    var tr = $('<tr class="recipe-info">'+
      '<td class="recipe-checkbox"></td>' +
      '<td class="recipe-image"></td>' +
      '<td class="recipe-name"></td>' +
      '<td class="recipe-course"></td>' +
      '<td class="recipe-cuisine"></td>' +
      '<td class="recipe-rating"></td>' +
      '<td class="recipe-source"></td>' +
    '</tr>');

    $.each(response.matches, function(index, recipe) {
      var new_tr = tr.clone();
      var checkboxName = "recipe" + recipe.id;
      var checked = "";
      var existingBox = $(".hidden-recipes").find('#' + checkboxName);
      if (existingBox.length > 0 && existingBox.slice(-1).prop("checked")) {
        checked = " checked";
      }
      new_tr.find(".recipe-checkbox").html('<input id="' + checkboxName +
        '" name="recipes[]" type="checkbox" value="' + checkboxName + '"' +
        checked + '>');
      if (recipe.smallImageUrls[0]) {
        new_tr.find(".recipe-image").html('<img src="'+recipe.smallImageUrls[0]+'">');
      }
      new_tr.find(".recipe-name").html('<a class="recipe-link">' + recipe.recipeName + '</a>');
      if (recipe.attributes.course) {
        new_tr.find(".recipe-course").html(recipe.attributes.course);
      }
      if (recipe.attributes.cuisine) {
        new_tr.find(".recipe-cuisine").html(recipe.attributes.cuisine[0]);
      }
      if (recipe.rating) {
        new_tr.find(".recipe-rating").html(recipe.rating);
      }
      if (recipe.sourceDisplayName) {
        new_tr.find(".recipe-source").html(recipe.sourceDisplayName);
      }
      new_tr.appendTo($("tbody"));
      new_tr.find("input").click( function(){
        var checkbox = $(this);
        var recipeID = checkbox.prop("value");
        if ($(this).is(':checked')) {
          var recipeName = checkbox.parent().parent().find(".recipe-name").text()
          var newMenuItem = $(".menu.item.hidden").clone()
          newMenuItem.prop("id", checkbox.prop("id"));
          newMenuItem.prepend(checkbox.clone().addClass("hidden"));
          newMenuItem.prepend(recipeName);
          newMenuItem.appendTo($(".menu.panel")) && newMenuItem.fadeIn() && newMenuItem.removeClass("hidden");
          newMenuItem.find(".remove-menu-item").on("click", newMenuItem.find("remove-menu-item"), removeMenuItems);
        } else {
          $(".menu.panel").find($("#" + recipeID)).fadeOut(function() {$(this).remove()});
        }
      });
      new_tr.find(".recipe-link").on("click", function() {
        $.getJSON("../../recipes/" + recipe.id, function(response){
          window.open(response.json.source.sourceRecipeUrl, '_blank');
        });
      });
    }) && $(".recipe-container").slideDown();
  });
};

var displayRecipes = function(){
  $(".recipe-querier").on("click.first", "#search-recipes", function() {
    var queryString = $("#recipe_query").val();
    tableize(queryString);
    
    $(".recipe-querier").off("click.first");
    $(".recipe-querier").on("click.subsequent", "#search-recipes", function() {
      $(".recipes-table").find(".recipe-info").detach().appendTo($(".hidden-recipes"));
      var queryString = $("#recipe_query").val();
      tableize(queryString);
    });
  });

  // Also accept user hitting ENTER
  $(".recipe-querier").on("keypress", "#recipe_query", function(event){
    event.stopPropagation();
    var code = event.which;
    if(code == 13) {
      event.preventDefault();
      $(".recipe-querier").find("#search-recipes").trigger("click");
    }
  });
};

var fixBoxHeight = function() {
  boxes = $('.meal-li');
  boxes.height("auto");
  maxHeight = Math.max.apply(
  Math, boxes.map(function() {
    return $(this).height();
  }).get());
  boxes.height(maxHeight);
};

var addGuestHere = function() {
  $(this).before($('.new-guest-form').clone());
  $('.new-guest-form:first').fadeIn(function(){
    $('.new-guest-form:first').removeClass("new-guest-form");
  });
};

var enableAddGuestLink = function() {
  $('.add-guest').on("click", addGuestHere)
};

var syncTimes = function() {
  $(".hidden-date-field").val($(".visible-date-field").val()) &&
  $(".hidden-time-field").val($(".visible-time-field").val());
  return true;
};

var enableSecretSubmit = function() {
  $(".pre-submit").click(function(){
    syncTimes() && $("#the-actual-submit-button").trigger("click");
  });
}

$(document).ready(function(){
  trackLinks();
  enableAddGuestLink();
  displayLinks();
  tabAround();
  checkWidth();
  displayRecipes();
  enableSecretSubmit();

  $(window).resize(function(){
    checkWidth();
  });

  $(window).load(fixBoxHeight());
  $(window).resize(fixBoxHeight);
});