"
I am an abstract class. My subclasses are some functions for a FastTable that need a field when they are use explicitely.

Description
-------------------------------------------------
I act as my superclass but I manage a field. When the user type in the field an Announcement will call #update:

Public API and Key Messages
-------------------------------------------------

- #update: anAnnoucement
	is call when the user type something into the field
	
Example (Should only be create by a ToFTTableMorph)
-------------------------------------------------

ToFTFunctionWithField table: (ToFTTableMorph with: (1 to: 200))

Internal Representation and Key Implementation Points.
-------------------------------------------------

    Instance Variables
	field:		I am the field to display at the bottom of the ToFTTableMorph
"
Class {
	#name : #ToFTFieldFunction,
	#superclass : #ToFTFunction,
	#instVars : [
		'field'
	],
	#category : #'Toplo-FastTable-Functions'
}

{ #category : #testing }
ToFTFieldFunction class >> isAbstract [
	^ self = ToFTFieldFunction
]

{ #category : #accessing }
ToFTFieldFunction >> beExplicit [
	self initializeMorph.
	table
		addMorph: field;
		resizeAllSubviews
]

{ #category : #protocol }
ToFTFieldFunction >> disable [
	field
		ifNotNil: [ field delete.
			field := nil ]
]

{ #category : #accessing }
ToFTFieldFunction >> fieldHeigh [
	^ StandardFonts defaultFont pixelSize + 10
]

{ #category : #'widget API' }
ToFTFieldFunction >> ghostText [
	self subclassResponsibility
]

{ #category : #initialization }
ToFTFieldFunction >> initializeMorph [
	field := RubScrolledTextModel new newTextField
		hResizing: #spaceFill;
		autoAccept: true;
		withGhostText: self ghostText;
		yourself.
	field model announcer when: RubTextUpdatedInModel send: #textUpdated: to: self
]

{ #category : #testing }
ToFTFieldFunction >> isExplicit [
	^ field isNotNil
]

{ #category : #private }
ToFTFieldFunction >> resizeContainerFrom: topLeftPoint to: bottomLeftPoint [
	^ topLeftPoint corner: bottomLeftPoint x @ (bottomLeftPoint y - self fieldHeigh)
]

{ #category : #private }
ToFTFieldFunction >> resizeWidget [
	| topLeft bottomRight |
	self flag: #pharoTodo.	"Maybe it could be cool to let the user choose if the field need to be at the top or the bottom."
	topLeft := table bounds left @ (table bounds bottom - self fieldHeigh - table horizontalScrollBarHeight ).
	bottomRight := (table bounds right - table verticalScrollBarWidth) @ (table bottom - table horizontalScrollBarHeight).
	field bounds: (topLeft corner: bottomRight)
]

{ #category : #accessing }
ToFTFieldFunction >> showWidget [
	self initializeMorph.
	table
		addMorph: field;
		resizeAllSubviews
]

{ #category : #updating }
ToFTFieldFunction >> textUpdated: anAnnouncement [

	"do nothing by default"
]
