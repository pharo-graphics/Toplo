Class {
	#name : #ToTreeInfiniteCollectionDataSource,
	#superclass : #ToInfiniteCollectionDataSource,
	#instVars : [
		'childSelector'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'t - observable collection - adding' }
ToTreeInfiniteCollectionDataSource >> add: newObject after: oldObject [
	"If you are using this method, this means you might want to add an object after another in your datasource manually, although internally the datasource manipulates wrappers.
	This method is not yet implemented as we need to find a correct way to identify the right wrapper holding 'oldObject' in case of equal objects .
	Also we might have to make sure 'newObject' is not already wrapped"

	self notYetImplemented
]

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
ToTreeInfiniteCollectionDataSource >> addAllLast: aCollection [

	| wrapperCollection|
	aCollection ifEmpty: [ ^ self ].
	wrapperCollection := aCollection collect: [ :each | self wrapObject: each ].
	super addAllLast: wrapperCollection
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

{ #category : #adding }
ToTreeInfiniteCollectionDataSource >> addWrapper: aWrapper after: aPreviousWrapper [

	| idx |
	idx := self collection indexOf: aPreviousWrapper.
	self addWrapper: aWrapper afterIndex: idx
]

{ #category : #'t - observable collection - adding' }
ToTreeInfiniteCollectionDataSource >> addWrapper: aDataSourceWrapper afterIndex: index [

	super add: aDataSourceWrapper afterIndex: index
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

	^ ToTreeDataItemWrapper new
		  dataSource: self;
		  wrapAround: anObject with: self childSelector new
]
