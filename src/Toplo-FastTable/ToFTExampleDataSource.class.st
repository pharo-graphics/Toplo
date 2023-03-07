"
I'm a simple example of fast table, who will use a list of classes and traits as data source elements.

ToFTExamples example1.
ToFTExamples example2.
"
Class {
	#name : #ToFTExampleDataSource,
	#superclass : #ToFTSimpleDataSource,
	#category : #'Toplo-FastTable-Examples'
}

{ #category : #accessing }
ToFTExampleDataSource >> cellColumn: column row: rowIndex [
	^ ToFTCellMorph new
		color: (self colorFor: rowIndex);
		cellInset: 5;
		addMorphBack: (self iconFor: rowIndex) asMorph;
		addMorphBack: (self elementAt: rowIndex) name asStringMorph;
		yourself
]

{ #category : #private }
ToFTExampleDataSource >> colorFor: index [
	index odd ifTrue: [ ^ Smalltalk ui theme lightBackgroundColor ].
	^ Smalltalk ui theme backgroundColor
]

{ #category : #private }
ToFTExampleDataSource >> iconFor: index [
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
		ifEmpty: [ ^ self iconNamed: #uncommentedClass ].
	((class
		includesBehavior: (Smalltalk globals at: #TestCase ifAbsent: [ false ]))
		and: [ class isAbstract not ])
		ifTrue: [ class hasPassedTest
				ifTrue: [ ^ self iconNamed: #testGreen].
			class hasFailedTest
				ifTrue: [ ^ self iconNamed: #testYellow].
			class hasErrorTest
				ifTrue: [ ^ self iconNamed: #testRed ].
			^ self iconNamed: #testNotRun ].
	class organization classComment
		ifEmpty: [ ^ self iconNamed: #uncommentedClass ].
	^ self iconNamed: class systemIconName
]
