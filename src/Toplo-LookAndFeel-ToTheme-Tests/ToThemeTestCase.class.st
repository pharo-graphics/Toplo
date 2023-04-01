Class {
	#name : #ToThemeTestCase,
	#superclass : #TestCase,
	#category : #'Toplo-LookAndFeel-ToTheme-Tests-Core'
}

{ #category : #tests }
ToThemeTestCase >> setUp [ 

	super setUp.
	ToAbstractTheme cleanUp.
]
