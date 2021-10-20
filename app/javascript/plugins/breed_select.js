const initBreedSelect = () => {
  $("#pet_animal").change(function () {
    $.ajax({
      url: $("#get_breeds_path").val(), // this will be routed
      type: "GET",
      data: {
        pet_animal: $("#pet_animal").val(),
      },

      async: true,
      dataType: "json",
      error: function (XMLHttpRequest, errorTextStatus, error) {
        alert("Failed: " + errorTextStatus + " ;" + error);
      },
      success: function (data) {
        $("#pet_breed option").remove();
        data.forEach((element) => {
          $("#pet_breed").append(
            `<option value="${element[1]}">${element[0]}</option>`
          );
        });
        // here we iterate the json result
        // for(var i in data)
        // {
        //   var id = data[i].id;
        //   var title = data[i].title;
        //   $("#subject_select").append(new Option(title, id));
        // }
      },
    });
  });
};

export { initBreedSelect };
