"
I'm a data source which will have many list of elements. My goal is to allow a ToFTOutlineTable to render me with separators between my differents items.

Users might want to subclass me to have better options.
"
Class {
	#name : #ToFTOutlineDataSource,
	#superclass : #ToFTDataSource,
	#instVars : [
		'items'
	],
	#category : #'Toplo-FastTable-DataSource'
}

{ #category : #'instance creation' }
ToFTOutlineDataSource class >> items: aCollectionOfCollection [
	" I take a collection of collection of elements."

	^ self new
		items: aCollectionOfCollection;
		yourself
]

{ #category : #accessing }
ToFTOutlineDataSource >> cellColumn: column row: rowIndex [
	| cell |
	cell := ToFTCellMorph new
		addMorphBack: (self elementAt: rowIndex) asMorph;
		yourself.
	(self needSeparatorBefore: rowIndex)
		ifTrue: [ cell withTopSeparator ].
	^ cell
]

{ #category : #accessing }
ToFTOutlineDataSource >> elementAt: index [
	| tmpIndex |
	tmpIndex := index.
	self items
		do: [ :elements |
			tmpIndex <= elements size
				ifTrue: [ ^ elements at: tmpIndex ]
				ifFalse: [ tmpIndex := tmpIndex - elements size ] ].
	self errorSubscriptBounds: index
]

{ #category : #accessing }
ToFTOutlineDataSource >> headerColumn: column [
	^ self basicHeaderCellFor: column
]

{ #category : #accessing }
ToFTOutlineDataSource >> items [
	^ items
]

{ #category : #accessing }
ToFTOutlineDataSource >> items: anObject [
	items := anObject
]

{ #category : #testing }
ToFTOutlineDataSource >> needSeparatorBefore: index [
	| tmpIndex |
	index <= 1
		ifTrue: [ ^ false ].
	tmpIndex := index.
	self items
		do: [ :elements |
			elements size >= tmpIndex
				ifTrue: [ ^ tmpIndex = 1 ]
				ifFalse: [ tmpIndex := tmpIndex - elements size ] ].
	self errorSubscriptBounds: index
]

{ #category : #accessing }
ToFTOutlineDataSource >> newDataSourceMatching: aToFTFilter [
	| newItems |
	newItems := items class withAll: (items collect: [ :coll | coll select: [ :each | aToFTFilter matches: (self toString: each) ] ]).
	^ self class new items: newItems
]

{ #category : #accessing }
ToFTOutlineDataSource >> numberOfRows [
	^ self items
		ifNotNil: [ | cpt |
			cpt := 0.
			self items do: [ :elements | cpt := cpt + elements size ].
			cpt ]
		ifNil: [ 0 ]
]

{ #category : #accessing }
ToFTOutlineDataSource >> searchText: aString [
	| index result |
	aString isEmptyOrNil
		ifTrue: [ ^ #() ].
	index := 0.
	result := OrderedCollection new.
	self items
		do: [ :elements |
			elements
				do: [ :each |
					index := index + 1.
					((self toString: each) beginsWith: aString)
						ifTrue: [ result add: index ] ] ].
	^ result asArray
]
