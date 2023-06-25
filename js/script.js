let display = document.getElementById('display');

function appendValue(value) {
    display.value += value;
}

async function calculate() {
    try {
        const data = display.value.split(";");

        const response = await fetch('http://0.0.0.0:8000/result', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        });

        if (response.ok) {
            const history = await response.json();
            display.value = history.result;
        } else {
            throw new Error('Failed to get the result.');
        }
    } catch (error) {
        display.value = 'Error';
    }
}

async function downloadHistory() {
    try {
        const response = await fetch('http://0.0.0.0:8000/history');

        if (response.ok) {
            let text = await response.text();
            text = text.replace(/"/g, "");

            const lines = text.split(/\\r\\n/);
            
            const csvContent = lines.map(line => {
                const fields = line.split('#');
                const escapedFields = fields.map(field => {
                    if (field.includes(',')) {
                        return `"${field}"`;
                    }
                    return field;
                });
                return escapedFields.join(',');
            });

            const blob = new Blob([csvContent.join('\n')], { type: 'text/csv' });

            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'history.csv';
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            window.URL.revokeObjectURL(url);
        } else {
            throw new Error('Failed to download history.');
        }
    } catch (error) {
        console.error(error);
    }
}

function clearDisplay() {
    display.value = '';
}

function eraseCharacter() {
    display.value = display.value.slice(0, -1);
}