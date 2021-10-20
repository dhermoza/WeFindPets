const initBreedSelect = () => {
  $("#pet_animal").change(function () {
    $("#filterbtn").attr("disabled", true);
    $.ajax({
      url: $("#get_breeds_path").val(), // this will be routed
      type: "GET",
      data: {
        pet_animal: $("#pet_animal").val(),
      },

      async: true,
      dataType: "json",
      error: function (XMLHttpRequest, errorTextStatus, error) {
        $("#filterbtn").attr("disabled", false);
        alert("Failed: " + errorTextStatus + " ;" + error);
      },
      success: function (data) {
        $("#filterbtn").attr("disabled", false);
        $("#pet_breed option").remove();
        data.forEach((element) => {
          $("#pet_breed").append(
            !!element[1]
              ? `<option value="${element[1]}">${element[0]}</option>`
              : `<option value="">${element[0]}</option>`
          );
        });
      },
    });
  });
};

export { initBreedSelect };
