Class {
	#name : #ToInfiniteDataSource,
	#superclass : #OBlInfiniteDataSource,
	#instVars : [
		'list'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToInfiniteDataSource >> initialize [
	super initialize.

	list := OrderedCollection new
]

{ #category : #accessing }
ToInfiniteDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ list size
]

{ #category : #accessing }
ToInfiniteDataSource >> itemTypeAt: aPosition [
	"All my items are homogene, it is enough to use 0"

	^ 0
]

{ #category : #accessing }
ToInfiniteDataSource >> list [

	^ list
]

{ #category : #accessing }
ToInfiniteDataSource >> list: aList [

	list addAll: aList
]

{ #category : #'instance creation' }
ToInfiniteDataSource >> onBindHolder: anElementHolder at: aPosition [

	"Update holder's model"
	anElementHolder data: (list at: aPosition)
]

{ #category : #'instance creation' }
ToInfiniteDataSource >> onCreateHolder: anInfiniteElement type: anItemType [

	^ ToInfiniteElementHolder new
]
