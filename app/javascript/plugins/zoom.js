const initZoom = () => {
  $("[data-zoom]").each(function () {
    const zoomUrl = $(this).data("zoom");
    console.log(zoomUrl);
    $(this).css("background-image", `url(${zoomUrl})`);
    $(this).on("mousemove", function (e) {
      var offsetX, offsetY, x, y;
      var zoomer = e.currentTarget;
      e.offsetX ? (offsetX = e.offsetX) : (offsetX = e.touches[0].pageX);
      e.offsetY ? (offsetY = e.offsetY) : (offsetX = e.touches[0].pageX);
      x = (offsetX / zoomer.offsetWidth) * 100;
      y = (offsetY / zoomer.offsetHeight) * 100;
      zoomer.style.backgroundPosition = x + "% " + y + "%";
    });
  });
};

export { initZoom };
