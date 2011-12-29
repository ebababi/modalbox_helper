//  ModalboxHelper starts here, licensed under MIT license.
//  Copyright 2010 Nikolaos Anastopoulos. All rights reserved.
(function() {
  Modalbox._event = Modalbox.event.bind(Modalbox);
  Modalbox.event = function(eventName) {
    document.fire('modal:' + eventName);
    return Modalbox._event(eventName);
  };

  Modalbox.__setFocus = Modalbox._setFocus.bind(Modalbox);
  Modalbox._setFocus = function(eventName) {
    if (typeof Modalbox.focusableElements != "undefined") {
      Modalbox.__setFocus(eventName);
    }
  };


  function handleModal(element) {
    var options = element.readAttribute('data-modal').evalJSON(true),
        content = element.readAttribute('href').gsub(/^data:/, '');
    Modalbox.show(content, options);
  }


  document.on("click", "a[data-modal]", function(event, element) {
    if (event.stopped) return;
    handleModal(element);
    event.stop();
  });
})();
