"
A ToAbstractThemeTest is a test class for testing the behavior of ToAbstractTheme
"
Class {
	#name : #ToAbstractThemeTest,
	#superclass : #ToLookAndFeelTestCase,
	#category : #'Toplo-LookAndFeel-Tests-Core'
}

{ #category : #tests }
ToAbstractThemeTest >> testDresserFor [

	self assert: (ToAbstractTheme dresserFor: ToButton new) class equals: ToLAFButtonDresser.
	self assert: (ToAbstractTheme dresserFor: ToLabel new) class equals: ToLAFLabelDresser.
	
	"Not working cases"
	self assert: (ToAbstractTheme dresserFor: nil) isNil.
	self assert: (ToAbstractTheme dresserFor: BlElement new) isNil.
]

{ #category : #tests }
ToAbstractThemeTest >> testSkinClassesFor [

	self assert: (ToAbstractTheme current class skinClassesFor: ToButton) notEmpty.
	self assert: (ToAbstractTheme current class skinClassesFor: ToLabel) notEmpty.
	
	"Not working cases"
	self assert: (ToAbstractTheme current class skinClassesFor: nil) isEmpty.
	self assert: (ToAbstractTheme current class skinClassesFor: BlElement new) isEmpty.
]
