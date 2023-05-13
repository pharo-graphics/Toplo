Class {
	#name : #ToAnchoredWindow,
	#superclass : #ToWidgetWindowElement,
	#category : #'Toplo-Widget-Window'
}

{ #category : #start }
ToAnchoredWindow >> attachTo: anElement [

	self widget: anElement
]

{ #category : #'t - initialization dresser' }
ToAnchoredWindow >> defaultDresser [ 

	^ ToAnchoredWindowDresser new
]

{ #category : #initialization }
ToAnchoredWindow >> defaultHook [

	^ [ :w :event | w widget bounds inSpace bounds topLeft ]
]

{ #category : #initialization }
ToAnchoredWindow >> defaultLayout [

	^ BlFrameLayout new 
]

{ #category : #start }
ToAnchoredWindow >> detach [

	self close.
	self widget: nil
]

{ #category : #start }
ToAnchoredWindow >> isAttached [

	^ self widget notNil
]

{ #category : #'t - initialization dresser' }
ToAnchoredWindow >> preInitializeDresser [ 

	super preInitializeDresser.
	
	self fitContent.
	hook := self defaultHook.
]
