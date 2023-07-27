Class {
	#name : #ToElementLook,
	#superclass : #ToAbstractLook,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #accessing }
ToElementLook class >> next: aLook [

	^ self new next: aLook
]

{ #category : #'private event handling' }
ToElementLook >> elementLookEvent: anEvent [

	self next elementLookEvent: anEvent clone.
	anEvent sendToLook: self.

]

{ #category : #testing }
ToElementLook >> isNull [

	^ false
]

{ #category : #accessing }
ToElementLook >> next [

	^ next
]

{ #category : #accessing }
ToElementLook >> next: aLook [

	next := aLook
]

{ #category : #removing }
ToElementLook >> removeLook: aLook previous: previousLook [

	previousLook ifNotNil: [
		self = aLook ifTrue: [
			previousLook next: self next.
			^ self ] ].
	self next removeLook: aLook previous: self
]
