Class {
	#name : #ToInfinite,
	#superclass : #OBlInfiniteElement,
	#instVars : [
		'dataToElementStencyl',
		'list'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #accessing }
ToInfinite >> dataToElementStencyl [

	^ dataToElementStencyl
]

{ #category : #accessing }
ToInfinite >> dataToElementStencyl: aBlock [

	dataToElementStencyl := aBlock
]

{ #category : #initialization }
ToInfinite >> defaultLayout [
	^ OBlInfiniteLinearLayout new
]

{ #category : #initialization }
ToInfinite >> initialize [

	super initialize.
	self dataSource: ToInfiniteDataSource new.
	dataToElementStencyl := [ :d | d asElement ].
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #'as yet unclassified' }
ToInfinite >> list: aList [

	dataSource list: aList
]
