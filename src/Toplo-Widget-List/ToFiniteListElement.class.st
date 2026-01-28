Class {
	#name : #ToFiniteListElement,
	#superclass : #ToElement,
	#traits : 'TToInnerListElement + TToInnerFiniteListElement',
	#classTraits : 'TToInnerListElement classTrait + TToInnerFiniteListElement classTrait',
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #'instance creation' }
ToFiniteListElement class >> onListElement: aListElement [

	^ self basicNew
		  onListElement: aListElement;
		  initialize
]

{ #category : #'t - inner finite list element - requirements' }
ToFiniteListElement >> addHolder: anHolder at: aPosition [

	self addChild: anHolder nodeContainer at: aPosition
]

{ #category : #configuration }
ToFiniteListElement >> applyConfiguration [

	super applyConfiguration.
	self horizontal: self listElement isHorizontal.
	self applyInnerFiniteListElementConfiguration 
]

{ #category : #initialization }
ToFiniteListElement >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #configuration }
ToFiniteListElement >> horizontal: aBoolean [

	aBoolean
		ifTrue: [ self layout beHorizontal ]
		ifFalse: [ self layout beVertical ]
]

{ #category : #initialization }
ToFiniteListElement >> initialize [

	super initialize.
	self initializeAsToInnerFiniteElement
]

{ #category : #'t - inner list element - requirements' }
ToFiniteListElement >> nodeContainers [

	^ self children
]

{ #category : #'t - inner list element - requirements' }
ToFiniteListElement >> nodeContainersDo: aBlock [

	self childrenDo: aBlock
]

{ #category : #'hooks - layout' }
ToFiniteListElement >> onLayoutDone [

	super onLayoutDone.
	self consumeFinalStepCommands
]

{ #category : #'t - inner list element - requirements' }
ToFiniteListElement >> partlyVisibleNodesDo: aBlock [

	self nodeContainersDo: aBlock 
]

{ #category : #'t - inner finite list element - requirements' }
ToFiniteListElement >> removeNodeContainer: aNodeContainer [

	aNodeContainer removeFromParent
]
