const app = document.getElementById('app');

window.addEventListener('message', function(event) {
    if (event.data.action === 'open') app.classList.remove('hidden');
    if (event.data.action === 'hide') app.classList.add('hidden');
});

document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') closeUI();
});

function closeUI() {
    app.classList.add('hidden');

    fetch(`https://${GetParentResourceName()}/close`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({})
    });
}
