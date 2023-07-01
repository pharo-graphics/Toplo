Class {
	#name : #ToploTest,
	#superclass : #TestCase,
	#instVars : [
		'useLookAndFeel'
	],
	#category : #'Toplo-Tests-Core'
}

{ #category : #tests }
ToploTest >> setUp [ 

	super setUp.

	useLookAndFeel := Toplo useLookAndFeel.
	useLookAndFeel ifTrue:[Toplo useLookAndFeel: false].
]

{ #category : #tests }
ToploTest >> tearDown [  

	useLookAndFeel ifTrue:[Toplo useLookAndFeel: true].

	super tearDown.
]

{ #category : #tests }
ToploTest >> testUseLookAndFeel [

	self assert: Toplo useLookAndFeel not.

	Toplo useLookAndFeel: true.
	self assert: Toplo useLookAndFeel.
	
	Toplo useLookAndFeel: false.
	self assert: Toplo useLookAndFeel not.
]
