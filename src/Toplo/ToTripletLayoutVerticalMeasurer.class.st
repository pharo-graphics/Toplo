Class {
	#name : #ToTripletLayoutVerticalMeasurer,
	#superclass : #ToTripletLayoutMeasurer,
	#category : #'Toplo-Core-TripletLayout'
}

{ #category : #'private - measurement' }
ToTripletLayoutVerticalMeasurer >> measureExactUsingExcessSpace: aNode [
	"Optimization: don't bother measuring children who are only laid out using excess space.
	These views will get measured later if we have space to distribute."

	totalLength := totalLength max: (totalLength + aNode marginLength)
]

{ #category : #'private - measurement' }
ToTripletLayoutVerticalMeasurer >> updateTotalLengthAfterMeasuring: aNode [
	"I update the total length after measuring a given node based on its measured length and margin"

	totalLength := totalLength max: (totalLength + aNode measuredLength + aNode marginLength)
]
