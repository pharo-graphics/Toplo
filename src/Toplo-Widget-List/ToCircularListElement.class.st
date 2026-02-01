Class {
	#name : #ToCircularListElement,
	#superclass : #ToBasicCircularListElement,
	#traits : 'TToInnerListElement + TToInnerFiniteListElement',
	#classTraits : 'TToInnerListElement classTrait + TToInnerFiniteListElement classTrait',
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #'t - inner finite list element - requirements' }
ToCircularListElement >> addNodeContainer: aNodeContainer at: aPosition [

	self addChild: aNodeContainer at: aPosition
]

{ #category : #configuration }
ToCircularListElement >> applyConfiguration [

	super applyConfiguration.
	self applyInnerFiniteListElementConfiguration 
]

{ #category : #initialization }
ToCircularListElement >> initialize [ 

	super initialize.
	self initializeAsToInnerFiniteElement.
	self addEventHandler: BlScrollableElementEventHandler new

]

{ #category : #'t - inner list element - requirements' }
ToCircularListElement >> nodeContainers [

	^ self children
]

{ #category : #'t - inner list element - requirements' }
ToCircularListElement >> nodeContainersDo: aBlock [

	self childrenDo: aBlock
]

{ #category : #'hooks - layout' }
ToCircularListElement >> onLayoutDone [

	super onLayoutDone.
	self consumeFinalStepCommands
]

{ #category : #'t - inner list element - requirements' }
ToCircularListElement >> partlyVisibleNodesDo: aBlock [

	self nodeContainersDo: aBlock 
]

{ #category : #'t - inner finite list element - requirements' }
ToCircularListElement >> removeNodeContainer: aNodeContainer [

	aNodeContainer removeFromParent
]

{ #category : #scrolling }
ToCircularListElement >> scrollBy: aPoint [

	self startAngle:
		self startAngle + (aPoint y * self scrollSensitivity).
	listElement ifNil: [ ^ true ].
	listElement postponeAction: [
			listElement forceUpdateAllSelectionsNow.
			listElement requestMouseMoveReplay ].
	^ true
]
