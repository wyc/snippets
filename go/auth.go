package main

import (
	"fmt"
	"log"
	"net/http"
)

type Manager struct {
	ID      int64
	CanHire bool
	CanFire bool
}

type Employee struct {
	ID        int64
	ManagerID int64
	Title     string
	Salary    float64
}

type User struct {
	ID           int64
	Email        string
	PasswordHash string
}

// User if the request has a valid user session, nil and error otherwise
func RequestToUser(r *http.Request) (*User, error) {
	return &User{Email: "person@company.com", PasswordHash: "0xdeadbeef"}, nil
}

// Manager role if the User has one, nil and error otherwise
func (u User) GetManager() (*Manager, error) {
	return &Manager{CanHire: true, CanFire: false}, nil
}

// Employee role if the User has one, nil and error otherwise
func (u User) GetEmployee() (*Employee, error) {
	return &Employee{Title: "Paper Pusher", Salary: 100000.00}, nil
}

func ManagerInfo(w http.ResponseWriter, r *http.Request, m Manager) (err error) {
	_, err = w.Write([]byte(fmt.Sprintf("Can Hire: %v\nCan Fire: %v", m.CanHire, m.CanFire)))
	return err
}

func EmployeeInfo(w http.ResponseWriter, r *http.Request, e Employee) (err error) {
	_, err = w.Write([]byte(fmt.Sprintf("Title: %v\nSalary: $%0.2f", e.Title, e.Salary)))
	return err
}

func UserInfo(w http.ResponseWriter, r *http.Request, u User) (err error) {
	_, err = w.Write([]byte(fmt.Sprintf("Email: %v", u.Email)))
	return err
}

func main() {
	// AddIdentityResolverHTTP(User{}, RequestToUser)

	// AddRoleResolver(User.GetManager)
	// AddRoleResolver(User.GetEmployee)

	// http.Handle("/manager", AuthedHTTP(ManagerInfo))
	// http.Handle("/employee", AuthedHTTP(EmployeeInfo))
	// http.Handle("/user", AuthedHTTP(UserInfo))

	http.Handle("/manager", managerHandler(ManagerInfo))
	http.Handle("/employee", employeeHandler(EmployeeInfo))
	http.Handle("/user", userHandler(UserInfo))
	log.Println("Listening on :8000")
	err := http.ListenAndServe(":8000", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
