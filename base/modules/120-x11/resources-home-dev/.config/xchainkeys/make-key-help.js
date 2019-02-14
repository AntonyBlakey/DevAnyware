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
  if (key.length === 4 && key[1] === "." && key[2] === ".") {
    category = "1";
  } else if (key.length > 1) {
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

const collapseNumericRanges = mapping => {
  let m = mapping;
  while (true) {
    const one = m.find(x => x.sortKey[3] === "1");
    if (!one) {
      return m;
    }
    const genericLabel = one.label.replace(" 1", "n");
    // TODO: a one-pass search for these
    // const zero = m.find(x => x.sortKey[3] === "0" && x.sortKey[2] === one.sortKey[2] && x.label.replace('0', 'n') === one.label.replace('1', 'n'));
    const two = m.find(x => x.sortKey[3] === "2" && x.sortKey[2] === one.sortKey[2] && x.label.replace(" 2", "n") === genericLabel);
    const three = m.find(x => x.sortKey[3] === "3" && x.sortKey[2] === one.sortKey[2] && x.label.replace(" 3", "n") === genericLabel);
    const four = m.find(x => x.sortKey[3] === "4" && x.sortKey[2] === one.sortKey[2] && x.label.replace(" 4", "n") === genericLabel);
    const five = m.find(x => x.sortKey[3] === "5" && x.sortKey[2] === one.sortKey[2] && x.label.replace(" 5", "n") === genericLabel);
    const six = m.find(x => x.sortKey[3] === "6" && x.sortKey[2] === one.sortKey[2] && x.label.replace(" 6", "n") === genericLabel);
    const seven = m.find(x => x.sortKey[3] === "7" && x.sortKey[2] === one.sortKey[2] && x.label.replace(" 7", "n") === genericLabel);
    const eight = m.find(x => x.sortKey[3] === "8" && x.sortKey[2] === one.sortKey[2] && x.label.replace(" 8", "n") === genericLabel);
    const nine = m.find(x => x.sortKey[3] === "9" && x.sortKey[2] === one.sortKey[2] && x.label.replace(" 9", "n") === genericLabel);
    if (two && three && four && five && six && seven && eight && nine) {
      m = m.filter(x => !("23456789".includes(x.sortKey[3]) && x.sortKey[2] === one.sortKey[2]));
      one.key = "1..9";
      one.sortKey[3] = "1..9";
      one.label = one.label.replace("1", "1..9");
    } else {
      return m;
    }
  }
  return m;
};

const formatHydra = hydra => {
  const columns = Object.entries(hydra).map(([label, elements]) => {
    let transformedElements = Object.entries(elements).map(([key, value]) => {
      return { ...value, key: key, sortKey: sortKey(key) };
    });
    transformedElements = collapseNumericRanges(transformedElements);
    transformedElements.sort(arrayCompare);
    return {
      label: label,
      elements: transformedElements
    };
  });

  console.log(`<html><head><link rel="stylesheet" href="${__dirname}/help.css"/></head><body><div class='hydra'>`);

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
};

const formatWhichKey = mapping => {
  console.log(`<html><head><link rel="stylesheet" href="${__dirname}/help.css"/></head><body><div class='whichkey'>`);
  let rows = Object.entries(mapping).map(([key, value]) => {
    return { exit: value.exit, label: value.label || value.command, key: key, sortKey: sortKey(key) };
  });
  rows = collapseNumericRanges(rows);
  rows.sort(arrayCompare);

  let numberOfGridRows = Math.ceil(Math.sqrt(rows.length));
  for (let rowNo = 0; rowNo < rows.length; rowNo++) {
    const row = rows[rowNo];
    const gridColumn = Math.floor(rowNo / numberOfGridRows) + 1;
    const gridRow = (rowNo % numberOfGridRows) + 1;
    console.log(
      `<div class='key' style='grid-row: ${gridRow}; grid-column: ${2 * gridColumn};'><span class='prefix'>${
        row.sortKey[1]
      }</span>${escapeHTML(row.sortKey[3])}</div>`
    );
    console.log(
      `<div class='label ${row.exit ? "exit" : ""}' style='grid-row: ${gridRow}; grid-column: ${2 * gridColumn + 1};'>${escapeHTML(
        row.label
      )}</div>`
    );
  }

  console.log("</div></body></html>");
};

const file = process.argv[2];
const json = require(file);

formatHydra(json.Super.hydra);
// formatWhichKey(json);
