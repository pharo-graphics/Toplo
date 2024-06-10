Class {
	#name : #ToElement,
	#superclass : #BlElement,
	#traits : 'TBlLayoutResizable + TToElement + TToEnableable + TToElementWithTooltip + TToElementWithContextMenu + TToUnanimityRequestTarget',
	#classTraits : 'TBlLayoutResizable classTrait + TToElement classTrait + TToEnableable classTrait + TToElementWithTooltip classTrait + TToElementWithContextMenu classTrait + TToUnanimityRequestTarget classTrait',
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToElement >> defaultLayout [ 

	^ BlFrameLayout new
]

{ #category : #'as yet unclassified' }
ToElement >> dispatchMainLayoutDirectionChanged [

	| event |
	event := ToMainLayoutDirectionChangedEvent new root: self.
	self withAllChildrenBreadthFirstDo: [ :e | e dispatchEvent: event ]
]

{ #category : #'as yet unclassified' }
ToElement >> dispatchMainLayoutOrientationChanged [

	| event |
	event := ToMainLayoutOrientationChangedEvent new root: self.
	self withAllChildrenBreadthFirstDo: [ :e | e dispatchEvent: event ]
]

{ #category : #'as yet unclassified' }
ToElement >> dispatchMainResizerChanged [

	| event |
	event := ToMainResizerChangedEvent new root: self.
	self withAllChildrenBreadthFirstDo: [ :e | e dispatchEvent: event ]
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
ToElement >> newScrollableParent [

	^ ToScrollableElement new
]
