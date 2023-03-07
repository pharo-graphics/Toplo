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
ToFTSimpleDataSource class >> elements: aCollection [
	^ self new elements: aCollection
]

{ #category : #accessing }
ToFTSimpleDataSource >> cellColumn: column row: rowIndex [
	^ ToFTCellMorph new
		addMorphBack: (self elementAt: rowIndex) asMorph;
		yourself
]

{ #category : #accessing }
ToFTSimpleDataSource >> elementAt: index [
	^ self elements at: index
]

{ #category : #accessing }
ToFTSimpleDataSource >> elements [
	^ elements
]

{ #category : #accessing }
ToFTSimpleDataSource >> elements: anObject [
	elements := anObject
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
	^ self class new elements: newElements
]

{ #category : #accessing }
ToFTSimpleDataSource >> numberOfRows [
	^ self elements
		ifNotNil: [ self elements size ]
		ifNil: [ 0 ]
]

{ #category : #accessing }
ToFTSimpleDataSource >> searchText: aString [
	| result |
	aString isEmptyOrNil ifTrue: [ ^ #() ].
	result := OrderedCollection new.
	self elements withIndexDo: [ :each :index |
		((self toString: each) beginsWith: aString)
			ifTrue: [ result add: index ] ].
	^ result asArray
]

{ #category : #sorting }
ToFTSimpleDataSource >> sortElements: aSortFunction [
	unsortedElements ifNil: [ unsortedElements := self elements ].
	self elements: (self elements sorted: aSortFunction)
]

{ #category : #sorting }
ToFTSimpleDataSource >> unsortElements [
	unsortedElements ifNil: [ ^ self ].

	self elements: unsortedElements.
	unsortedElements := nil
]
