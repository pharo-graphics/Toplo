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
		'dataSource'
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

	self children do: [ :data |
		| wrapper |
		wrapper := (self dataSource select: [ :e | e dataItem = data ])
			           anyOne.
		wrapper collapse.
		self dataSource removeWrapper: wrapper ].
	
	isCollapsed := true.
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

	dataSource := aDataSource 
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> expand [

	| currentWrapper |
	self isLeaf ifTrue: [ ^ self ].
	isCollapsed := false.
	
	currentWrapper := self.
	self children do: [ :nextWrapper |
		dataSource add: nextWrapper after: currentWrapper.
		currentWrapper := dataSource at:
			                  (dataSource indexOf: currentWrapper) + 1 ].

	
]

{ #category : #initialization }
ToTreeDataSourceWrapper >> initialize [ 

	super initialize.
	isCollapsed := true.
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
ToTreeDataSourceWrapper >> wrapAround: anObject with: aChildSelector [

	dataItem := anObject.
	aChildSelector dataItem: anObject.
	children := aChildSelector children.
	nbChildren := children size
]
