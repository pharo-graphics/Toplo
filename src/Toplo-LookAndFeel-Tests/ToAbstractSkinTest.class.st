"
A ToAbstractSkinTest is a test class for testing the behavior of ToAbstractSkin
"
Class {
	#name : #ToAbstractSkinTest,
	#superclass : #ToLookAndFeelTestCase,
	#category : #'Toplo-LookAndFeel-Tests-Core'
}

{ #category : #test }
ToAbstractSkinTest >> testToken [

	| skin |
	skin := ToAbstractSkin new.
	self assert: (skin token: #notDefined) equals: nil
]

{ #category : #test }
ToAbstractSkinTest >> testTokenValue [

	| skin |
	skin := ToAbstractSkin new.
	self assert: (skin token: #property) isNil.
	
	skin token: #property value: true.
	self assert: (skin token: #property).
]

{ #category : #test }
ToAbstractSkinTest >> testType [

	| skin |
	skin := ToAbstractSkin new.
	self assert: skin type equals: #default.
	self assert: skin type equals: ToAbstractSkin type.
]
