"
I am an abstract class. My subclasses are some functions for a FastTable as search or filter.

Description
-------------------------------------------------
I can be use in two way.  Implicitely I will not appear on the FastTable. Explicitely I can display a Widget on the FastTable.
I work with  a ToFTTableMorph. I cannot be use alone.

Public API and Key Messages
-------------------------------------------------

- #table: aTableMorph
	is my constructor
	
- #keyStroke: anEvent
	This is the method that will allow to use me implicitely. With this I will receive an event from the FastTable.
	
- #beExplicite
	This method will make my functionnality explicit. For example the ToFTFilterFunction will display a filter field.
	
Example (Should only be create by a ToFTTableMorph)
-------------------------------------------------

ToFTFunction table: (ToFTTableMorph with: (1 to: 200))


Internal Representation and Key Implementation Points.
-------------------------------------------------

    Instance Variables
	table 	I am a ToFTTableMorph that use this function.

"
Class {
	#name : #ToFTFunction,
	#superclass : #Object,
	#instVars : [
		'table'
	],
	#category : #'Toplo-FastTable-Functions'
}

{ #category : #testing }
ToFTFunction class >> isAbstract [
	^ self = ToFTFunction
]

{ #category : #'instance creation' }
ToFTFunction class >> new [
	self error: 'Use #table:'
]

{ #category : #'instance creation' }
ToFTFunction class >> table: aFastTableMorph [
	^ self basicNew
		initializeTable: aFastTableMorph;
		yourself
]

{ #category : #accessing }
ToFTFunction >> beExplicit [
	"This method is call by the FastTable if the user want the widget to be explicit. Describe what to do to be explicit."

	self subclassResponsibility
]

{ #category : #protocol }
ToFTFunction >> disable [
	"I am call when a FastTable disable a function."

	self subclassResponsibility
]

{ #category : #initialization }
ToFTFunction >> initializeTable: aTable [
	table := aTable.
	self initialize
]

{ #category : #testing }
ToFTFunction >> isExplicit [
	"See ToFTFunctionWithField to get an example."

	self subclassResponsibility
]

{ #category : #'event handling' }
ToFTFunction >> keyDown: anEvent [
	"If the widget is implicit this method will be call if the user want to communicate with the widget."

	"Do not handle the event by default"
	^ false
]

{ #category : #'event handling' }
ToFTFunction >> keyStroke: anEvent [
	"If the widget is implicit this method will be call if the user want to communicate with the widget."

	self subclassResponsibility
]

{ #category : #initialization }
ToFTFunction >> reset [
	self subclassResponsibility
]

{ #category : #private }
ToFTFunction >> resizeContainerFrom: topLefPoint to: bottomRightPoint [
	"I takes takes the bounds of the container of the Fast Table. I return a rectangle that is the bounds of the container."

	self subclassResponsibility
]

{ #category : #private }
ToFTFunction >> resizeWidget [
	self subclassResponsibility
]

{ #category : #accessing }
ToFTFunction >> showWidget [
	"A FastTable can have a special function. Most of these functions are hidden by default. This method make them explicit.
	For exemple a FastTable can have a search field. By default the user need to type to show it. With this method the widget should be alwayse visible.
	My subclasses should describe what to do to be explicit."

	self subclassResponsibility
]

{ #category : #accessing }
ToFTFunction >> table [
	^ table
]
