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

{ #category : #testing }
ToTreeNodeHolder >> canHaveChildren [ 

	^ self children size > 0
]

{ #category : #accessing }
ToTreeNodeHolder >> children [ 

	^ self wrapper children
]

{ #category : #public }
ToTreeNodeHolder >> click [

	collapsed
		ifTrue: [ self expand ]
		ifFalse: [ self collapse ]
]

{ #category : #'expanding-collapsing' }
ToTreeNodeHolder >> collapse [

	self isCollapsed ifTrue: [ ^ self ].

	collapsed := true.
	1 to: self children size do: [ :i | "1 to: self children size do: [ :i |
		self node nextSiblingDo: [ :s |
			s nodeHolder isCollapsed ifFalse: [ s nodeHolder collapse ] ] ].

	self treeElement dataAccessor remove: self wrappedObject""start := self treeElement dataAccessor indexOf:
		         self wrapper wrappedObject.
	stop := start + self wrapper children size.
	self treeElement dataAccessor removeFrom: start + 1 to: stop"
		self node nextSiblingDo: [ :sibling |
			"self halt."
			sibling nodeHolder collapse.
			"self halt."
			self treeElement dataAccessor remove:
				sibling nodeHolder wrappedObject.
			self halt.
			"self treeElement notifyDataSourceChanged.
			self halt" ] ]
]

{ #category : #'expanding-collapsing' }
ToTreeNodeHolder >> expand [

	| oldObject |
	self canHaveChildren ifFalse: [ ^ self ].
	oldObject := self wrappedObject.
	self children do: [ :nextObject |
		self treeElement dataAccessor add: nextObject after: oldObject.
		oldObject := nextObject ].
	
	collapsed := false.
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
ToTreeNodeHolder >> wrappedObject [ 

	^ self wrapper wrappedObject 
]

{ #category : #accessing }
ToTreeNodeHolder >> wrapper [

	^ wrapper
]

{ #category : #accessing }
ToTreeNodeHolder >> wrapper: aNodeWrapper [ 

	wrapper := aNodeWrapper 
]
