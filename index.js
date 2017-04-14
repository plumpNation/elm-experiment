(function (Elm) {
    document.addEventListener('DOMContentLoaded', init);

    function init() {
        setupBanner();
        setupContent();
    }

    function setupBanner() {
        const
            node   = document.getElementById('banner'),
            banner = Elm.Banner.embed(node);
    }

    function setupContent() {
        const
            node   = document.getElementById('content'),
            banner = Elm.Content.embed(node);
    }
}(window.Elm));
