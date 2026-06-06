const app = document.getElementById('app');
let plannerData = {};

function showUI() {
    app.classList.remove('hidden');
}

function hideUI() {
    app.classList.add('hidden');
}

window.addEventListener('message', function(event) {
    if (!event.data) return;

    if (event.data.action === 'open') {
        plannerData = event.data.payload || {};
        hydrateUI(plannerData);
        showUI();
    }

    if (event.data.action === 'hide') {
        hideUI();
    }
});

document.addEventListener('DOMContentLoaded', function() {
    hideUI();

    document.querySelectorAll('.nav').forEach((btn) => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.nav').forEach((b) => b.classList.remove('active'));
            document.querySelectorAll('.tab').forEach((t) => t.classList.remove('active'));

            btn.classList.add('active');
            document.getElementById(btn.dataset.tab).classList.add('active');
        });
    });
});

document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') closeUI();
});

function closeUI() {
    hideUI();

    fetch(`https://${GetParentResourceName()}/close`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({})
    });
}

function hydrateUI(data) {
    const marriage = data.marriage || {};
    const plan = data.plan || {};
    const account = data.account || {};
    const venues = data.venues || [];

    document.getElementById('marriageStatus').textContent = marriage.status || 'No record';
    document.getElementById('currentVenue').textContent = plan.venue || 'Not booked';
    document.getElementById('budgetText').textContent = '$' + (plan.budget || 0);
    document.getElementById('accountBalance').textContent = '$' + (account.balance || 0);

    const venueList = document.getElementById('venueList');
    venueList.innerHTML = '';

    venues.forEach((venue) => {
        const card = document.createElement('div');
        card.className = 'venueCard';
        card.innerHTML = `
            <h3>${venue.name}</h3>
            <p>Price: $${venue.price}</p>
            <button onclick="bookVenue('${venue.id}')">Book Venue</button>
        `;
        venueList.appendChild(card);
    });
}

function createPlan() {
    const data = {
        venue: document.getElementById('planVenue').value,
        budget: document.getElementById('planBudget').value,
        weddingDate: document.getElementById('planDate').value,
        theme: document.getElementById('planTheme').value
    };

    fetch(`https://${GetParentResourceName()}/createPlan`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    });
}

function bookVenue(venueId) {
    fetch(`https://${GetParentResourceName()}/bookVenue`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ venueId })
    });
}

function inviteGuest() {
    fetch(`https://${GetParentResourceName()}/inviteGuest`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ playerId: document.getElementById('guestId').value })
    });
}

function openSharedAccount() {
    fetch(`https://${GetParentResourceName()}/openSharedAccount`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({})
    });
}

function depositShared() {
    fetch(`https://${GetParentResourceName()}/depositShared`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ amount: document.getElementById('depositAmount').value })
    });
}

function withdrawShared() {
    fetch(`https://${GetParentResourceName()}/withdrawShared`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ amount: document.getElementById('withdrawAmount').value })
    });
}
