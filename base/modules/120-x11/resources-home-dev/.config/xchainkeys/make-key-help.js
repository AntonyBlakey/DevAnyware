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
    prefix = prefix + key[0] + "-";
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
  return [prefix.length, prefix, category, key];
};

const arrayCompare = (a, b) => {
  const key1 = a.sortKey;
  const key2 = b.sortKey;
  if (key1.length !== key2.length) return key1.length - key2.length;
  for (let i = 0; i < key1.length; i++) {
    if (key1[i] < key2[i]) {
      return -1;
    } else if (key1[i] > key2[i]) {
      return 1;
    }
  }
  return 0;
};

const file = process.argv[2];
const json = require(file);
const hydra = json.F35.hydra;

const columns = Object.entries(hydra).map(([label, elements]) => {
  return {
    label: label,
    elements: Object.entries(elements).map(([key, value]) => {
      return { ...value, key: key, sortKey: sortKey(key) };
    }).sort(arrayCompare)
  };
});

console.log(`<html><head><link rel="stylesheet" href="${__dirname}/help.css"/></head><body><div>`);

columns.forEach(column => {
  console.log("<div class='column'>");
  console.log(`<div class='header'>${column.label}</div>`);
  column.elements.forEach(row => {
    console.log(`<div class='key'><span class='prefix'>${row.sortKey[1]}</span>${escapeHTML(row.sortKey[3])}</div>`);
    console.log(`<div class='label ${row.exit ? "exit" : ""}'>${escapeHTML(row.label)}</div>`);
  });
  console.log("</div>");
});

console.log("</div></body></html>");
