Class {
	#name : #ToTreeNodeHolder,
	#superclass : #ToListNodeHolder,
	#instVars : [
		'collapsed',
		'wrapper'
	],
	#category : #'Toplo-Widget-Tree'
}

{ #category : #public }
ToTreeNodeHolder >> click [

	collapsed
		ifTrue: [ self expand ]
		ifFalse: [ self collapse ]
]

{ #category : #'expanding-collapsing' }
ToTreeNodeHolder >> collapse [

	collapsed := true.
	'collapse' traceCr
]

{ #category : #'expanding-collapsing' }
ToTreeNodeHolder >> expand [

	collapsed := false.
	'expand' traceCr
]

{ #category : #initialization }
ToTreeNodeHolder >> initialize [

	super initialize.
	collapsed := true
]

{ #category : #accessing }
ToTreeNodeHolder >> isCollapsed [ 

 ^ collapsed 
]

{ #category : #accessing }
ToTreeNodeHolder >> wrapper [

	^ wrapper
]

{ #category : #accessing }
ToTreeNodeHolder >> wrapper: aNodeWrapper [ 

	wrapper := aNodeWrapper 
]
