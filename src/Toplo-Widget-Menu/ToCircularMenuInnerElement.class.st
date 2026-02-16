Class {
	#name : #ToCircularMenuInnerElement,
	#superclass : #ToAnnulusCircularElement,
	#traits : 'TToInnerListElement + TToInnerFiniteListElement',
	#classTraits : 'TToInnerListElement classTrait + TToInnerFiniteListElement classTrait',
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #'t - inner finite list element - requirements' }
ToCircularMenuInnerElement >> addNodeContainer: aNodeContainer at: aPosition [

	self addChild: aNodeContainer at: aPosition
]

{ #category : #initialization }
ToCircularMenuInnerElement >> initialize [ 

	super initialize.
	self geometry: BlCircleGeometry new.
	self initializeAsToInnerFiniteElement.
	self preventMouseEvents. 
	self innerRadius: 0.25.
	self outerRadius: 1.0
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
