const path = require('path');
const { spawn } = require('child_process');
const { chromium } = require('playwright');

(async () => {
  const [, , htmlPath, outMp4, fpsArg] = process.argv;
  const fps = Number(fpsArg || 60);
  const browser = await chromium.launch();
  const page = await browser.newPage({ viewport: { width: 1280, height: 720 }, deviceScaleFactor: 1 });
  await page.goto('file://' + htmlPath);
  await page.waitForTimeout(500);
  const total = await page.evaluate(() => window.TOTAL);
  const ff = spawn('ffmpeg', ['-loglevel', 'error', '-y', '-f', 'image2pipe', '-framerate', String(fps), '-c:v', 'png', '-i', '-',
    '-c:v', 'libx264', '-preset', 'slow', '-crf', '20', '-pix_fmt', 'yuv420p', '-movflags', '+faststart', outMp4], { stdio: ['pipe', 'inherit', 'inherit'] });
  const frames = Math.round(total * fps);
  for (let i = 0; i < frames; i++) {
    await page.evaluate(t => window.render(t), i / fps);
    const buf = await page.screenshot({ type: 'png' });
    if (!ff.stdin.write(buf)) await new Promise(r => ff.stdin.once('drain', r));
  }
  ff.stdin.end();
  await new Promise(r => ff.on('close', r));
  await browser.close();
  console.log(`${frames} frames -> ${outMp4}`);
})();
