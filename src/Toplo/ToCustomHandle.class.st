Class {
	#name : #ToCustomHandle,
	#superclass : #ToHandle,
	#instVars : [
		'dragger',
		'cursorFactory'
	],
	#category : #'Toplo-Layout-Support-Handles'
}

{ #category : #accessing }
ToCustomHandle >> cursorFactory: anObject [

	cursorFactory := anObject
]

{ #category : #'mouse processing' }
ToCustomHandle >> dragBy: deltaFromInitialPosition [

	dragger ifNil: [ ^ self ].
	dragger
		value: gripTarget
		value: deltaFromInitialPosition
		value: initialPosition
		value: initialExtent
]

{ #category : #accessing }
ToCustomHandle >> dragger: aValuable [
	" aValuable has 4 args: the target, the dragged delta; the initial dragging position and the initial dragging extent  "

	dragger := aValuable
]

{ #category : #accessing }
ToCustomHandle >> handleCursor [

	^ cursorFactory ifNotNil: [ :factory | factory cull: self ]
]
