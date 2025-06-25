"
I'm part of a larger example. I'm not expected to be opened as a standalone. 

Check `ToSandBox >> example_ListWithAllClassesAndTraitsSorted` and `ToMiniBrowser`
"
Class {
	#name : #ToExMiniBrowserClassNodeContent,
	#superclass : #ToLabeledIcon,
	#category : #'Toplo-Examples-TopLevel'
}

{ #category : #initialization }
ToExMiniBrowserClassNodeContent >> class: aClass [ 

	self
		beStartToEnd;
		hMatchParent;
		vFitContent;
		startInterspace: 10;
		endInterspace: 5;
		endFlexible: true;
		icon: (self iconFor: aClass);
		label: (ToLabel text: aClass name).
	aClass hasComment ifTrue: [ ^ self ].
	self endElement: (ToImage inner: (self iconNamed: #uncommentedClass))
]

{ #category : #private }
ToExMiniBrowserClassNodeContent >> iconFor: aClass [

	^ ToImage inner: (self iconImageFor: aClass)
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
	^ self iconNamed: aClass systemIconName
]
