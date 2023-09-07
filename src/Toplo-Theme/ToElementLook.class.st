Class {
	#name : #ToElementLook,
	#superclass : #ToAbstractLook,
	#classTraits : 'TBlAnnounceable classTrait',
	#instVars : [
		'next'
	],
	#category : #'Toplo-Theme-Core'
}

{ #category : #accessing }
ToElementLook class >> next: aLook [

	^ self new next: aLook
]

{ #category : #'event handling' }
ToElementLook >> clickLookEvent: anEvent [


]

{ #category : #'event handling' }
ToElementLook >> closeLookEvent: anEvent [
]

{ #category : #'event handling' }
ToElementLook >> disabledLookEvent: anEvent [


]

{ #category : #'private event handling' }
ToElementLook >> elementLookEvent: anEvent [

	self next elementLookEvent: anEvent clone.
	anEvent sendToLook: self.

]

{ #category : #'event handling' }
ToElementLook >> focusedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToElementLook >> hoveredLookEvent: anEvent [


]

{ #category : #'event handling' }
ToElementLook >> initialLookEvent: anEvent [


]

{ #category : #'event handling' }
ToElementLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent
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
ToElementLook >> openLookEvent: anEvent [
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
ToElementLook >> selectedLookEvent: anEvent [

]

{ #category : #'event handling' }
ToElementLook >> stateValueChangeLookEvent: anEvent [
]

{ #category : #'event handling' }
ToElementLook >> uninstallLookEvent: anEvent [

	super uninstallLookEvent: anEvent
]

{ #category : #'property value change' }
ToElementLook >> valueOf: anObject in: anElement [

	^ anObject isClosure
		  ifTrue: [ anObject value: anElement ]
		  ifFalse: [ anObject ]
]
