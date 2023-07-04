Class {
	#name : #ToElementLook,
	#superclass : #ToAbstractElementLook,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Theme-Skins'
}

{ #category : #accessing }
ToElementLook class >> next: aLook [

	^ self new next: aLook
]

{ #category : #private }
ToElementLook >> borderBuilderFromElement: anElement [

	^ BlBorderBuilder new
		  paint: anElement toTheme colorBorder;
		  width: anElement toTheme lineWidth;
		  lineCap: BlStrokeLineCap butt;
		  lineJoin: BlStrokeLineJoin miter;
		  miterLimit: 4.0;
		  dashOffset: 0
]

{ #category : #'event handling' }
ToElementLook >> elementAddedToSceneGraphEvent: anEvent [

	self next ifNil: [ ^ self ].
	self next elementAddedToSceneGraphEvent: anEvent
	
]

{ #category : #'event handling' }
ToElementLook >> elementRemovedFromSceneGraphEvent: anEvent [

	self next ifNil: [ ^ self ].
	self next elementRemovedFromSceneGraphEvent: anEvent

]

{ #category : #'event handling' }
ToElementLook >> elementStateEvent: anEvent [

	anEvent sendToLook: self
]

{ #category : #accessing }
ToElementLook >> next [

	^ next
]

{ #category : #accessing }
ToElementLook >> next: aLook [

	next := aLook
]
