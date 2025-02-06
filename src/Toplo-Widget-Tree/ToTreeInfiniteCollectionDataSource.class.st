Class {
	#name : #ToTreeInfiniteCollectionDataSource,
	#superclass : #ToInfiniteCollectionDataSource,
	#instVars : [
		'childSelector'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'t - observable collection - adding' }
ToTreeInfiniteCollectionDataSource >> add: newObject afterIndex: index [

	| wrappedObject |
	wrappedObject := self wrapObject: newObject.
	super add: wrappedObject afterIndex: index.
]

{ #category : #'t - observable collection - adding' }
ToTreeInfiniteCollectionDataSource >> add: newObject beforeIndex: index [

	| wrappedObject |
	wrappedObject := self wrapObject: newObject.
	super add: wrappedObject beforeIndex: index
]

{ #category : #'t - observable collection - adding' }
ToTreeInfiniteCollectionDataSource >> addFirst: newObject [

	| wrappedObject |
	wrappedObject := self wrapObject: newObject.
	super addFirst: wrappedObject
]

{ #category : #'t - observable collection - adding' }
ToTreeInfiniteCollectionDataSource >> addLast: newObject [

	| wrappedObject |
	wrappedObject := self wrapObject: newObject.
	super addLast: wrappedObject
]

{ #category : #accessing }
ToTreeInfiniteCollectionDataSource >> childSelector [ 

	^ childSelector 
	
]

{ #category : #accessing }
ToTreeInfiniteCollectionDataSource >> childSelector: aToTreeChildSelector [

	childSelector := aToTreeChildSelector 
]

{ #category : #'t - observable collection - removing' }
ToTreeInfiniteCollectionDataSource >> remove: aDataItem [

	| wrapper |
	wrapper := (self select: [ :e | e dataItem = aDataItem ]) anyOne.
	self removeWrapper: wrapper 
]

{ #category : #removing }
ToTreeInfiniteCollectionDataSource >> removeWrapper: aToTreeDataSourceWrapper [

	self removeAt: (self indexOf: aToTreeDataSourceWrapper).
]

{ #category : #wrapping }
ToTreeInfiniteCollectionDataSource >> wrapObject: anObject [

	^ ToTreeDataSourceWrapper new
		  wrapAround: anObject
		  with: childSelector new;
		dataSource: self
]
