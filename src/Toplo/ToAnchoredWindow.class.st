Class {
	#name : #ToAnchoredWindow,
	#superclass : #ToBasicPopupWindowElement,
	#category : #'Toplo-Core-Window'
}

{ #category : #initialization }
ToAnchoredWindow >> defaulPositionHook [

	^ [ :w :event | w associateElement bounds inSpace bounds topLeft ]
]

{ #category : #initialization }
ToAnchoredWindow >> defaultAssociateElementEventHandlerClass [

	^ ToElementWithAnchoredWindowEventHandler
]

{ #category : #initialization }
ToAnchoredWindow >> initialize [ 

	super initialize.
	self fitContent
]
