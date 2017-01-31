const {utils: Cu} = Components;
const {sendKey} = Cu.import(`${__dirname}/shared.js?${Math.random()}`, {});

vimfx.listen('getSelection', (willRemove, callback) => {
  let selection = content.getSelection();
  let s = selection.toString();
  if (willRemove) {
    selection.removeAllRanges();
  }
  callback(s);
});

vimfx.listen('sendKey', ({key}) => {
  sendKey(content, key);
});
