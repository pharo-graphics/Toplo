Class {
	#name : #ToElementWithPopupEventHandler,
	#superclass : #ToAnchorEventHandler,
	#instVars : [
		'target'
	],
	#category : 'Toplo-Core-Window'
}

{ #category : #'api - accessing' }
ToElementWithPopupEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  BlMouseUpEvent.
		  BlMouseDownEvent.
		  BlMouseUpOutsideEvent.
		  BlElementRemovedFromParentEvent }
]

{ #category : #'mouse handlers' }
ToElementWithPopupEventHandler >> mouseDownEvent: anEvent [

	windowManager mouseDownInElementEvent: anEvent 
]

{ #category : #'mouse handlers' }
ToElementWithPopupEventHandler >> mouseUpEvent: anEvent [

	windowManager mouseUpInElementEvent: anEvent
]

{ #category : #'mouse handlers' }
ToElementWithPopupEventHandler >> mouseUpOutsideEvent: anEvent [

	" 
	if the original event target is the element with popup or
	if the original event target is the popup window then do nothing
	"

	anEvent originalEvent target ifNotNil: [ :originalTarget |
		(originalTarget hasInParentChain: self target) ifTrue: [ ^ self  ].
		(originalTarget hasInParentChain: windowManager currentWindow) ifTrue: [ ^ self ] ].
	
	" ok, mouseUp outside the element and outside of the popup window "
	anEvent consumed: true.
	windowManager currentWindowDo: [:w | w close ]
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

{ #category : #accessing }
ToElementWithPopupEventHandler >> target [

	^ target
]
