package main

import "fmt"

func Sum(xs []int) int {
	var sum int = 0
	for _, x := range xs {
		sum += x
	}
	return sum
}

func Badness(wordLengths []int, lineLength int) int {
	sum := Sum(wordLengths)
	var rv int = 0
	if sum > lineLength {
		rv = 10000 * (sum - lineLength)
	} else {
		t := lineLength - sum
		rv = t * t * t
	}

	return rv
}

type BadnessInput struct {
	wordLengths *[]int
	lineLength  int
}

var badnessMemo map[BadnessInput]int

func MinBadness(wordLengths []int, lineLength int) int {
	bi := BadnessInput{&wordLengths, lineLength}
	if len(wordLengths) == 0 {
		return 0
	} else if _, ok := badnessMemo[bi]; ok {
		return badnessMemo[bi]
	}

	var minBadness int = -1
	for i := 1; i < 1+len(wordLengths); i++ {
		badness := MinBadness(wordLengths[i:], lineLength) +
			Badness(wordLengths[0:i], lineLength)

		if minBadness < 0 || badness < minBadness {
			minBadness = badness
		}
	}
	badnessMemo[bi] = minBadness
	return minBadness
}

func main() {
	badnessMemo = make(map[BadnessInput]int)
	fmt.Println(MinBadness([]int{9, 1, 1, 2, 3, 4, 4, 6, 5, 3, 6, 4}, 10))
}
