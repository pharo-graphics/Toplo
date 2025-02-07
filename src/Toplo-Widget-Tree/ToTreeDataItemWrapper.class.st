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
		'isCollapsed',
		'nbChildren',
		'children',
		'dataSource',
		'nodeDepth'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeDataItemWrapper >> children [ 

	^ children 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> children: aCollection [

	children := aCollection 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> collapse [

	self isCollapsed ifTrue: [ ^ self ].

	self children do: [ :wrapper |
		wrapper collapse.
		self dataSource removeWrapper: wrapper ].

	isCollapsed := true.
	
	self dataSource notifyChanged
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
ToTreeDataItemWrapper >> dataSource [

	^ dataSource 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> dataSource: aDataSource [

	dataSource := aDataSource.
	
]

{ #category : #accessing }
ToTreeDataItemWrapper >> expand [

	| currentWrapper |
	(self isLeaf or: self isCollapsed not) ifTrue: [ ^ self ].
	isCollapsed := false.

	currentWrapper := self.
	self children do: [ :nextWrapper |
		dataSource addWrapper: nextWrapper after: currentWrapper.
		currentWrapper := nextWrapper ].

	self dataSource notifyChanged
]

{ #category : #accessing }
ToTreeDataItemWrapper >> expandAll [

	self expand.
	self children do: [ :each | each expandAll ].
]

{ #category : #initialization }
ToTreeDataItemWrapper >> initialize [

	super initialize.
	isCollapsed := true.
	nodeDepth := 1
]

{ #category : #accessing }
ToTreeDataItemWrapper >> isCollapsed [ 

	^ isCollapsed 
]

{ #category : #testing }
ToTreeDataItemWrapper >> isLeaf [

	^ self children size = 0
]

{ #category : #accessing }
ToTreeDataItemWrapper >> nbChildren [ 

	^ nbChildren 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> nbChildren: aNumber [

	nbChildren := aNumber 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> nodeDepth [

	^ nodeDepth
]

{ #category : #accessing }
ToTreeDataItemWrapper >> nodeDepth: aNumber [

	nodeDepth := aNumber 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> wrapAround: anObject with: aChildSelector [

	dataItem := anObject.
	aChildSelector dataItem: anObject.
	children := aChildSelector children collect: [ :each |
		            self class new
			            dataSource: self dataSource;
			            wrapAround: each with: aChildSelector atDepth: self nodeDepth + 1 ].
	nbChildren := children size
]

{ #category : #accessing }
ToTreeDataItemWrapper >> wrapAround: anObject with: aChildSelector atDepth: aNumber [

	self nodeDepth: aNumber.
	self wrapAround: anObject with: aChildSelector.

]
