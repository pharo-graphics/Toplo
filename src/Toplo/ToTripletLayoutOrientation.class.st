Class {
	#name : #ToTripletLayoutOrientation,
	#superclass : #Object,
	#instVars : [
		'layout'
	],
	#category : #'Toplo-Core-TripletLayout'
}

{ #category : #factory }
ToTripletLayoutOrientation class >> horizontal [

	^ ToTripletLayoutHorizontalOrientation new
]

{ #category : #factory }
ToTripletLayoutOrientation class >> vertical [

	^ ToTripletLayoutVerticalOrientation new
]

{ #category : #comparing }
ToTripletLayoutOrientation >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #orientation }
ToTripletLayoutOrientation >> breadthMode [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> breadthProperties: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> breadthSpec: anExtentSpec [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> extentBreadth: breadth lengthSpec: length [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> extentSpecBreadth: breadthSpec lengthSpec: lengthSpec [
	^ self subclassResponsibility
]

{ #category : #comparing }
ToTripletLayoutOrientation >> hash [
	^ self class hash
]

{ #category : #accessing }
ToTripletLayoutOrientation >> inverted [ 

	^ self subclassResponsibility 
]

{ #category : #testing }
ToTripletLayoutOrientation >> isHorizontal [
	^ false
]

{ #category : #testing }
ToTripletLayoutOrientation >> isVertical [
	^ false
]

{ #category : #accessing }
ToTripletLayoutOrientation >> layout [
	^ layout
]

{ #category : #accessing }
ToTripletLayoutOrientation >> layout: aLinearLayout [
	layout := aLinearLayout
]

{ #category : #layout }
ToTripletLayoutOrientation >> layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> lengthLinearProperties: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> lengthMode [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> lengthProperties: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> lengthSpec: anExtentSpec [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> marginBreadth: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> marginLength: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> measureChildWithMargin: child parentSpec: anExtentMeasurementSpec breadthUsed: breadthUsed lengthUsed: lengthUsed [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> measuredBreadth: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> measuredLength: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> minimalBreadth: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> minimalLength: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> paddingBreadth: anElement [
	^ self subclassResponsibility
]

{ #category : #orientation }
ToTripletLayoutOrientation >> paddingLength: anElement [
	^ self subclassResponsibility
]
