$(document).ready(function () {
  function updateClock() {
    var now = new Date();
    var formattedDate =
      now.getFullYear() +
      "年" +
      (now.getMonth() + 1) +
      "月" +
      now.getDate() +
      "日（日）";
    var formattedTime = now.toLocaleTimeString("ja-JP", {
      hour12: false,
    });
    $(".card-header span").text(formattedDate);
    $(".blockquote span").text(formattedTime);
  }
  setInterval(updateClock, 1000);
  updateClock();
});
$(document).ready(function () {
  let rowCount = $("tbody tr").length - 2;
  $("#addRowButton").click(function () {
    rowCount++;
    const newRow = `
          <tr>
            <th class="table-dark bg-info text-white align-middle" scope="row">学習時間${rowCount}</th>
            <td class="align-middle text-center">
              <span class="mx-3"></span>
              <span class="mx-3">~</span>
              <span class="mx-3"></span>
            </td>
            <td class="py-2">
              <form class="form-inline py-0" action="">
                <input class="form-control input_time text-center mx-2" type="text" />:
                <input class="form-control input_time text-center mx-2" type="text" />~
                <input class="form-control input_time text-center mx-2" type="text" />:
                <input class="form-control input_time text-center mx-2" type="text" />
              </form>
            </td>
          </tr>
        `;
    $(newRow).insertBefore($(this).closest("tr"));
  });
});
