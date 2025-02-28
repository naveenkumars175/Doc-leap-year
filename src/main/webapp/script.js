function checkLeapYear() {
    let year = document.getElementById('yearInput').value;
    let resultText = "";
    
    if (year === "") {
        resultText = "Please enter a year.";
    } else {
        let isLeap = (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
        let days = isLeap ? 366 : 365;
        resultText = `${year} is ${isLeap ? "a Leap Year" : "not a Leap Year"} with ${days} days.`;
    }

    let resultElement = document.getElementById('result');
    resultElement.innerHTML = resultText;
    resultElement.style.animation = "fadeIn 1s ease-in-out";
}
