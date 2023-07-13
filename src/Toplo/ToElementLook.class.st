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

{ #category : #private }
ToElementLook >> decoratedTextAttributesBuilderFromElement: anElement [

	^ self first textAttributesBuilderFromElement: anElement
]

{ #category : #'private event handling' }
ToElementLook >> elementLookEvent: anEvent [

	self next elementLookEvent: anEvent.
	anEvent sendToLook: self.

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
ToElementLook >> mouseHoverLookEvent: anEvent [


]

{ #category : #'event handling' }
ToElementLook >> mouseLeavedLookEvent: anEvent [

	anEvent target dispatchEvent: (ToInitialLookEvent new copyFrom: anEvent)


]

{ #category : #'event handling' }
ToElementLook >> mousePressedLookEvent: anEvent [


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

{ #category : #private }
ToElementLook >> textAttributesBuilderFromElement: anElement [

	^ self next textAttributesBuilderFromElement: anElement
]

{ #category : #'event handling' }
ToElementLook >> uninstallLookEvent: anEvent [

]
