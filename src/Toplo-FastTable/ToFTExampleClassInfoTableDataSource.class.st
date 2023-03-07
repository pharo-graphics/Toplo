"
I'm an example of fast table, who will use a list of classes as data source elements.

"
Class {
	#name : #ToFTExampleClassInfoTableDataSource,
	#superclass : #ToFTSimpleDataSource,
	#category : #'Toplo-FastTable-Examples'
}

{ #category : #accessing }
ToFTExampleClassInfoTableDataSource >> cellColumn: column row: rowIndex [
	column id = 'Icon' ifTrue: [ ^ self iconColumn: column row: rowIndex ].
	column id = 'Name' ifTrue: [ ^ self nameColumn: column row: rowIndex ].
	column id = 'Number of methods' ifTrue: [ ^ self numberOfMethodsColumn: column row: rowIndex ].
	column id = 'Number of instance variables' ifTrue: [ ^ self numberOfInstanceVariablesColumn: column row: rowIndex ].

	self error: 'Invalid column'
]

{ #category : #accessing }
ToFTExampleClassInfoTableDataSource >> iconColumn: column row: rowIndex [
	^ ToFTCellMorph new
		addMorphBack: (self iconFor: rowIndex) asMorph;
		yourself
]

{ #category : #private }
ToFTExampleClassInfoTableDataSource >> iconFor: index [
	| class |
	class := self elementAt: index.
	((class
		includesBehavior: (Smalltalk globals at: #TestCase ifAbsent: [ false ]))
		and: [ class isAbstract not ])
		ifTrue: [ class hasPassedTest
				ifTrue: [ ^ self iconNamed: #testGreen ].
			class hasFailedTest
				ifTrue: [ ^ self iconNamed: #testYellow ].
			class hasErrorTest
				ifTrue: [ ^ self iconNamed: #testRed ].
			^ self iconNamed: #testNotRun ].
	class organization classComment
		ifEmpty: [ ^ self iconNamed: #uncommentedClass].
	((class
		includesBehavior: (Smalltalk globals at: #TestCase ifAbsent: [ false ]))
		and: [ class isAbstract not ])
		ifTrue: [ class hasPassedTest
				ifTrue: [ ^ self iconNamed: #testGreen ].
			class hasFailedTest
				ifTrue: [ ^ self iconNamed: #testYellow ].
			class hasErrorTest
				ifTrue: [ ^ self iconNamed: #testRed ].
			^ self iconNamed: #testNotRun ].
	class organization classComment
		ifEmpty: [ ^ self iconNamed: #uncommentedClass ].
	^ self iconNamed: class systemIconName
]

{ #category : #initialization }
ToFTExampleClassInfoTableDataSource >> initialize [
	super initialize.
	self elements: Smalltalk allClassesAndTraits shuffled
]

{ #category : #accessing }
ToFTExampleClassInfoTableDataSource >> nameColumn: column row: rowIndex [
	^ ToFTCellMorph new
		addMorphBack: (self elementAt: rowIndex) name asStringMorph;
		yourself
]

{ #category : #accessing }
ToFTExampleClassInfoTableDataSource >> numberOfInstanceVariablesColumn: column row: rowIndex [
	^ ToFTCellMorph new
		addMorph: (self elementAt: rowIndex) instSize asStringMorph;
		yourself
]

{ #category : #accessing }
ToFTExampleClassInfoTableDataSource >> numberOfMethodsColumn: column row: rowIndex [
	^ ToFTCellMorph new
		addMorph: (self elementAt: rowIndex) numberOfMethods asStringMorph;
		yourself
]

{ #category : #accessing }
ToFTExampleClassInfoTableDataSource >> searchText: aString [
	aString isEmptyOrNil ifTrue: [ ^ #() ].

	self elements withIndexDo: [ :each :index | (each name beginsWith: aString) ifTrue: [ ^ {index} ] ].
	^ #()
]
