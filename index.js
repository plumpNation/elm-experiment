(function (Elm) {
    document.addEventListener('DOMContentLoaded', init);

    function init() {
        setupBanner();
    }

    function setupBanner() {
        const
            bannerNode = document.getElementById('banner'),
            banner     = Elm.Banner.embed(bannerNode);

        // Note: if your Elm module is named "MyThing.Root" you
        // would call "Elm.MyThing.Root.embed(node)" instead.
    }
}(window.Elm));
