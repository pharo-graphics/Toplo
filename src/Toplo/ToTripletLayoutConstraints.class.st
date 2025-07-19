Class {
	#name : #ToTripletLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'weight'
	],
	#category : #'Toplo-Core-TripletLayout'
}

{ #category : #alignment }
ToTripletLayoutConstraints >> alignment [
	^ self horizontal alignment + self vertical alignment
]

{ #category : #initialization }
ToTripletLayoutConstraints >> defaultHorizontal [
	^ ToTripletLayoutConstraintsHorizontal new
]

{ #category : #initialization }
ToTripletLayoutConstraints >> defaultVertical [
	^ ToTripletLayoutConstraintsVertical new
]

{ #category : #initialization }
ToTripletLayoutConstraints >> initialize [
	super initialize.
	
	weight := 1
]

{ #category : #weight }
ToTripletLayoutConstraints >> weight [
	"Return weight that defines how much space an element takes within parent's available space.
	weight can not be nil and is always non negative"
	<return: #Number>

	^ weight
]

{ #category : #weight }
ToTripletLayoutConstraints >> weight: aNumber [
	"Set new weight value that defines how much space an element takes within parent's available space.
	aNumber must be non negative
	aNumber must not be infinite"
		
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Weight must be non negative' ].
	
	self
		assert: [ aNumber < Float infinity ]
		description: [ 'Weight must not be infinite' ].

	weight := aNumber
]
