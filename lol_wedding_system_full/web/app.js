window.addEventListener('message', function(event) {
    if (event.data.action === 'open') {
        document.body.style.display = 'flex'
    }
})

document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
        fetch(`https://${GetParentResourceName()}/close`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({})
        })

        document.body.style.display = 'none'
    }
})
