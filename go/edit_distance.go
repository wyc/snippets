package main

import "fmt"

func EditDistance(A []byte, B []byte) int {
	if len(A) == 0 {
		return len(B)
	} else if len(B) == 0 {
		return len(A)
	} else if A[0] == B[0] {
		return EditDistance(A[1:], B[1:])
	}

	replaceCost := EditDistance(A[1:], B[1:]) + 1
	insertCost := EditDistance(A, B[1:]) + 1
	deleteCost := EditDistance(A[1:], B) + 1

	minCost := replaceCost
	if insertCost < minCost {
		minCost = insertCost
	}
	if deleteCost < minCost {
		minCost = deleteCost
	}

	return minCost
}

func main() {
	fmt.Println(EditDistance([]byte("SLANDER"), []byte("ISLANDER")))
}
