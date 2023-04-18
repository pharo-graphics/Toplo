Class {
	#name : #ToOverlayWindow,
	#superclass : #ToWidgetWindowElement,
	#category : #'Toplo-Widget-Window'
}

{ #category : #'api - displaying' }
ToOverlayWindow >> checkBeforePopupIn: aWidget [

	" aWindow bounds are up-to-date, I can be visible "
	self size: self widget size.
	super checkBeforePopupIn: aWidget
]

{ #category : #'t - initialization dresser' }
ToOverlayWindow >> defaultDresser [ 

	^ ToOverlayWindowDresser new
]

{ #category : #initialization }
ToOverlayWindow >> defaultHook [

	^ [ :w :event | w widget bounds inSpace bounds topLeft ]
]

{ #category : #initialization }
ToOverlayWindow >> initialize [

	super initialize.
	self initializeDresser 
]
