"
I'm a datasource who works with ToFTEasyListMorph.
I receive blocks to provide my contents. 
"
Class {
	#name : #ToFTEasyListDataSource,
	#superclass : #ToFTSimpleDataSource,
	#instVars : [
		'displayBlock',
		'iconBlock',
		'menuBlock'
	],
	#category : #'Toplo-FastTable-Easy'
}

{ #category : #accessing }
ToFTEasyListDataSource >> cellColumn: column row: rowIndex [
	^ ToFTCellMorph new
		cellInset: 5;
		in: [ :me |
			(self iconFor: rowIndex)
				ifNotNil: [ :icon | me addMorphBack: icon asMorph ] ];
		addMorphBack: (self displayFor: rowIndex) asMorph;
		yourself
]

{ #category : #accessing }
ToFTEasyListDataSource >> display: aBlock [
	displayBlock := aBlock
]

{ #category : #private }
ToFTEasyListDataSource >> displayFor: rowIndex [
	| element |
	element := self elementAt: rowIndex.
	^ displayBlock
		ifNotNil: [ displayBlock value: element ]
		ifNil: [ ^ element ]
]

{ #category : #accessing }
ToFTEasyListDataSource >> icon: aBlock [
	iconBlock := aBlock
]

{ #category : #private }
ToFTEasyListDataSource >> iconFor: rowIndex [
	iconBlock ifNil: [ ^ nil ].
	^ iconBlock value: (self elementAt: rowIndex)
]

{ #category : #accessing }
ToFTEasyListDataSource >> menu: aBlock [
	menuBlock := aBlock
]

{ #category : #accessing }
ToFTEasyListDataSource >> menuColumn: column row: rowIndex [
	menuBlock ifNil: [ ^ nil ].
	rowIndex = 0 ifTrue: [
		"I could answer a menu without selection, but in this case I will just answer nil,
		 which means 'no menu'"
		^ nil ].
	^ menuBlock value: (self elementAt: rowIndex)
]
