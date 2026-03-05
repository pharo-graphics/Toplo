Class {
	#name : #ToCustomResizeGrip,
	#superclass : #ToResizeGrip,
	#instVars : [
		'dragger',
		'cursorFactory'
	],
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #accessing }
ToCustomResizeGrip >> cursorFactory: anObject [

	cursorFactory := anObject
]

{ #category : #'mouse processing' }
ToCustomResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	dragger ifNil: [ ^ self ].
	dragger
		value: anElement
		value: deltaFromInitialPosition
		value: initialPosition
		value: initialExtent
]

{ #category : #accessing }
ToCustomResizeGrip >> dragger: aValuable [
	" aValuable has 4 args: the target, the dragged delta; the initial dragging position and the initial dragging extent  "

	dragger := aValuable
]

{ #category : #accessing }
ToCustomResizeGrip >> resizeCursor [

	^ cursorFactory ifNotNil: [ :factory | factory cull: self ]
]
