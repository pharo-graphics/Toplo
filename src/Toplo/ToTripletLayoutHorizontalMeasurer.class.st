Class {
	#name : #ToTripletLayoutHorizontalMeasurer,
	#superclass : #ToTripletLayoutMeasurer,
	#category : #'Toplo-Core-TripletLayout'
}

{ #category : #'private - measurement' }
ToTripletLayoutHorizontalMeasurer >> measureExactUsingExcessSpace: aNode [
	"Optimization: don't bother measuring children who are only laid out using excess space.
	These views will get measured later if we have space to distribute."

	totalLength := self isLengthExact
		ifTrue: [ totalLength + aNode marginLength ]
		ifFalse: [ totalLength max: (totalLength + aNode marginLength) ]
]

{ #category : #'private - measurement' }
ToTripletLayoutHorizontalMeasurer >> updateTotalLengthAfterMeasuring: aNode [
	"I update the total length after measuring a given node based on its measured length and margin"
	
	self flag: 'Why accounting for isBreadthExact is needed for the horizontal layout?'.

	totalLength := self isLengthExact
		ifTrue: [ totalLength + aNode measuredLength + aNode marginLength ]
		ifFalse: [ totalLength max: (totalLength + aNode measuredLength + aNode marginLength) ]
]
