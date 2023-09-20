Class {
	#name : #ToElementLook,
	#superclass : #ToAbstractLook,
	#classTraits : 'TBlAnnounceable classTrait',
	#instVars : [
		'next'
	],
	#category : 'Toplo-Theme-Core'
}

{ #category : #accessing }
ToElementLook class >> next: aLook [

	^ self new next: aLook
]

{ #category : #'private event handling' }
ToElementLook >> elementLookEvent: anEvent [

	self next elementLookEvent: anEvent.
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

{ #category : #operating }
ToElementLook >> receiveEvent: aLookEvent [

]

{ #category : #removing }
ToElementLook >> removeLook: aLook previous: previousLook [

	previousLook ifNotNil: [
		self = aLook ifTrue: [
			previousLook next: self next.
			^ self ] ].
	self next removeLook: aLook previous: self
]
