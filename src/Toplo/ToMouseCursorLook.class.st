Class {
	#name : #ToMouseCursorLook,
	#superclass : #ToDefaultElementLook,
	#instVars : [
		'previousCursor',
		'hoverCursor'
	],
	#category : #'Toplo-Core-Theme-Looks'
}

{ #category : #accessing }
ToMouseCursorLook class >> next: aLook [

	^ self new next: aLook
]

{ #category : #accessing }
ToMouseCursorLook >> hoverCursor [

	^ hoverCursor
]

{ #category : #accessing }
ToMouseCursorLook >> hoverCursor: aValuable [

	hoverCursor := aValuable
]

{ #category : #'event handling' }
ToMouseCursorLook >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	self hoverCursor ifNil: [ ^ self ].

	anEvent elementDo: [ :e | 
		(self hoverCursor value: e) ifNotNil: [ :c |		
			previousCursor := e mouseCursor.
			e mouseCursor: (self hoverCursor value: e) ] ]
]

{ #category : #'event handling' }
ToMouseCursorLook >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	previousCursor ifNil: [ ^ self ].

	anEvent elementDo: [ :e | 
		e mouseCursor: previousCursor.
		previousCursor := nil ]
]
