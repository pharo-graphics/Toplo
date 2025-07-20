Class {
	#name : #ToTripletLayoutNode,
	#superclass : #Object,
	#instVars : [
		'element',
		'orientation',
		'linearConstraints'
	],
	#category : #'Toplo-Core-TripletLayout'
}

{ #category : #'accessing - constraints' }
ToTripletLayoutNode >> breadthConstraints [
	^ self orientation breadthProperties: self element
]

{ #category : #'accessing - properties' }
ToTripletLayoutNode >> breadthResizer [
	^ self breadthConstraints resizer
]

{ #category : #accessing }
ToTripletLayoutNode >> constraints [
	^ self element constraints
]

{ #category : #accessing }
ToTripletLayoutNode >> element [
	<return: #BlElement>

	^ element
]

{ #category : #testing }
ToTripletLayoutNode >> hasSpaceAfter [
	"Return true if there should be a divider after this node"
	<return: #Boolean>

	^ true
]

{ #category : #testing }
ToTripletLayoutNode >> hasSpaceBefore [
	"Return true if there should be a divider before this node"
	<return: #Boolean>

	^ true
]

{ #category : #initialization }
ToTripletLayoutNode >> initializeWith: anElement orientation: aToTripletLayoutOrientation [
	element := anElement.
	orientation := aToTripletLayoutOrientation.
	linearConstraints := anElement constraints triplet
]

{ #category : #'accessing - constraints' }
ToTripletLayoutNode >> lengthConstraints [
	^ self orientation lengthProperties: self element
]

{ #category : #'accessing - properties' }
ToTripletLayoutNode >> lengthResizer [
	^ self lengthConstraints resizer
]

{ #category : #'accessing - properties' }
ToTripletLayoutNode >> lengthResizer: aResizer [
	self lengthConstraints resizer: aResizer
]

{ #category : #accessing }
ToTripletLayoutNode >> linearConstraints [
	<return: #ToTripletLayoutConstraints>

	^ linearConstraints
]

{ #category : #'accessing - properties' }
ToTripletLayoutNode >> marginBreadth [
	<return: #Number>

	^ self orientation marginBreadth: self element
]

{ #category : #'accessing - properties' }
ToTripletLayoutNode >> marginLength [
	<return: #Number>

	^ self orientation marginLength: self element
]

{ #category : #measure }
ToTripletLayoutNode >> measure: anExtentSpecOrBlock [
	self element measure: anExtentSpecOrBlock value
]

{ #category : #'accessing - properties' }
ToTripletLayoutNode >> measuredBreadth [
	^ self orientation measuredBreadth: self element
]

{ #category : #'accessing - properties' }
ToTripletLayoutNode >> measuredLength [
	^ self orientation measuredLength: self element
]

{ #category : #accessing }
ToTripletLayoutNode >> orientation [
	<return: #ToTripletLayoutOrientation>

	^ orientation
]

{ #category : #testing }
ToTripletLayoutNode >> shouldUseExcessSpace [
	<return: #Boolean>

	^ self weight > 0
]

{ #category : #'accessing - properties' }
ToTripletLayoutNode >> verticalAlignment [
	^ self linearConstraints vertical alignment
]

{ #category : #'accessing - properties' }
ToTripletLayoutNode >> weight [
	"Weight is only applicable if a child matches parent"
	<return: #Number>

	^ self lengthResizer isMatchParent
		ifTrue: [ self linearConstraints weight ]
		ifFalse: [ 0 ]
]
