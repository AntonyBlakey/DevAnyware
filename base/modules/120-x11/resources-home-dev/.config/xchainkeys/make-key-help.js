const escapeHTML = s => {
  return s
    .replace(/&/g, "&amp;")
    .replace(/"/g, "&quot;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;");
};

const sortKey = k => {
  let key = k;
  let prefix = "";
  while (key.length > 1 && key[1] == "-") {
    prefix = prefix + key[0];
    key = key.substring(2);
  }
  let category = "";
  if (key.length > 1) {
    category = "9";
  } else if ("abcdefghijklmnopqrstuvwxyz".includes(key)) {
    category = "0";
  } else if ("0123456789".includes(key)) {
    category = "1";
  } else if ("(){}[]<>".includes(key)) {
    category = "2";
  } else if ("-" == key) {
    category = "3";
  } else if ("+" == key) {
    category = "4";
  } else {
    category = "8";
  }
  return prefix.length + prefix + category + key;
};

const keySorter = (a, b) => {
  const key1 = sortKey(a);
  const key2 = sortKey(b);
  if (key1 < key2) {
    return -1;
  } else if (key1 > key2) {
    return 1;
  } else {
    return 0;
  }
};

const file = process.argv[2];
const json = require(file);
const hydra = json.F35.hydra;

console.log(`<html><head><link rel="stylesheet" href="${__dirname}/help.css"/></head><body><div><table>`);

console.log("<tr>");
let rowCount = 0;
for (let k in hydra) {
  console.log(`<th colspan='2'>${k}</th>`);
  rowCount = Math.max(rowCount, Object.keys(hydra[k]).length);
}
console.log("</tr>");

for (let row = 0; row < rowCount; row++) {
  console.log("<tr>");
  for (let k in hydra) {
    const group = hydra[k];
    const keys = Object.keys(group).sort(keySorter);
    if (row < keys.length) {
      const key = keys[row];
      const label = group[key].label;
      console.log(`<td>${escapeHTML(key)}</td><td>${escapeHTML(label)}</td>`);
    } else {
      console.log(`<td class='empty'></td><td class='empty'></td>`);
    }
  }
  console.log("</tr>");
}

console.log("</table></div></body></html>");
