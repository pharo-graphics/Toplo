Class {
	#name : #ToInfiniteCollectionDataSource,
	#superclass : #ToInfiniteDataSource,
	#traits : 'TToObservableCollection + TToCollectionChangedNotifier',
	#classTraits : 'TToObservableCollection classTrait + TToCollectionChangedNotifier classTrait',
	#instVars : [
		'dataEventHandler',
		'data'
	],
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #accessing }
ToInfiniteCollectionDataSource >> collection [

	^ data

]

{ #category : #initialization }
ToInfiniteCollectionDataSource >> initialize [ 

	super initialize.
	data := OrderedCollection new
]

{ #category : #accessing }
ToInfiniteCollectionDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ self size
]

{ #category : #notifications }
ToInfiniteCollectionDataSource >> notifyChangedAllDataItems: aDataItemArray [

	| idxes |
	idxes := aDataItemArray collect: [ :d |
		         | idx |
		         idx := self indexOf: d.
		         idx isZero ifTrue: [ Error signal: 'Data item not found' ].
		         idx ].
	self notifyDataItemChangeIndexes: idxes
]

{ #category : #notifications }
ToInfiniteCollectionDataSource >> notifyChangedDataItem: aDataItem [

	| idx |
	idx := self indexOf: aDataItem.
	idx isZero ifTrue: [ Error signal: 'Data item not found' ].
	self notifyDataItemChangeIndex: idx
]

{ #category : #hooks }
ToInfiniteCollectionDataSource >> onAttached: anInfiniteElement [

	super onAttached: anInfiniteElement.
	dataEventHandler := ToInfiniteDataSourceDataEventHandler new.
	dataEventHandler infinite: anInfiniteElement.
	self addEventHandler: dataEventHandler
]

{ #category : #'instance creation' }
ToInfiniteCollectionDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Update holder's model"

	anElementHolder bindDataItem: (self at: aPosition)
]

{ #category : #hooks }
ToInfiniteCollectionDataSource >> onDetached: anInfiniteElement [

	self removeEventHandler: dataEventHandler.
	dataEventHandler := nil.
	super onDetached: anInfiniteElement.


	
]
