Class {
	#name : #ToCircularListElement,
	#superclass : #ToElement,
	#traits : 'TToInnerListElement + TToInnerFiniteListElement',
	#classTraits : 'TToInnerListElement classTrait + TToInnerFiniteListElement classTrait',
	#instVars : [
		'scrollSensitivity'
	],
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
ToCircularListElement >> defaultLayout [ 

	^ ToBasicCircularLayout new
]

{ #category : #initialization }
ToCircularListElement >> initialize [ 

	super initialize.
	scrollSensitivity := 0.02.
	self initializeAsToInnerFiniteElement

]

{ #category : #accessing }
ToCircularListElement >> inset [

	^ self layout inset
]

{ #category : #accessing }
ToCircularListElement >> inset: aNumber [

	self inset = aNumber ifTrue: [ ^ self ].
	self layout inset: aNumber.
	self requestLayout
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

{ #category : #accessing }
ToCircularListElement >> scrollSensitivity [

	^ scrollSensitivity
]

{ #category : #accessing }
ToCircularListElement >> scrollSensitivity: anObject [

	scrollSensitivity := anObject
]

{ #category : #accessing }
ToCircularListElement >> startAngle [

	^ layout startAngle
]

{ #category : #accessing }
ToCircularListElement >> startAngle: anAngleInDegrees [

	(self startAngle closeTo: anAngleInDegrees) ifTrue: [ ^ self ].
	layout startAngle: anAngleInDegrees.
	self requestLayout
]
