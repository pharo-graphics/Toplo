Class {
	#name : #ToElementWithPopupEventHandler,
	#superclass : #ToAnchorEventHandler,
	#instVars : [
		'target'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - accessing' }
ToElementWithPopupEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  BlMouseUpEvent.
		  BlMouseDownEvent.
		  windowManager autoClosePickOutsideEventClass}
]

{ #category : #'mouse handlers' }
ToElementWithPopupEventHandler >> mouseDownEvent: anEvent [

	windowManager mouseDownInElementEvent: anEvent 
]

{ #category : #'mouse handlers' }
ToElementWithPopupEventHandler >> mouseDownOutsideEvent: anEvent [

	self pickOutsideEvent: anEvent
]

{ #category : #'mouse handlers' }
ToElementWithPopupEventHandler >> mouseUpEvent: anEvent [

	windowManager mouseUpInElementEvent: anEvent
]

{ #category : #'mouse handlers' }
ToElementWithPopupEventHandler >> mouseUpOutsideEvent: anEvent [

	self pickOutsideEvent: anEvent
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

{ #category : #'mouse handlers' }
ToElementWithPopupEventHandler >> pickOutsideEvent: anEvent [

	" 
	if the original event target is the element with popup or
	if the original event target is the popup window then do nothing
	"

	anEvent originalEvent target ifNotNil: [ :originalTarget |
		(originalTarget hasInParentChain: self target) ifTrue: [ ^ self  ].
		(originalTarget hasInParentChain: windowManager currentWindow) ifTrue: [ ^ self ] ].
	
	" ok, mouseUp outside the element and outside of the popup window "
	anEvent consume.
	windowManager currentWindowDo: [:w | w close ]
]

{ #category : #'window opening - closing handlers' }
ToElementWithPopupEventHandler >> popupWindowClosedEvent: anEvent [

	self windowClosedEvent: anEvent
]

{ #category : #'window opening - closing handlers' }
ToElementWithPopupEventHandler >> popupWindowOpenedEvent: anEvent [

	self windowOpenedEvent: anEvent
]

{ #category : #accessing }
ToElementWithPopupEventHandler >> target [

	^ target
]
