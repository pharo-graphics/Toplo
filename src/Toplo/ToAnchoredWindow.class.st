Class {
	#name : #ToAnchoredWindow,
	#superclass : #ToBasicPopupWindowElement,
	#category : #'Toplo-Core-Window'
}

{ #category : #initialization }
ToAnchoredWindow >> defaulPositionHook [

	^ [ :w :event | w widget bounds inSpace bounds topLeft ]
]

{ #category : #initialization }
ToAnchoredWindow >> defaultLayout [

	^ BlFrameLayout new 
]

{ #category : #initialization }
ToAnchoredWindow >> defaultWidgetEventHandlerClass [

	^ ToWidgetInAnchoredWindowEventHandler
]

{ #category : #initialization }
ToAnchoredWindow >> initialize [ 

	super initialize.
	self fitContent
]
