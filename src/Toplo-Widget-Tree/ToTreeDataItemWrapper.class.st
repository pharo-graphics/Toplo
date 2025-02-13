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
		'children',
		'dataSource',
		'parentWrapper'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeDataItemWrapper >> collapse [

	isCollapsed ifTrue: [ ^ self ].

	children do: [ :wrapper |
		wrapper collapse.
		dataSource removeWrapper: wrapper ].

	isCollapsed := true.

	dataSource notifyChanged
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

{ #category : #'as yet unclassified' }
ToTreeDataItemWrapper >> determineAndWrapChildren [

	children ifNotNil: [ ^ self ].
	self determineChildren.
	self wrapChildren
]

{ #category : #'as yet unclassified' }
ToTreeDataItemWrapper >> determineChildren [

	children := OrderedCollection empty.
]

{ #category : #accessing }
ToTreeDataItemWrapper >> expand [

	| currentWrapper |
	(self isLeaf or: isCollapsed not) ifTrue: [ ^ self ].
	isCollapsed := false.

	currentWrapper := self.
	children do: [ :nextWrapper |
		dataSource addWrapper: nextWrapper after: currentWrapper.
		currentWrapper := nextWrapper ].

	dataSource notifyChanged
]

{ #category : #accessing }
ToTreeDataItemWrapper >> expandAll [

	self expand.
	children do: [ :each | each expandAll ]
]

{ #category : #initialization }
ToTreeDataItemWrapper >> initialize [

	super initialize.
	isCollapsed := true.
]

{ #category : #accessing }
ToTreeDataItemWrapper >> isCollapsed [ 

	^ isCollapsed 
]

{ #category : #testing }
ToTreeDataItemWrapper >> isLeaf [

	^ children size = 0
]

{ #category : #accessing }
ToTreeDataItemWrapper >> nodeDepth [

	^ parentWrapper
		  ifNil: [ 1 ]
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

{ #category : #'as yet unclassified' }
ToTreeDataItemWrapper >> wrapChildren [

	children := children collect: [ :each |
		            self class new
			            dataSource: dataSource;
			            dataItem: each;
			            parentWrapper: self ]
]
