Class {
	#name : #ToTreeNodeHolder,
	#superclass : #ToListNodeHolder,
	#instVars : [
		'collapsed',
		'wrapper',
		'treeElement'
	],
	#category : #'Toplo-Widget-Tree'
}

{ #category : #accessing }
ToTreeNodeHolder >> bindDataItem: aDataItem [

	super bindDataItem: aDataItem.
	self wrapper wrappedObject: aDataItem.
]

{ #category : #public }
ToTreeNodeHolder >> click [

	collapsed
		ifTrue: [ self expand ]
		ifFalse: [ self collapse ]
]

{ #category : #'expanding-collapsing' }
ToTreeNodeHolder >> collapse [

	| start stop |
	collapsed := true.
	'collapse' traceCr.
	start := self treeElement dataAccessor indexOf: self wrapper wrappedObject.
	stop := start + self wrapper children size. 
	self treeElement dataAccessor removeFrom: start + 1 to: stop.
]

{ #category : #'expanding-collapsing' }
ToTreeNodeHolder >> expand [

	| oldObject |
	collapsed := false.
	'expand' traceCr.
	oldObject := self wrapper wrappedObject.
	self wrapper children do: [ :nextObject |
		self treeElement dataAccessor add: nextObject after: oldObject.
		oldObject := nextObject ].
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
ToTreeNodeHolder >> treeElement [ 

	^ treeElement
]

{ #category : #accessing }
ToTreeNodeHolder >> treeElement: aTreeElement [

	treeElement := aTreeElement 
]

{ #category : #accessing }
ToTreeNodeHolder >> wrapper [

	^ wrapper
]

{ #category : #accessing }
ToTreeNodeHolder >> wrapper: aNodeWrapper [ 

	wrapper := aNodeWrapper 
]
