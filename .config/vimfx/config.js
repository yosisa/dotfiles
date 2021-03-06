const {classes: Cc, interfaces: Ci, utils: Cu} = Components;
const gClipboardHelper = Cc['@mozilla.org/widget/clipboardhelper;1']
      .getService(Ci.nsIClipboardHelper);
const {Preferences} = Cu.import('resource://gre/modules/Preferences.jsm', {});

const {sendKey} = Cu.import(`${__dirname}/shared.js?${Math.random()}`, {});

const FIREFOX_PREFS = {
  'general.smoothScroll': true,
  'general.smoothScroll.lines': false,
  'toolkit.scrollbox.verticalScrollDistance': 5,
  'browser.startup.page': 3,
  'browser.tabs.animate': false,
  'browser.search.suggest.enabled': true,
  'browser.urlbar.suggest.searches': true,
  'browser.urlbar.maxRichResults': 20,
  'browser.tabs.remote.force-enable': true,
  'dom.ipc.processCount': 4
};

const VIMFX_PREFS = {
  'prevent_autofocus': true
};

const MAPPINGS = {
  'copy_current_url': '',
  'go_home': '',
  'stop': '<c-escape>',
  'stop_all': 'a<c-escape>',

  'history_back': 'h',
  'history_forward': 'l',
  'history_list': 'gh',

  'scroll_left': 'H',
  'scroll_right': 'L',
  'scroll_half_page_down': '<c-f>',
  'scroll_half_page_up': '<c-b>',
  'mark_scroll_position': 'mm',
  'scroll_to_mark': 'gm',

  'tab_new': 't',
  'tab_new_after_current': 'T',
  'tab_close': 'd x',
  'tab_close_to_end': 'D gx$',
  'tab_restore': 'u',
  'tab_restore_list': 'U',
  'tab_select_previous': ',',
  'tab_select_next': '.',
  'tab_select_most_recent': 'z',
  'tab_select_first_non_pinned': '^',
  'tab_select_last': '$',

  'enter_mode_ignore': 'I',
  'quote': 'i',

  'custom.mode.normal.search_selected_text': 's',
  'custom.mode.normal.copy_selection_or_url': 'yy',
  'custom.mode.normal.copy_as_markdown': 'ym',
  'custom.mode.normal.click_toolbar_pocket': 'mp',
  'custom.mode.normal.send_up': '<force><c-p>',
  'custom.mode.normal.send_down': '<force><c-n>',
};

const {commands} = vimfx.modes.normal;

function _sendKey(key, {vim, event}) {
  if (vim.isUIEvent(event)) {
    sendKey(vim.window, key);
  } else {
    vimfx.send(vim, 'sendKey', {key});
  }
}

const CUSTOM_COMMANDS = [
  [
    {
      name: 'search_selected_text',
      description: 'Search for the selected text'
    }, ({vim}) => {
      vimfx.send(vim, 'getSelection', true, selection => {
        if (selection != '') {
          vim.window.switchToTabHavingURI(`https://www.google.co.jp/search?q=${selection}`, true);
        }
      });
    }
  ],
  [
    {
      name: 'copy_as_markdown',
      description: 'Copy title and url as Markdown',
      category: 'location',
      order: commands.copy_current_url.order + 2
    }, ({vim}) => {
      let url = vim.window.gBrowser.selectedBrowser.currentURI.spec;
      let title = vim.window.gBrowser.selectedBrowser.contentTitle;
      let s = `[${title}](${url})`;
      gClipboardHelper.copyString(s);
      vim.notify(`Copied to clipboard: ${s}`);
    }
  ],
  [
    {
      name: 'copy_selection_or_url',
      description: 'Copy the selection or current url',
      category: 'location',
      order: commands.copy_current_url.order + 1
    }, ({vim}) => {
      vimfx.send(vim, 'getSelection', true, selection => {
        if (selection == '') {
          selection = vim.window.gBrowser.selectedBrowser.currentURI.spec;
        }
        gClipboardHelper.copyString(selection);
        vim.notify(`Copied to clipboard: ${selection}`);
      });
    }
  ],
  [
    {
      name: 'click_toolbar_pocket',
      description: 'Click toolbar button [Pocket]'
    }, ({vim}) => {
      vim.window.document.getElementById('pocket-button').click();
    }
  ],
  [
    {
      name: 'send_up',
      description: 'Send the <up> key'
    },
    _sendKey.bind(null, 'up')
  ],
  [
    {
      name: 'send_down',
      description: 'Send the <down> key'
    },
    _sendKey.bind(null, 'down')
  ]
];

Object.entries(VIMFX_PREFS).forEach(([name, value]) => {
  vimfx.set(name, value);
});

CUSTOM_COMMANDS.forEach(([options, fn]) => {
  vimfx.addCommand(options, fn);
});

Object.entries(MAPPINGS).forEach(([cmd, key]) => {
  if (!cmd.includes('.')) {
    cmd = `mode.normal.${cmd}`;
  }
  vimfx.set(cmd, key);
});

Preferences.set(FIREFOX_PREFS);
