// DedSec Market - by InvisiblePresence
(function() {
    console.log('[DedSec] Listo');
    
    function addCart() {
        const btn = document.createElement('button');
        btn.innerHTML = '🛒';
        btn.style.cssText = 'background:none;border:none;font-size:24px;cursor:pointer';
        btn.onclick = () => alert('DedSec Market - by InvisiblePresence');
        document.querySelector('.main-nav-bar')?.appendChild(btn);
    }
    
    setTimeout(addCart, 3000);
})();
