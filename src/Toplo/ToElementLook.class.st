Class {
	#name : #ToElementLook,
	#superclass : #ToAbstractElementLook,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Core-Theme-Looks'
}

{ #category : #accessing }
ToElementLook class >> next: aLook [

	^ self new next: aLook
]

{ #category : #'event handling' }
ToElementLook >> checkedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToElementLook >> clickLookEvent: anEvent [


]

{ #category : #'private event handling' }
ToElementLook >> elementLookEvent: anEvent [

	self next elementLookEvent: anEvent clone.
	anEvent sendToLook: self.

]

{ #category : #'event handling' }
ToElementLook >> hoveredLookEvent: anEvent [


]

{ #category : #'event handling' }
ToElementLook >> initialLookEvent: anEvent [


]

{ #category : #'event handling' }
ToElementLook >> installLookEvent: anEvent [

]

{ #category : #testing }
ToElementLook >> isNull [

	^ false
]

{ #category : #'event handling' }
ToElementLook >> leavedLookEvent: anEvent [


]

{ #category : #accessing }
ToElementLook >> next [

	^ next
]

{ #category : #accessing }
ToElementLook >> next: aLook [

	next := aLook
]

{ #category : #'event handling' }
ToElementLook >> pressedLookEvent: anEvent [


]

{ #category : #removing }
ToElementLook >> removeLook: aLook previous: previousLook [

	previousLook ifNotNil: [
		self = aLook ifTrue: [
			previousLook next: self next.
			^ self ] ].
	self next removeLook: aLook previous: self
]

{ #category : #'event handling' }
ToElementLook >> uncheckedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToElementLook >> uninstallLookEvent: anEvent [

]
