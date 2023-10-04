Class {
	#name : #ToOverlayWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - displaying' }
ToOverlayWindow >> checkBeforePopup [

	" aWindow bounds are up-to-date, I can be visible "
	self size: self associateElement size.
	super checkBeforePopup
]

{ #category : #initialization }
ToOverlayWindow >> defaultAssociateElementEventHandlerClass [

	^ ToElementWithOverlayWindowEventHandler
]
