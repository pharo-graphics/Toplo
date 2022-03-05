Class {
	#name : #ToEditorTextFlowLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'pushLine',
		'shouldFillLine',
		'breakLineBefore',
		'breakLineAfter',
		'assignedLine'
	],
	#category : #'Toplo-Editor-Layout'
}

{ #category : #accessing }
ToEditorTextFlowLayoutConstraints >> assignToLine: aBrEditorTextFlowLine [
	assignedLine := aBrEditorTextFlowLine
]

{ #category : #accessing }
ToEditorTextFlowLayoutConstraints >> assignedLine [
	^ assignedLine
]

{ #category : #accessing }
ToEditorTextFlowLayoutConstraints >> breakLineAfter [
	"Mark an element such that a line should be broken AFTER it"

	breakLineAfter := true
]

{ #category : #accessing }
ToEditorTextFlowLayoutConstraints >> breakLineBefore [
	"Mark an element such that a line should be broken BEFORE it"

	breakLineBefore := true
]

{ #category : #accessing }
ToEditorTextFlowLayoutConstraints >> doNotFillLine [
	shouldFillLine := false
]

{ #category : #initialization }
ToEditorTextFlowLayoutConstraints >> initialize [
	super initialize.
	
	breakLineBefore := false.
	breakLineAfter := false.
	pushLine := false.
	shouldFillLine := true
]

{ #category : #accessing }
ToEditorTextFlowLayoutConstraints >> pushLine [
	"Mark an element such that it will be pushed to the new line after the current line"
	
	pushLine := true
]

{ #category : #testing }
ToEditorTextFlowLayoutConstraints >> shouldBreakLineAfter [
	"Return true if current line should be broken AFTER an element, false otherwise"
	<return: #Boolean>

	^ breakLineAfter
]

{ #category : #testing }
ToEditorTextFlowLayoutConstraints >> shouldBreakLineBefore [
	"Return true if current line should be broken BEFORE an element, false otherwise"
	<return: #Boolean>

	^ breakLineBefore
]

{ #category : #testing }
ToEditorTextFlowLayoutConstraints >> shouldFillLine [
	"Return true if the element should fill all available space in the line if it is the last element"

	^ shouldFillLine
]

{ #category : #testing }
ToEditorTextFlowLayoutConstraints >> shouldPushLine [
	"Return true if an element should be pushed to the new line after the end of the current line, false otherwise"
	<return: #Boolean>
	
	^ pushLine
]
