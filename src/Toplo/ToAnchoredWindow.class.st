Class {
	#name : #ToAnchoredWindow,
	#superclass : #ToBasicWindowElement,
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

{ #category : #initialization }
ToAnchoredWindow >> initialize [

	super initialize.
	self fitContent.
	hook := self defaultHook.
	self initializeDresser 
]

{ #category : #start }
ToAnchoredWindow >> isAttached [

	^ self widget notNil
]
