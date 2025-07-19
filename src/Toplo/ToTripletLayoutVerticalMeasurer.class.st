Class {
	#name : #ToTripletLayoutVerticalMeasurer,
	#superclass : #ToTripletLayoutMeasurer,
	#category : #'Toplo-Core-TripletLayout'
}

{ #category : #measurement }
ToTripletLayoutVerticalMeasurer >> baselineMeasure [
]

{ #category : #'private - measurement' }
ToTripletLayoutVerticalMeasurer >> measureExactUsingExcessSpace: aNode [
	"Optimization: don't bother measuring children who are only laid out using excess space.
	These views will get measured later if we have space to distribute."

	totalLength := totalLength max: (totalLength + aNode marginLength).
	skippedMeasure := true
]

{ #category : #'private - measurement' }
ToTripletLayoutVerticalMeasurer >> prepareForWeightedMeasure [
	totalLength := 0.0
]

{ #category : #measurement }
ToTripletLayoutVerticalMeasurer >> processBaseline: aNode breadth: aChildBreadth [
]

{ #category : #'private - measurement' }
ToTripletLayoutVerticalMeasurer >> updateTotalLengthAfterMeasuring: aNode [
	"I update the total length after measuring a given node based on its measured length and margin"

	totalLength := totalLength max: (totalLength + aNode measuredLength + aNode marginLength)
]

{ #category : #'private - measurement' }
ToTripletLayoutVerticalMeasurer >> updateTotalLengthFromLargestChild: aNode [
	"I update the total length taking into account the length of the largest child"

	totalLength := totalLength max: (totalLength + largestChildLength + aNode marginLength)
]
