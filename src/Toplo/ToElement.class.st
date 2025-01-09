Class {
	#name : #ToElement,
	#superclass : #BlElement,
	#traits : 'TBlLayoutResizable + TToElement + TToElementWithTooltip + TToElementWithContextMenu + TToAuthorisationRequestTarget',
	#classTraits : 'TBlLayoutResizable classTrait + TToElement classTrait + TToElementWithTooltip classTrait + TToElementWithContextMenu classTrait + TToAuthorisationRequestTarget classTrait',
	#category : #'Toplo-Core'
}

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
	self applySkinInstallerOnFirstRequest: false.
]

{ #category : #converting }
ToElement >> newScrollable [

	^ ToScrollableElement new
]
