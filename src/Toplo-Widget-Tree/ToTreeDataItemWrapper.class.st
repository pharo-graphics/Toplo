"
I am a ToTreeDataSourceWrapper 

My purpose is to wrap an Object (called dataItem) when one is added to a ToTreeDataSource.

I wrap this item and keep references to :
 - this object
 - its children, as they are defined by the dataSource childSelector
 - the number of children this object has
 - the state of the node linked to this object (collapsed or expanded)
"
Class {
	#name : #ToTreeDataItemWrapper,
	#superclass : #Object,
	#instVars : [
		'dataItem',
		'children',
		'dataSource',
		'parentWrapper',
		'expanded'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeDataItemWrapper >> children [

	^ children ifNil: [ children := self determineChildren collect: [ :each |
		                   self class new
			                   dataSource: dataSource;
			                   dataItem: each;
			                   parentWrapper: self ]].

]

{ #category : #accessing }
ToTreeDataItemWrapper >> collapse [

	expanded ifFalse: [ ^ self ].

	self children do: [ :wrapper |
		wrapper collapse.
		dataSource remove: wrapper ].

	expanded := false
]

{ #category : #accessing }
ToTreeDataItemWrapper >> dataItem [ 

	^ dataItem 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> dataItem: anObject [ 

	dataItem := anObject 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> dataSource: aDataSource [

	dataSource := aDataSource.
	
]

{ #category : #accessing }
ToTreeDataItemWrapper >> determineChildren [

	^ OrderedCollection empty.
]

{ #category : #accessing }
ToTreeDataItemWrapper >> expand [

	| pos |
	(self isLeaf or: expanded) ifTrue: [ ^ self ].
	expanded := true.

	pos := self position.
	self children withIndexDo: [ :wrapper :idx |
		dataSource add: wrapper afterIndex: pos + idx - 1 ]
]

{ #category : #accessing }
ToTreeDataItemWrapper >> expandAll [

	self expand.
	self children do: [ :each | each expandAll ]
]

{ #category : #initialization }
ToTreeDataItemWrapper >> initialize [

	super initialize.
	expanded := false
]

{ #category : #accessing }
ToTreeDataItemWrapper >> isExpanded [ 

	^ expanded 
]

{ #category : #testing }
ToTreeDataItemWrapper >> isLeaf [

	^ self children isEmpty
]

{ #category : #accessing }
ToTreeDataItemWrapper >> nodeDepth [

	^ parentWrapper
		  ifNil: [ 0 ]
		  ifNotNil: [ parentWrapper nodeDepth + 1 ]
]

{ #category : #accessing }
ToTreeDataItemWrapper >> parentWrapper [ 

	^ parentWrapper 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> parentWrapper: aDataItemWrapper [ 

	parentWrapper := aDataItemWrapper 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> position [ 

	^ dataSource indexOf: self
]

{ #category : #operations }
ToTreeDataItemWrapper >> toggle [

	self isExpanded
		ifTrue: [ self collapse ]
		ifFalse: [ self expand ].

	dataSource notifyChanged.
]
