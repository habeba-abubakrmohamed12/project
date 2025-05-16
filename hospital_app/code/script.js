const API_BASE_URL = "/api";


document.addEventListener("DOMContentLoaded", () => {

    document.getElementById("add-department-form").addEventListener("submit", handleAddDepartment);

   
});

async function fetchData(endpoint, options = {}) {
    try {
        const response = await fetch(`${API_BASE_URL}${endpoint}`, options);
        if (!response.ok) {
            const errorData = await response.json().catch(() => ({ error: `HTTP error! status: ${response.status}` }));
            console.error(`Error fetching ${endpoint}:`, errorData.error);
            alert(`Error: ${errorData.error || response.statusText}`);
            return null;
        }
        if (response.status === 204 || response.headers.get("content-length") === "0") { 
            return { success: true }; 
        }
        return await response.json();
    } catch (error) {
        console.error(`Network error or JSON parsing error for ${endpoint}:`, error);
        alert(`Network error or JSON parsing error: ${error.message}`);
        return null;
    }
}

function createTable(data, headers, deleteHandler) {
    if (!data || data.length === 0) {
        return "<p>No data available.</p>";
    }
    let table = "<table><thead><tr>";
    headers.forEach(header => table += `<th>${header.label}</th>`);
    if (deleteHandler) {
        table += "<th>Actions</th>";
    }
    table += "</tr></thead><tbody>";
    data.forEach(item => {
        table += "<tr>";
        headers.forEach(header => table += `<td>${item[header.key] !== null && item[header.key] !== undefined ? item[header.key] : "N/A"}</td>`);
        if (deleteHandler) {
            
            table += `<td><button class="delete-btn" onclick="${deleteHandler}(\'${item[headers[0].key]}\')">Delete</button></td>`;
        }
        table += "</tr>";
    });
    table += "</tbody></table>";
    return table;
}


async function loadDepartments() {
    const departments = await fetchData("/departments");
    const headers = [
        { key: "department_id", label: "ID" },
        { key: "name", label: "Name" },
        { key: "floor", label: "Floor" }
    ];
   
    document.getElementById("departments-list").innerHTML = createTable(departments, headers, "handleDeleteDepartment");
}

async function handleAddDepartment(event) {
    event.preventDefault();
    const deptId = document.getElementById("dept-id").value;
    const deptName = document.getElementById("dept-name").value;
    const deptFloor = document.getElementById("dept-floor").value;
    const newDepartment = { department_id: deptId, name: deptName, floor: deptFloor };
    const result = await fetchData("/departments", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(newDepartment)
    });
    if (result && !result.error) {
        loadDepartments(); 
        document.getElementById("add-department-form").reset();
    }
}

async function handleDeleteDepartment(departmentId) {
    if (!confirm(`Are you sure you want to delete department ${departmentId}? This might fail if doctors are assigned to it.`)) return;
    const result = await fetchData(`/departments/${departmentId}`, { method: "DELETE" });
    if (result && result.success) {
        loadDepartments();
    }
}

