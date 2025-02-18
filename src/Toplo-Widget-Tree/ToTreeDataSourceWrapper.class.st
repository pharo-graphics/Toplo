Class {
	#name : #ToTreeDataSourceWrapper,
	#superclass : #Object,
	#instVars : [
		'dataSource',
		'dataWrapperClass'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #adding }
ToTreeDataSourceWrapper >> add: aDataItem [ 

	dataSource add: (self wrapObject: aDataItem) 	 

	
]

{ #category : #adding }
ToTreeDataSourceWrapper >> add: aDataItem afterIndex: index [

	dataSource add: (self wrapObject: aDataItem) afterIndex: index	 

	
]

{ #category : #adding }
ToTreeDataSourceWrapper >> add: aDataItem beforeIndex: index [

	dataSource add: (self wrapObject: aDataItem) beforeIndex: index	 

	
]

{ #category : #adding }
ToTreeDataSourceWrapper >> addAll: aCollection [

	| wrapperCollection |
	aCollection ifEmpty: [ ^ self ].
	wrapperCollection := aCollection collect: [ :each |
		                     self wrapObject: each ].

	dataSource addAll: wrapperCollection	 

	
]

{ #category : #adding }
ToTreeDataSourceWrapper >> addFirst: aDataItem [ 

	dataSource addFirst: (self wrapObject: aDataItem) 	 

	
]

{ #category : #adding }
ToTreeDataSourceWrapper >> addLast: aDataItem [ 

	dataSource addLast: (self wrapObject: aDataItem) 	 

	
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> dataSource: aDataSource [ 

	dataSource := aDataSource 
]

{ #category : #accessing }
ToTreeDataSourceWrapper >> dataWrapperClass: aToTreeDataItemWrapperClass [

	dataWrapperClass := aToTreeDataItemWrapperClass 
]

{ #category : #testing }
ToTreeDataSourceWrapper >> ifEmpty: aBlock [ 

	dataSource ifEmpty: aBlock
]

{ #category : #adding }
ToTreeDataSourceWrapper >> remove: aDataItem [ 
	"this method doesn't check if the dataItem is present multiple times"

	| wrapper |
	wrapper := (dataSource select: [ :e | e dataItem = aDataItem ]) anyOne.
	dataSource remove: wrapper
]

{ #category : #adding }
ToTreeDataSourceWrapper >> removeAll [ 

	dataSource removeAll 
]

{ #category : #adding }
ToTreeDataSourceWrapper >> removeAt: anIndex [ 

	dataSource removeAt: anIndex 
]

{ #category : #wrapping }
ToTreeDataSourceWrapper >> wrapObject: anObject [

	^ dataWrapperClass new
		  dataSource: dataSource ;
		  dataItem: anObject
]
