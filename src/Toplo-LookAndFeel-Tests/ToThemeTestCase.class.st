Class {
	#name : #ToThemeTestCase,
	#superclass : #TestCase,
	#category : #'Toplo-LookAndFeel-Tests-Theme'
}

{ #category : #tests }
ToThemeTestCase >> setUp [ 

	super setUp.
	ToAbstractTheme cleanUp.
]
