Class {
	#name : #ToPopupWindowAssociateElementEventHandler,
	#superclass : #ToAnchoredWindowAssociateElementEventHandler,
	#category : #'Toplo-Core-Window'
}

{ #category : #'event handling' }
ToPopupWindowAssociateElementEventHandler >> closeAssociateWindow [

	associateWindow ifNil: [ ^ self ].
	associateWindow close
]

{ #category : #'event handling' }
ToPopupWindowAssociateElementEventHandler >> elementPositionInSpaceChangedEvent: anEvent [

	super elementPositionInSpaceChangedEvent: anEvent.
	self closeAssociateWindow
]

{ #category : #'api - accessing' }
ToPopupWindowAssociateElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { BlElementRemovedFromParentEvent }
]

{ #category : #testing }
ToPopupWindowAssociateElementEventHandler >> hasOpenedPopupWindow [

	^ associateWindow notNil and: [ associateWindow isOpened ]
]

{ #category : #'mouse handlers' }
ToPopupWindowAssociateElementEventHandler >> mouseDownOutsideEvent: anEvent [

	" 
	if the original event target is the element with popup or
	if the original event target is the popup window then do nothing
	"
	anEvent originalEvent target ifNotNil: [ :originalTarget |
		(originalTarget hasInParentChain: target) ifTrue: [ ^ self  ].
		(originalTarget hasInParentChain: self associateWindow) ifTrue: [ ^ self ] ].
	
	super mouseDownOutsideEvent: anEvent.
	
	" ok, mouseUp outside the element and outside of the popup window "
	anEvent consumed: true.
	self closeAssociateWindow
]

{ #category : #'mouse handlers' }
ToPopupWindowAssociateElementEventHandler >> mouseUpEvent: anEvent [

	| delay |
	super mouseUpEvent: anEvent.
	associateWindow ifNil: [ ^ self ].
	associateWindow parentDo: [ :p | " check a minimal delay between opening and closing.
		The mouse up can occur immediately after the window opening -> don't close the popup window.
		After a given delay between down and up, the popup window is closed "
		delay := (anEvent timestamp - associateWindow popupTimestamp).
		delay > associateWindow autoCloseOnMouseUpDelay ifTrue: [
			self closeAssociateWindow ] ]
]
