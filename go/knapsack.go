package main

import "fmt"

type Item struct {
	size  int
	value int
}

var maxValueAtSize map[int]int

func MaxValue(items []Item, maxSize int) int {
	if _, ok := maxValueAtSize[maxSize]; ok {
		return maxValueAtSize[maxSize]
	}

	var maxValue int = 0
	for _, item := range items {
		if item.size <= maxSize {
			value := MaxValue(items, maxSize-item.size) + item.value
			if value > maxValue {
				maxValue = value
			}
		}
	}
	maxValueAtSize[maxSize] = maxValue
	return maxValue
}

func main() {
	maxValueAtSize = make(map[int]int)
	items := []Item{{2, 5}, {1, 1}, {20, 60}}
	fmt.Println(MaxValue(items, 102))
}
