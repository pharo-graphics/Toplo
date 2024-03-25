Class {
	#name : #ToElement,
	#superclass : #BlElement,
	#traits : 'TBlLayoutResizable + TToElement + TToEnableable + TToElementWithTooltip + TToElementWithContextMenu',
	#classTraits : 'TBlLayoutResizable classTrait + TToElement classTrait + TToEnableable classTrait + TToElementWithTooltip classTrait + TToElementWithContextMenu classTrait',
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
	self initializeForToplo.
	"self applySkinInstallerOnFirstRequest: true."
]

{ #category : #'t  - layout resizeable' }
ToElement >> resizableConstraintsDo: aBlock [
	"Perform aBlock with my constraints as argument.
	Note: After evaluation I request a layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument
	
	Can be basically defined with #constraintsDo: aBlock.
	
	Introduced a an explicit requirement to let user
	implement additional actions when resizing is changed
	
	"
	self constraintsDo: aBlock.
	self dispatchEvent: ToLayoutConstraintsChangedEvent new
	
]
