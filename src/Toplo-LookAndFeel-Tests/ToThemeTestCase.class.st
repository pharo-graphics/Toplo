Class {
	#name : #ToThemeTestCase,
	#superclass : #ToLookAndFeelTestCase,
	#category : #'Toplo-LookAndFeel-Tests-Theme'
}

{ #category : #tests }
ToThemeTestCase >> setUp [ 

	super setUp.
	ToAbstractTheme cleanUp.
]
