"
A ToLabelTest is a test class for testing the behavior of ToLabel
"
Class {
	#name : #ToLabelTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Widgets'
}

{ #category : #test }
ToLabelTest >> testText [

	| label |
	label := ToLabel new.
	self assert: label text isNil.
	
	label text: ''.
	self assert: label text equals: ''.
	
	label text: 'This is a text'.
	self assert: label text equals: 'This is a text'.
	
	label text: nil.
	self assert: label text isNil. 
]
