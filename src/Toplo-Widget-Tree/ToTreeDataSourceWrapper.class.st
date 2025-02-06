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
	#name : #ToTreeDataSourceWrapper,
	#superclass : #Object,
	#instVars : [
		'dataItem',
		'isCollapsed',
		'nbChildren',
		'children',
		'dataSource',
		'nodeDepth'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeDataSourceWrapper >> children [ 

	^ children 
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> children: aCollection [

	children := aCollection 
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> collapse [

	self isCollapsed ifTrue: [ ^ self ].

	self children do: [ :wrapper |
		wrapper collapse.
		self dataSource removeWrapper: wrapper ].

	isCollapsed := true
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> dataItem [ 

	^ dataItem 
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> dataItem: anObject [ 

	dataItem := anObject 
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> dataSource [

	^ dataSource 
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> dataSource: aDataSource [

	dataSource := aDataSource.
	
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> expand [

	| currentWrapper |
	self isLeaf ifTrue: [ ^ self ].
	isCollapsed := false.

	currentWrapper := self.
	self children do: [ :nextWrapper |
		dataSource addWrapper: nextWrapper after: currentWrapper.
		currentWrapper := nextWrapper ]
]

{ #category : #initialization }
ToTreeDataSourceWrapper >> initialize [

	super initialize.
	isCollapsed := true.
	nodeDepth := 1
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> isCollapsed [ 

	^ isCollapsed 
]

{ #category : #testing }
ToTreeDataSourceWrapper >> isLeaf [

	^ self children size = 0
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> nbChildren [ 

	^ nbChildren 
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> nbChildren: aNumber [

	nbChildren := aNumber 
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> nodeDepth [

	^ nodeDepth
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> nodeDepth: aNumber [

	nodeDepth := aNumber 
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> wrapAround: anObject with: aChildSelector [

	dataItem := anObject.
	aChildSelector dataItem: anObject.
	children := aChildSelector children collect: [ :each |
		            self class new
			            dataSource: self dataSource;
			            wrapAround: each with: aChildSelector atDepth: self nodeDepth + 1 ].
	nbChildren := children size
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> wrapAround: anObject with: aChildSelector atDepth: aNumber [

	self nodeDepth: aNumber.
	self wrapAround: anObject with: aChildSelector.

]
