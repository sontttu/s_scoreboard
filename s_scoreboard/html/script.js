window.addEventListener('message', (event) => {
    if (event.data.type === 'ui') {
        if (event.data.display) {
            document.getElementById('scoreboard').classList.add('visible');
        } else {
            document.getElementById('scoreboard').classList.remove('visible');
        }
    } else if (event.data.type === 'players') {
        if (Array.isArray(event.data.players)) {
            updateScoreboard(event.data.players);
        } else {
            console.warn('scoreboard: players data is not an array:', event.data.players);
            updateScoreboard([]);
        }
    }
});

function updateScoreboard(players) {
    const jobsContainer = document.getElementById('jobs-container');
    jobsContainer.innerHTML = '';

    const playerCount = players.length;
    document.getElementById('players-count').textContent = playerCount;

    const jobCounts = {};

    for (const player of players) {
        const job = player.job || "tuntematon";
        jobCounts[job] = (jobCounts[job] || 0) + 1;
    }

    const jobs = [
        { name: 'Virkavalta', iconClass: 'fas fa-shield-alt', color: '#0000FF', key: 'police' },
        { name: 'Bennys', iconClass: 'fas fa-wrench', color: '#FFA500', key: 'bennys' },
        { name: 'Mekaanikko', iconClass: 'fas fa-cogs', color: '#00FF00', key: 'mechanic' },
        { name: 'Taxi', iconClass: 'fas fa-taxi', color: '#FF00FF', key: 'taxi' }
    ];

    for (const job of jobs) {
        const count = jobCounts[job.key] || 0;

        const row = document.createElement('div');
        row.className = 'job-row';

        const icon = document.createElement('i');
        icon.className = 'job-icon ' + job.iconClass;
        icon.style.color = job.color;
        row.appendChild(icon);

        const name = document.createElement('div');
        name.className = 'job-name';
        name.style.color = job.color;
        name.textContent = job.name;
        row.appendChild(name);

        const countDiv = document.createElement('div');
        countDiv.className = 'job-count';
        countDiv.textContent = count;
        row.appendChild(countDiv);

        jobsContainer.appendChild(row);
    }
}