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

{ #category : #utilities }
ToElement >> inHorizontalPane [

	| pane |
	pane := ToPane horizontal.
	pane addChild: self.
	^ pane
]

{ #category : #utilities }
ToElement >> inVerticalPane [

	| pane |
	pane := ToPane vertical.
	pane addChild: self.
	^ pane
]

{ #category : #initialization }
ToElement >> initialize [

	super initialize.
	self layout: self defaultLayout.
	self initializeForToplo.
	self fitContent 
]

{ #category : #converting }
ToElement >> newScrollable [

	^ ToScrollableElement new
]
