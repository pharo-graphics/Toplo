Class {
	#name : #ToClassNameViewExample,
	#superclass : #ToElement,
	#category : #'Toplo-Examples'
}

{ #category : #initialization }
ToClassNameViewExample >> class: aClass position: anInteger [

	self addChild: (ToLabeledIcon new
			 beIconFirst;
			 hMatchParent;
			vFitContent;
			 interspace: 10;
			 background: (self colorFor: anInteger);
			 icon: (self iconFor: aClass);
			 labelText: aClass name;
			 yourself)
]

{ #category : #private }
ToClassNameViewExample >> colorFor: index [

	index odd ifTrue: [ ^ self tokenValueNamed: #'color-text-list-selection-focused'].
	^ self tokenValueNamed: #'color-text-list-selection-unfocused'
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
	aClass classComment ifEmpty: [ ^ self iconNamed: #uncommentedClass ].
	((aClass includesBehavior:
		  (Smalltalk globals at: #TestCase ifAbsent: [ false ])) and: [
		 aClass isAbstract not ]) ifTrue: [
		aClass hasPassedTest ifTrue: [ ^ self iconNamed: #testGreen ].
		aClass hasFailedTest ifTrue: [ ^ self iconNamed: #testYellow ].
		aClass hasErrorTest ifTrue: [ ^ self iconNamed: #testRed ].
		^ self iconNamed: #testNotRun ].
	aClass classComment ifEmpty: [ ^ self iconNamed: #uncommentedClass ].
	^ self iconNamed: aClass systemIconName
]

{ #category : #initialization }
ToClassNameViewExample >> initialize [ 

	super initialize.
	self hMatchParent.
	self vFitContent.
	self withoutSkin
]
