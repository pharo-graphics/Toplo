Class {
	#name : #ToPopupWindowEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'state'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'event handling' }
ToPopupWindowEventHandler >> clickEvent: anEvent [
	"state = #ready ifTrue: [
		state := #opened.
		^ self ].
	state ~= #opened ifTrue: [ ^ self ]."
	"anEvent consumed: true.
	anEvent currentTarget close"
]

{ #category : #'event handling' }
ToPopupWindowEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	state := #ready
]

{ #category : #'event handling' }
ToPopupWindowEventHandler >> elementPositionInSpaceChangedEvent:  anEvent [

		state := #closed
]

{ #category : #'event handling' }
ToPopupWindowEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [

		state := #closed
]

{ #category : #'api - accessing' }
ToPopupWindowEventHandler >> eventsToHandle [

	^ {
		  BlClickEvent.
		  BlMouseDownOutsideEvent.
		  BlElementAddedToSceneGraphEvent.
		  BlElementRemovedFromSceneGraphEvent }
]

{ #category : #initialization }
ToPopupWindowEventHandler >> initialize [ 

	super initialize .
	state := #closed
]

{ #category : #'event handling' }
ToPopupWindowEventHandler >> mouseDownOutsideEvent: anEvent [

	anEvent originalEvent target = anEvent currentTarget widget
		ifTrue: [ ^ self ].
	anEvent consumed: true.
	anEvent currentTarget close
]
