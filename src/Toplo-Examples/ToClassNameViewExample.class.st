Class {
	#name : #ToClassNameViewExample,
	#superclass : #ToListNode,
	#category : #'Toplo-Examples'
}

{ #category : #initialization }
ToClassNameViewExample >> class: aClass position: anInteger [

	self addChild: (ToLabeledIcon new
			 beStartToEnd;
			 hMatchParent;
			 vFitContent;
			 startInterspace: 10;
			 background: (self colorFor: anInteger);
			 icon: (self iconFor: aClass);
			 label: (ToLabel text: aClass name);
			 yourself)
]

{ #category : #private }
ToClassNameViewExample >> colorFor: index [

	index odd ifTrue: [ ^ Color transparent].
	^ Color gray alpha: 0.1
]

{ #category : #private }
ToClassNameViewExample >> iconFor: aClass [

	^ ToImage new innerImage: (self iconImageFor: aClass)
]

{ #category : #private }
ToClassNameViewExample >> iconImageFor: aClass [

	((aClass includesBehavior:
		  (Smalltalk globals at: #TestCase ifAbsent: [ false ])) and: [
		 aClass isAbstract not ]) ifTrue: [
		aClass hasPassedTest ifTrue: [ ^ self iconNamed: #testGreen ].
		aClass hasFailedTest ifTrue: [ ^ self iconNamed: #testYellow ].
		aClass hasErrorTest ifTrue: [ ^ self iconNamed: #testRed ].
		^ self iconNamed: #testNotRun ].
	aClass hasComment ifFalse: [ ^ self iconNamed: #uncommentedClass ].
	^ self iconNamed: aClass systemIconName
]

{ #category : #initialization }
ToClassNameViewExample >> initialize [

	super initialize.
	self constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal matchParent ]
]
