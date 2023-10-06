Class {
	#name : #ToOverlayWindow,
	#superclass : #ToAnchoredWindowElement,
	#category : #'Toplo-Core-Window'
}

{ #category : #initialization }
ToOverlayWindow >> defaulSizeHook [

	^ [ :w :event | w associateElement size ]
]

{ #category : #initialization }
ToOverlayWindow >> defaultAssociateElementEventHandlerClass [

	^ ToOverlayWindowAssociateElementEventHandler
]

{ #category : #initialization }
ToOverlayWindow >> initialize [ 

	super initialize.
	self sizeHook: self defaulSizeHook
]
