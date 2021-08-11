function foo(num: number, arr: []) {
  if (num > 0) {
    let x = [];
    for (let i = 0; i < arr.length; ++i) {
      x.push({ i = i, k = arr[i] });
    }
    return x
  } else {
    return []
  }
}
