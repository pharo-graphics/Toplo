Class {
	#name : #ToElement,
	#superclass : #BlElement,
	#traits : 'TToElement + TToElementWithActionPool + TToElementWithTooltip + TToElementWithContextMenu + TToRequestTarget',
	#classTraits : 'TToElement classTrait + TToElementWithActionPool classTrait + TToElementWithTooltip classTrait + TToElementWithContextMenu classTrait + TToRequestTarget classTrait',
	#category : #'Toplo-Core'
}

{ #category : #'event creation' }
ToElement >> clickEventClass [ 

	^ BlPrimaryClickEvent 
]

{ #category : #initialization }
ToElement >> defaultLayout [ 

	^ BlFrameLayout new
]

{ #category : #initialization }
ToElement >> initialize [

	super initialize.
	self layout: self defaultLayout.
	self initializeForToplo.
	self fitContent 
]
