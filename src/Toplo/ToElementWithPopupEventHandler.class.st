Class {
	#name : #ToElementWithPopupEventHandler,
	#superclass : #ToAnchorEventHandler,
	#instVars : [
		'target'
	],
	#category : 'Toplo-Core-Window'
}

{ #category : #'event handling' }
ToElementWithPopupEventHandler >> closeWindow [

	windowHandler closeWindow
]

{ #category : #'event handling' }
ToElementWithPopupEventHandler >> elementPositionInSpaceChangedEvent: anEvent [

	windowHandler closeWindow
]

{ #category : #'api - accessing' }
ToElementWithPopupEventHandler >> eventsToHandle [

	^ super eventsToHandle , { BlMouseUpEvent. BlMouseDownEvent. BlMouseUpOutsideEvent .  BlElementRemovedFromParentEvent }
]

{ #category : #'mouse handlers' }
ToElementWithPopupEventHandler >> mouseDownEvent: anEvent [

	windowHandler mouseDownInElementEvent: anEvent 
]

{ #category : #'mouse handlers' }
ToElementWithPopupEventHandler >> mouseUpEvent: anEvent [

	windowHandler mouseUpInElementEvent: anEvent
]

{ #category : #'mouse handlers' }
ToElementWithPopupEventHandler >> mouseUpOutsideEvent: anEvent [

	" 
	if the original event target is the element with popup or
	if the original event target is the popup window then do nothing
	"

	anEvent originalEvent target ifNotNil: [ :originalTarget |
		(originalTarget hasInParentChain: target) ifTrue: [ ^ self  ].
		(originalTarget hasInParentChain: windowHandler currentWindow) ifTrue: [ ^ self ] ].
	
	" ok, mouseUp outside the element and outside of the popup window "
	anEvent consumed: true.
	self closeWindow
]

{ #category : #'api - hooks' }
ToElementWithPopupEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	target := anElement.
	target allowMousePickOutsideEvent.
]

{ #category : #'api - hooks' }
ToElementWithPopupEventHandler >> onUninstalledIn: anElement [

	target := nil.
	super onUninstalledIn: anElement.

]
