Class {
	#name : #ToFiniteListElement,
	#superclass : #ToElement,
	#traits : 'TToInnerListElement + TToInnerFiniteListElement',
	#classTraits : 'TToInnerListElement classTrait + TToInnerFiniteListElement classTrait',
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #'t - inner finite list element - requirements' }
ToFiniteListElement >> addNodeContainer: aNodeContainer at: aPosition [

	self addChild: aNodeContainer at: aPosition
]

{ #category : #configuration }
ToFiniteListElement >> applyConfiguration [

	super applyConfiguration.
	self listElement isHorizontal
		ifTrue: [ self layout beHorizontal ]
		ifFalse: [ self layout beVertical ].
	self applyInnerFiniteListElementConfiguration 
]

{ #category : #initialization }
ToFiniteListElement >> defaultLayout [ 

	^ BlLinearLayout vertical
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
