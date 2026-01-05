Class {
	#name : #ToListCollectionDataSource,
	#superclass : #ToListDataSource,
	#traits : 'TToObservableCollection + TToCollectionChangedNotifier',
	#classTraits : 'TToObservableCollection classTrait + TToCollectionChangedNotifier classTrait',
	#instVars : [
		'dataEventHandler',
		'data'
	],
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #accessing }
ToListCollectionDataSource >> collection [

	^ data

]

{ #category : #initialization }
ToListCollectionDataSource >> initialize [ 

	super initialize.
	data := OrderedCollection new
]

{ #category : #accessing }
ToListCollectionDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ self size
]

{ #category : #notifications }
ToListCollectionDataSource >> notifyChangedAllDataItems: aDataItemArray [

	| idxes |
	idxes := aDataItemArray collect: [ :d |
		         | idx |
		         idx := self indexOf: d.
		         idx isZero ifTrue: [ Error signal: 'Data item not found' ].
		         idx ].
	self notifyDataItemChangeIndexes: idxes
]

{ #category : #notifications }
ToListCollectionDataSource >> notifyChangedDataItem: aDataItem [

	| idx |
	idx := self indexOf: aDataItem.
	idx isZero ifTrue: [ Error signal: 'Data item not found' ].
	self notifyDataItemChangeIndex: idx
]

{ #category : #hooks }
ToListCollectionDataSource >> onAttached: anInfiniteElement [

	super onAttached: anInfiniteElement.
	dataEventHandler := ToListDataSourceDataEventHandler new.
	dataEventHandler infinite: anInfiniteElement.
	self addEventHandler: dataEventHandler
]

{ #category : #'instance creation' }
ToListCollectionDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Update holder's model"

	anElementHolder bindDataItem: (self at: aPosition)
]

{ #category : #hooks }
ToListCollectionDataSource >> onDetached: anInfiniteElement [

	self removeEventHandler: dataEventHandler.
	dataEventHandler := nil.
	super onDetached: anInfiniteElement.


	
]
