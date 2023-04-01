"
A ToAbstractSkinTest is a test class for testing the behavior of ToAbstractSkin
"
Class {
	#name : #ToAbstractSkinTest,
	#superclass : #TestCase,
	#category : #'Toplo-LookAndFeel-Tests-Skins'
}

{ #category : #test }
ToAbstractSkinTest >> testType [

	| skin |
	skin := ToAbstractSkin new.
	self assert: skin type equals: #default.
	self assert: skin type equals: ToAbstractSkin type.
]
