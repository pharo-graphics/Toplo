Class {
	#name : #ToLookAndFeelTestCase,
	#superclass : #TestCase,
	#instVars : [
		'useLookAndFeel'
	],
	#category : #'Toplo-LookAndFeel-Tests-Core'
}

{ #category : #running }
ToLookAndFeelTestCase >> setUp [

	super setUp.

	useLookAndFeel := Toplo useLookAndFeel.
	Toplo useLookAndFeel: true
]

{ #category : #running }
ToLookAndFeelTestCase >> tearDown [

	Toplo useLookAndFeel: useLookAndFeel.

	super tearDown
]
