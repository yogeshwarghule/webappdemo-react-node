import React, { useState } from 'react'
import './App.css'
import Axios from 'axios'

function App() {
  const [name, setName] = useState("")
  const [description, setDescription] = useState("")
  const [age, setAge] = useState(0)
  const [employeeList, setEmployeeList] = useState([])

  // for /updates
  const [newDescription, setNewDescription] = useState("")
  const [newAge, setNewAge] = useState(0)

  const addEmployee = () => {
    const currEmployeeData = {
      name: name,
      description: description,
      age: age
    }
    Axios.post("/api/create", currEmployeeData).then(() => {
      console.log("/api/create sent to backend")
      alert("Entry added to database. Click `Show Employees` to refresh")
      // remove this so that refreshes are via database only
      // setEmployeeList([...employeeList, currEmployeeData])
    }
    )
  }

  const getEmployees = () => {
    Axios.get("/api/read").then((res) => {
      console.log("/api/read sent to backend")
      setEmployeeList(res.data)
    })
  }

  const deleteEmployee = (id) => {
    Axios.delete(`api/delete/${id}`).then((response) => {
      alert("Entry deleted from database. Click 'Show Employees' to refresh")
      // setEmployeeList(employeeList.filter((val) => {return val.id !== id; }))
    })
  }

  const updateEmployee = (id) => {
    Axios.put("/api/update", { id: id, age: newAge, description: newDescription }).then(
      (response) => {
        alert("Entry updated in database. Click 'Show Employees' to refresh")
        // setEmployeeList(
        //   employeeList.map((val) => {
        //     return val.id === id
        //       ? {
        //         id: val.id,
        //         name: val.name,
        //         description: newDescription,
        //         age: newAge
        //       } : val
        //   })
        // )
      }
    )
  }

  return (
    <div className='App'>
      <div className='info'>
        <label>Name: </label>
        <input
          type="text"
          onChange={(event) => {
            setName(event.target.value);
          }}
          required
        />
        <label>Description: </label>
        <input
          type="text"
          onChange={(event) => {
            setDescription(event.target.value);
          }}
          required
        />
        <label>Age: </label>
        <input
          type="number"
          onChange={(event) => {
            setAge(event.target.value);
          }}
          required
        >

        </input>
        <button onClick={addEmployee}>Add Employee
        </button>
        <button onClick={getEmployees}>Show Employees</button>
        <div>

          {employeeList.map((val, key) => {
            return (
              <div className='employeeListing'>
                <div>
                  <h3>ID: {val.id}, Name: {val.name},
                    Description: {val.description},
                    Age: {val.age}
                  </h3>
                  <div>
                    <input type="text" onChange={(event) => setNewDescription(event.target.value)} placeholder="Enter New Desc..." required />
                    <input type="number" onChange={(event) => setNewAge(event.target.value)} placeholder="Enter New Age..." required />

                  </div>
                  <button onClick={() => updateEmployee(val.id)}>Update</button>
                  <button onClick={() => deleteEmployee(val.id)}>Delete</button>
                </div>
              </div>
            )
          })}
        </div>
      </div>
    </div>
  );
}

export default App;