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
			 label: (ToLabel new text: aClass name; defaultRawSkin: ToLabelInListSkin new; yourself);
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
	self hMatchParent.
	self vFitContent.
	self withoutSkin
]
