Class {
	#name : #ToClassToNodeConverterExample,
	#superclass : #ToDataToElementConverter,
	#category : #'Toplo-Examples'
}

{ #category : #private }
ToClassToNodeConverterExample >> colorFor: index [

	index odd ifTrue: [ ^ Smalltalk ui theme lightBackgroundColor darker ].
	^ Smalltalk ui theme backgroundColor 
]

{ #category : #evaluating }
ToClassToNodeConverterExample >> cull: aClass cull: anHolder [

	^ ToLabeledNode new
		  beIconFirst;
		  hMatchParent;
		  background: (self colorFor: anHolder position);
		  icon: (self iconFor: aClass);
		  labelText: aClass name;
		  yourself
]

{ #category : #private }
ToClassToNodeConverterExample >> iconFor: aClass [

	^ ToImage new innerImage: (self iconImageFor: aClass)
]

{ #category : #private }
ToClassToNodeConverterExample >> iconImageFor: aClass [

	((aClass
		includesBehavior: (Smalltalk globals at: #TestCase ifAbsent: [ false ]))
		and: [ aClass isAbstract not ])
		ifTrue: [ aClass hasPassedTest
				ifTrue: [ ^ self iconNamed: #testGreen ].
			aClass hasFailedTest
				ifTrue: [ ^ self iconNamed: #testYellow ].
			aClass hasErrorTest
				ifTrue: [ ^ self iconNamed: #testRed ].
			^ self iconNamed: #testNotRun ].
	aClass organization classComment
		ifEmpty: [ ^ self iconNamed: #uncommentedClass ].
	((aClass
		includesBehavior: (Smalltalk globals at: #TestCase ifAbsent: [ false ]))
		and: [ aClass isAbstract not ])
		ifTrue: [ aClass hasPassedTest
				ifTrue: [ ^ self iconNamed: #testGreen].
			aClass hasFailedTest
				ifTrue: [ ^ self iconNamed: #testYellow].
			aClass hasErrorTest
				ifTrue: [ ^ self iconNamed: #testRed ].
			^ self iconNamed: #testNotRun ].
	aClass organization classComment
		ifEmpty: [ ^ self iconNamed: #uncommentedClass ].
	^ self iconNamed: aClass systemIconName
]
