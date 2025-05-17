"
I am a ToTreeDataSourceWrapper 

My job is to wrap objects that users wish to add to a dataSource of a TreeElement, I present a similar API than a dataSource but I take care of using DataItemWrappers to wrap objects before putting them into the dataSource


"
Class {
	#name : #ToTreeDataSourceWrapper,
	#superclass : #Object,
	#instVars : [
		'treeElement'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #adding }
ToTreeDataSourceWrapper >> add: aDataItem [ 

	self dataSource add: (self wrapObject: aDataItem) 	 

	
]

{ #category : #adding }
ToTreeDataSourceWrapper >> add: aDataItem afterIndex: index [

	self dataSource add: (self wrapObject: aDataItem) afterIndex: index	 

	
]

{ #category : #adding }
ToTreeDataSourceWrapper >> add: aDataItem beforeIndex: index [

	self dataSource add: (self wrapObject: aDataItem) beforeIndex: index	 

	
]

{ #category : #adding }
ToTreeDataSourceWrapper >> addAll: aCollection [

	| wrapperCollection |
	aCollection ifEmpty: [ ^ self ].
	wrapperCollection := aCollection collect: [ :each |
		                     self wrapObject: each ].

	self dataSource addAll: wrapperCollection	 

	
]

{ #category : #adding }
ToTreeDataSourceWrapper >> addFirst: aDataItem [ 

	self dataSource addFirst: (self wrapObject: aDataItem) 	 

	
]

{ #category : #adding }
ToTreeDataSourceWrapper >> addLast: aDataItem [ 

	self dataSource addLast: (self wrapObject: aDataItem) 	 

	
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> at: anIndex [

	^ self dataSource at: anIndex 
]

{ #category : #'expanding-collapsing' }
ToTreeDataSourceWrapper >> collapseAll [

	| rootWrappers |
	rootWrappers := self dataSource collection select: [ :each |
		                   each nodeDepth = 0 ].
	rootWrappers do: [ :w | w collapse ].
	
	self dataSource notifyChanged 
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> dataSource [ 

	^ treeElement dataSource
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> dataWrapperClass [

	^ treeElement dataWrapperClass 
]

{ #category : #enumerating }
ToTreeDataSourceWrapper >> do: aBlock [ 

	self dataSource do: aBlock 
]

{ #category : #'expanding-collapsing' }
ToTreeDataSourceWrapper >> expandAll [

	| rootWrappers |
	rootWrappers := self dataSource collection select: [ :each |
		                   each nodeDepth = 0 ].
	rootWrappers do: [ :w | w expandAll ].
	self dataSource notifyChanged 
]

{ #category : #testing }
ToTreeDataSourceWrapper >> ifEmpty: aBlock [ 

	self dataSource ifEmpty: aBlock
]

{ #category : #testing }
ToTreeDataSourceWrapper >> isEmpty [ 

	^ self dataSource isEmpty 
]

{ #category : #adding }
ToTreeDataSourceWrapper >> remove: aDataItem [ 
	"this method doesn't check if the dataItem is present multiple times"

	| wrapper |
	wrapper := (self dataSource select: [ :e | e dataItem = aDataItem ]) anyOne.
	self dataSource remove: wrapper
]

{ #category : #adding }
ToTreeDataSourceWrapper >> removeAll [ 

	self dataSource removeAll 
]

{ #category : #adding }
ToTreeDataSourceWrapper >> removeAt: anIndex [ 

	self dataSource removeAt: anIndex 
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> size [ 

	^ self dataSource size
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> treeElement: aTreeElement [

	treeElement := aTreeElement 
]

{ #category : #wrapping }
ToTreeDataSourceWrapper >> wrapObject: anObject [

	^ self dataWrapperClass new
		  dataSourceWrapper: self;
		  dataItem: anObject
]
