Class {
	#name : #ToCircularListElement,
	#superclass : #ToElement,
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
	self geometry: BlCircleGeometry new
]

{ #category : #'t - inner list element - requirements' }
ToCircularListElement >> nodeContainers [

	^ self children
]

{ #category : #'t - inner list element - requirements' }
ToCircularListElement >> nodeContainersDo: aBlock [

	self childrenDo: aBlock
]

{ #category : #'t - inner list element - requirements' }
ToCircularListElement >> partlyVisibleNodesDo: aBlock [

	self nodeContainersDo: aBlock 
]

{ #category : #'t - inner finite list element - requirements' }
ToCircularListElement >> removeNodeContainer: aNodeContainer [

	aNodeContainer removeFromParent
]
