Class {
	#name : #ToCircularMenuInnerElement,
	#superclass : #ToAnnulusCircularElement,
	#traits : 'TToInnerListElement + TToInnerFiniteListElement',
	#classTraits : 'TToInnerListElement classTrait + TToInnerFiniteListElement classTrait',
	#category : #'Toplo-Widget-Circular-Menu'
}

{ #category : #'t - inner finite list element - requirements' }
ToCircularMenuInnerElement >> addNodeContainer: aNodeContainer at: aPosition [

	self addChild: aNodeContainer at: aPosition
]

{ #category : #'t - circular element' }
ToCircularMenuInnerElement >> defaultLayout [ 

	^ ToCircularMenuLayout new
]

{ #category : #initialization }
ToCircularMenuInnerElement >> initialize [

	super initialize.
	self geometry: BlCircleGeometry new.
	self initializeAsToInnerFiniteElement.
	self innerRadialRatio: 0.25.
	self outerRadialRatio: 1.0
]

{ #category : #'t - inner list element - requirements' }
ToCircularMenuInnerElement >> nodeContainers [

	^ self children
]

{ #category : #'t - inner list element - requirements' }
ToCircularMenuInnerElement >> nodeContainersDo: aBlock [

	self childrenDo: aBlock
]

{ #category : #'t - inner list element - requirements' }
ToCircularMenuInnerElement >> partlyVisibleNodesDo: aBlock [

	self nodeContainersDo: aBlock 
]

{ #category : #'t - inner finite list element - requirements' }
ToCircularMenuInnerElement >> removeNodeContainer: aNodeContainer [

	aNodeContainer removeFromParent
]
