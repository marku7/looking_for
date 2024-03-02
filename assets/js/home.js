// Function to handle the report button click and open the modal
document.addEventListener('click', function (event) {
  if (event.target.classList.contains('report-button')) {
    var postid = event.target.dataset.postid;
    document.getElementById('postid').value = postid;
    toggleModal(); // Open the modal
  }
});

// Function to toggle the modal visibility
function toggleModal() {
  var modal = document.getElementById('reportModal');
  modal.classList.toggle('modal-visible');
}

// Function to handle the report submission
document.getElementById('reportButton').addEventListener('click', function () {
  var postid = document.getElementById('postid').value;
  var violation = [];

  var abusive = document.getElementById('abusive').checked;
  if (abusive) violation.push('Inappropriate or Abusive');

  var offensive = document.getElementById('offensive').checked;
  if (offensive) violation.push('Offensive');

  var falseInfo = document.getElementById('false').checked;
  if (falseInfo) violation.push('False Information');

  var others = document.getElementById('exampleTextarea').value;
  if (others.trim() !== '') violation.push(others);

  // Send an AJAX request to the server to report the post
  // ... your AJAX request code ...

  toggleModal(); // Close the modal after reporting
});