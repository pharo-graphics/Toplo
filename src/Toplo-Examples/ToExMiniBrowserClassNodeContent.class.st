"
I'm part of a larger example. I'm not expected to be opened as a standalone. 

Check `ToSandBox >> example_ListWithAllClassesAndTraitsSorted` and `ToMiniBrowser`
"
Class {
	#name : #ToExMiniBrowserClassNodeContent,
	#superclass : #ToElement,
	#category : #'Toplo-Examples-TopLevel'
}

{ #category : #initialization }
ToExMiniBrowserClassNodeContent >> class: aClass position: anInteger [

	self addChild: (ToLabeledIcon new
			 beStartToEnd;
			 hFitContent;
			 vFitContent;
			 startInterspace: 10;
			 icon: (self iconFor: aClass);
			 label: (ToLabel text: aClass name);
			 yourself)
]

{ #category : #private }
ToExMiniBrowserClassNodeContent >> colorFor: index [

	index odd ifTrue: [ ^ Color transparent].
	^ Color gray alpha: 0.1
]

{ #category : #private }
ToExMiniBrowserClassNodeContent >> iconFor: aClass [

	^ ToImage new innerImage: (self iconImageFor: aClass)
]

{ #category : #private }
ToExMiniBrowserClassNodeContent >> iconImageFor: aClass [

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
