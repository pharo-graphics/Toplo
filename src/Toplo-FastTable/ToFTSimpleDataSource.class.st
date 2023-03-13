"
I'm a simple datasource and just implement a direct-to-table provision of my elements.  I can work with the default implementation of ToFTTableMorph. 

Users might want to subclass me to have better options.
"
Class {
	#name : #ToFTSimpleDataSource,
	#superclass : #ToFTDataSource,
	#instVars : [
		'elements',
		'unsortedElements'
	],
	#category : #'Toplo-FastTable-DataSource'
}

{ #category : #'instance creation' }
ToFTSimpleDataSource class >> data: aCollection [
	^ self new data: aCollection
]

{ #category : #accessing }
ToFTSimpleDataSource >> cellColumn: column row: rowIndex [

	^ ToFTCellElement new
		addMorphBack: (self dataAt: rowIndex) asElement;
		yourself
]

{ #category : #accessing }
ToFTSimpleDataSource >> data [
	^ elements
]

{ #category : #accessing }
ToFTSimpleDataSource >> data: aCollection [
	elements := aCollection
]

{ #category : #accessing }
ToFTSimpleDataSource >> dataAt: index [
	^ self data at: index
]

{ #category : #accessing }
ToFTSimpleDataSource >> headerColumn: column [
	^ self basicHeaderCellFor: column
]

{ #category : #accessing }
ToFTSimpleDataSource >> newDataSourceMatching: aToFTFilter [
	| newElements |
	newElements := Array withAll: (elements select: [ :each |
		aToFTFilter matches: (self toString: each) ]).
	^ self class new data: newElements
]

{ #category : #accessing }
ToFTSimpleDataSource >> numberOfRows [
	^ self data
		ifNotNil: [ self data size ]
		ifNil: [ 0 ]
]

{ #category : #accessing }
ToFTSimpleDataSource >> searchText: aString [
	| result |
	aString isEmptyOrNil ifTrue: [ ^ #() ].
	result := OrderedCollection new.
	self data withIndexDo: [ :each :index |
		((self toString: each) beginsWith: aString)
			ifTrue: [ result add: index ] ].
	^ result asArray
]

{ #category : #sorting }
ToFTSimpleDataSource >> sortElements: aSortFunction [
	unsortedElements ifNil: [ unsortedElements := self data ].
	self data: (self data sorted: aSortFunction)
]

{ #category : #sorting }
ToFTSimpleDataSource >> unsortElements [
	unsortedElements ifNil: [ ^ self ].

	self data: unsortedElements.
	unsortedElements := nil
]
