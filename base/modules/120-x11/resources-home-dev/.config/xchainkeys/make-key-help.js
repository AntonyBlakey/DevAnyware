const escapeHTML = s => {
  return s
    .replace(/&/g, "&amp;")
    .replace(/"/g, "&quot;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;");
};

const symbolPrefix = "<span class='symbol'>";
const symbolSuffix = "</span>";

const htmlForKey = s => {
  if (s === "Window") {
    return symbolPrefix + "&#8984;" + symbolSuffix;
  } else if (s === "Shift") {
    return symbolPrefix + "&#8679;" + symbolSuffix;
  } else if (s === "Control" || s === "Ctrl") {
    return symbolPrefix + "&#8963;" + symbolSuffix;
  } else if (s === "Option" || s === "Alt") {
    return symbolPrefix + "&#8997;" + symbolSuffix;
  } else if (s === "Space") {
    return symbolPrefix + "&#9251;" + symbolSuffix;
  } else if (s === "Tab") {
    return symbolPrefix + "&#8677;" + symbolSuffix;
  } else if (s === "Return") {
    return symbolPrefix + "&crarr;" + symbolSuffix;
  } else if (s === "Escape") {
    return symbolPrefix + "&#9099;" + symbolSuffix;
  } else if (s === "BackSpace") {
    return symbolPrefix + "&#9003;" + symbolSuffix;
  } else if (s === "Delete") {
    return symbolPrefix + "&#8998;" + symbolSuffix;
  } else if (s === "Up") {
    return symbolPrefix + "&uarr;" + symbolSuffix;
  } else if (s === "Down") {
    return symbolPrefix + "&darr;" + symbolSuffix;
  } else if (s === "Left") {
    return symbolPrefix + "&larr;" + symbolSuffix;
  } else if (s === "Right") {
    return symbolPrefix + "&rarr;" + symbolSuffix;
  } else if (s === "PageUp") {
    return symbolPrefix + "&#8670;" + symbolSuffix;
  } else if (s === "PageDown") {
    return symbolPrefix + "&#8671;" + symbolSuffix;
  } else if (s === "Home") {
    return symbolPrefix + "&#8598;" + symbolSuffix;
  } else if (s === "End") {
    return symbolPrefix + "&#8600;" + symbolSuffix;
  } else {
    return s;
  }
};

const htmlForPrefix = s => {
  if (s === "W-") {
    return symbolPrefix + "&#8984;" + symbolSuffix;
  } else if (s === "S-") {
    return symbolPrefix + "&#8679;" + symbolSuffix;
  } else if (s === "C-") {
    return symbolPrefix + "&#8963;" + symbolSuffix;
  } else if (s === "A-" || s === "O-") {
    return symbolPrefix + "&#8997;" + symbolSuffix;
  } else if (s === "Space-") {
    return symbolPrefix + "&#9251;" + symbolSuffix;
  } else if (s === "Tab-") {
    return symbolPrefix + "&#8677;" + symbolSuffix;
  } else if (s === "Return-") {
    return symbolPrefix + "&crarr;" + symbolSuffix;
  } else if (s === "Escape-") {
    return symbolPrefix + "&#9099;" + symbolSuffix;
  } else {
    return s;
  }
};

const sortKey = k => {
  let key = k;
  let modifiers = [];
  while (key.length > 1 && key[1] == "-") {
    modifiers.push(key[0] + "-");
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
  return [modifiers, category, key];
};

const sortKeyComparator = (a, b) => {
  const k1 = a.sortKey;
  const k2 = b.sortKey;
  const c1 = k1[0].length - k2[0].length;
  if (c1 !== 0) return c1;
  for (let i = 0; i < k1[0].length; i++) {
    const c2 = k1[0][i].localeCompare(k2[0][i]);
    if (c2 !== 0) return c2;
  }
  const c3 = k1[1].localeCompare(k2[1]);
  if (c3 !== 0) return c3;
  return k1[2].localeCompare(k2[2]);
};

const collapseNumericRanges = mapping => {
  let m = mapping;
  while (true) {
    const one = m.find(x => x.sortKey[2] === "1");
    if (!one) {
      return m;
    }
    const genericLabel = one.label.replace("1", "n");
    // TODO: a one-pass search for these
    // const zero = m.find(x => x.sortKey[3] === "0" && x.sortKey[2] === one.sortKey[2] && x.label.replace('0', 'n') === one.label.replace('1', 'n'));
    const two = m.find(x => x.sortKey[2] === "2" && x.sortKey[1] == one.sortKey[1] && x.label.replace("2", "n") === genericLabel);
    const three = m.find(x => x.sortKey[2] === "3" && x.sortKey[1] == one.sortKey[1] && x.label.replace("3", "n") === genericLabel);
    const four = m.find(x => x.sortKey[2] === "4" && x.sortKey[1] == one.sortKey[1] && x.label.replace("4", "n") === genericLabel);
    const five = m.find(x => x.sortKey[2] === "5" && x.sortKey[1] == one.sortKey[1] && x.label.replace("5", "n") === genericLabel);
    const six = m.find(x => x.sortKey[2] === "6" && x.sortKey[1] == one.sortKey[1] && x.label.replace("6", "n") === genericLabel);
    const seven = m.find(x => x.sortKey[2] === "7" && x.sortKey[1] == one.sortKey[1] && x.label.replace("7", "n") === genericLabel);
    const eight = m.find(x => x.sortKey[2] === "8" && x.sortKey[1] == one.sortKey[1] && x.label.replace("8", "n") === genericLabel);
    const nine = m.find(x => x.sortKey[2] === "9" && x.sortKey[1] == one.sortKey[1] && x.label.replace("9", "n") === genericLabel);
    if (two && three && four && five && six && seven && eight && nine) {
      m = m.filter(x => !("23456789".includes(x.sortKey[2]) && x.sortKey[1] == one.sortKey[1]));
      one.key = "1..9";
      one.sortKey[2] = "1..9";
      one.label = one.label.replace("1", "1..9");
    } else {
      return m;
    }
  }
  return m;
};

const formatHydra = mapping => {
  console.log(`<html><head><link rel="stylesheet" href="${__dirname}/help.css"/></head><body><div class='hydra'>`);

  let categories = {};
  Object.entries(mapping).forEach(([key, value]) => {
    const path = value.command.split("/");
    const category = path[0] + "/" + path[1];
    if (!categories[category]) categories[category] = [];
    categories[category].push({ ...value, key, sortKey: sortKey(key), label: path[2] });
  });
  let columns = Object.entries(categories).map(([key, value]) => ({
    label: key,
    elements: collapseNumericRanges(value).sort(sortKeyComparator)
  }));
  columns.sort((a, b) => a.label.localeCompare(b.label));

  columns.forEach(column => {
    console.log("<div class='column'>");
    console.log(`<div class='header'>${column.label}</div>`);
    column.elements.forEach(row => {
      let r = `<div class='key'>`;
      row.sortKey[0].forEach(prefix => {
        r += `<span class='prefix'>${htmlForPrefix(prefix)}</span>`;
      });
      r += `${htmlForKey(row.sortKey[2])}</div>`;
      r += `<div class='label ${row.loop ? "" : "exit"}'>${escapeHTML(row.label)}</div>`;
      console.log(r);
    });
    console.log("</div>");
  });

  console.log("</div></body></html>");
};

const formatWhichKey = mapping => {
  console.log(`<html><head><link rel="stylesheet" href="${__dirname}/help.css"/></head><body><div class='whichkey'>`);

  let rows = Object.entries(mapping).map(([key, value]) => {
    const label = value.label || value.command.split("/")[2];
    return { ...value, key, sortKey: sortKey(key), label };
  });
  rows = collapseNumericRanges(rows);
  rows.sort(sortKeyComparator);

  let numberOfGridRows = Math.ceil(Math.sqrt(rows.length));
  rows.forEach((row, rowNo) => {
    const gridColumn = Math.floor(rowNo / numberOfGridRows) + 1;
    const gridRow = (rowNo % numberOfGridRows) + 1;
    console.log(
      `<div class='key' style='grid-row: ${gridRow}; grid-column: ${2 * gridColumn};'><span class='prefix'>${
        row.sortKey[1]
      }</span>${htmlForKey(row.sortKey[3])}</div>`
    );
    console.log(
      `<div class='label ${row.exit ? "exit" : ""}' style='grid-row: ${gridRow}; grid-column: ${2 * gridColumn + 1};'>${escapeHTML(
        row.label
      )}</div>`
    );
  });

  console.log("</div></body></html>");
};

const file = process.argv[2];
const json = require(file);

formatHydra(json.Window.children);
// formatWhichKey(json);
