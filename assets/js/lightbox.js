document.addEventListener("DOMContentLoaded", () => {
    const overlay = document.getElementById("gallery-lightbox");
    if (!overlay) return;

    const image = overlay.querySelector(".lightbox-image");
    const caption = overlay.querySelector(".lightbox-caption");
    const closeButton = overlay.querySelector(".lightbox-close");

    const openLightbox = (src, alt, cap) => {
        image.src = src;
        image.alt = alt || "";
        caption.textContent = cap || "";
        overlay.classList.add("is-visible");
        overlay.setAttribute("aria-hidden", "false");
        document.body.classList.add("lightbox-open");
    };

    const closeLightbox = () => {
        overlay.classList.remove("is-visible");
        overlay.setAttribute("aria-hidden", "true");
        document.body.classList.remove("lightbox-open");
        image.src = "";
        image.alt = "";
        caption.textContent = "";
    };

    document.querySelectorAll(".gallery-lightbox-trigger").forEach((trigger) => {
        trigger.addEventListener("click", (event) => {
            event.preventDefault();
            openLightbox(
                trigger.dataset.lightboxSrc,
                trigger.dataset.lightboxAlt,
                trigger.dataset.lightboxCaption
            );
        });
    });

    overlay.addEventListener("click", (event) => {
        if (event.target === overlay || event.target === closeButton) {
            closeLightbox();
        }
    });

    document.addEventListener("keydown", (event) => {
        if (event.key === "Escape" && overlay.classList.contains("is-visible")) {
            closeLightbox();
        }
    });
});
