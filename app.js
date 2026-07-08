// Spica Portal — motion (CSP: script-src 'self'・外部依存ゼロ)
(function(){
  var reduced = matchMedia('(prefers-reduced-motion: reduce)').matches;

  /* ---- star-field ---- */
  var cv = document.getElementById('sky'), cx = cv.getContext('2d'), stars = [], H = 0, W = 0;
  function seed(){
    W = cv.width = innerWidth * devicePixelRatio;
    H = cv.height = innerHeight * devicePixelRatio;
    stars = [];
    var n = Math.floor(innerWidth * innerHeight / 14000);
    for (var i = 0; i < n; i++){
      stars.push({
        x: Math.random(), y: Math.random(),
        r: (Math.random() * 1.1 + .3) * devicePixelRatio,
        a: Math.random() * .5 + .12,
        tw: Math.random() * 6.28, ts: Math.random() * .9 + .25,
        d: Math.random() * .5 + .25
      });
    }
  }
  var scrollY0 = 0;
  function paint(t){
    cx.clearRect(0, 0, W, H);
    for (var i = 0; i < stars.length; i++){
      var s = stars[i];
      var y = (s.y * H - scrollY0 * s.d * devicePixelRatio * .12) % H; if (y < 0) y += H;
      var a = reduced ? s.a : s.a * (0.72 + 0.28 * Math.sin(s.tw + t * .00045 * s.ts));
      cx.globalAlpha = a;
      cx.fillStyle = '#b9d2ff';
      cx.beginPath(); cx.arc(s.x * W, y, s.r, 0, 6.28); cx.fill();
    }
    cx.globalAlpha = 1;
  }
  seed(); paint(0);
  addEventListener('resize', function(){ seed(); paint(0); });
  addEventListener('scroll', function(){ scrollY0 = scrollY; if (reduced) paint(0); }, {passive:true});
  if (!reduced) (function loop(t){ paint(t || 0); requestAnimationFrame(loop); })();

  /* ---- scroll reveals ---- */
  var io = new IntersectionObserver(function(es){
    es.forEach(function(e){ if (e.isIntersecting){ e.target.classList.add('in'); io.unobserve(e.target); } });
  }, {threshold:.12, rootMargin:'0px 0px -6% 0px'});
  document.querySelectorAll('.rv').forEach(function(el, i){
    el.style.transitionDelay = Math.min(i % 6 * 60, 240) + 'ms';
    io.observe(el);
  });

  /* ---- prompter demo: constant-velocity loop（デモのないページではスキップ） ---- */
  var script = document.getElementById('script');
  if (script && !reduced){
    var clone = script.cloneNode(true); clone.removeAttribute('id'); clone.setAttribute('aria-hidden','true');
    script.appendChild(document.createElement('br'));
    while (clone.firstChild) script.appendChild(clone.firstChild);
    var y = 0, last = null, SPEED = 34;
    function step(t){
      if (last !== null){
        y += SPEED * (t - last) / 1000;
        var hLoop = script.scrollHeight / 2;
        if (y >= hLoop) y -= hLoop;
        script.style.transform = 'translateY(' + (-y) + 'px)';
      }
      last = t; requestAnimationFrame(step);
    }
    requestAnimationFrame(step);
  }
})();
