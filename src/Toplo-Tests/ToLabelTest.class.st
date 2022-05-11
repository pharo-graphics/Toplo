"
A ToLabelTest is a test class for testing the behavior of ToLabel
"
Class {
	#name : #ToLabelTest,
	#superclass : #ToTestCase,
	#category : #'Toplo-Tests-Widgets'
}

{ #category : #test }
ToLabelTest >> testHAlignment [

	| label |
	label := ToLabel new.
	self assert: label hAlignment equals: #left. 

	label hAlignment: #center.
	self assert: label hAlignment equals: #center. 

	label hAlignment: #right.
	self assert: label hAlignment equals: #right. 
	
	label hAlignment: #left.
	self assert: label hAlignment equals: #left. 
]

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

{ #category : #test }
ToLabelTest >> testVAlignment [

	| label |
	label := ToLabel new.
	self assert: label vAlignment equals: #center. 

	label vAlignment: #top.
	self assert: label vAlignment equals: #top. 

	label vAlignment: #bottom.
	self assert: label vAlignment equals: #bottom. 
	
	label vAlignment: #center.
	self assert: label vAlignment equals: #center. 
]
