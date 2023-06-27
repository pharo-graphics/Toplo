Class {
	#name : #ToAnchoredWindow,
	#superclass : #ToWidgetWindowElement,
	#category : #'Toplo-Widget-Window'
}

{ #category : #start }
ToAnchoredWindow >> attachTo: anElement [

	self widget: anElement
]

{ #category : #initialization }
ToAnchoredWindow >> defaulPositiontHook [

	^ [ :w :event | w widget bounds inSpace bounds topLeft ]
]

{ #category : #'t - initialization dresser' }
ToAnchoredWindow >> defaultDresser [ 

	^ ToAnchoredWindowDresser new
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
	self fitContent
]

{ #category : #start }
ToAnchoredWindow >> isAttached [

	^ self widget notNil
]
