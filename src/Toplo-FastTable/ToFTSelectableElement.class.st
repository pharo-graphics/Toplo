"
Description
--------------------

I am a morph that can be selected by a user in a FastTable.

I manage the color changes when the user is doing a mouse over or a selection.
"
Class {
	#name : #ToFTSelectableElement,
	#superclass : #ToElement,
	#instVars : [
		'selectionColor',
		'colorBeforeOver'
	],
	#category : #'Toplo-FastTable-Base'
}

{ #category : #initialization }
ToFTSelectableElement >> defaultColor [
	^ Color transparent
]

{ #category : #initialization }
ToFTSelectableElement >> initialize [
	super initialize.
	selectionColor := self defaultColor
]

{ #category : #'event handling' }
ToFTSelectableElement >> mouseEnter: evt [

	colorBeforeOver := self color.
	self color: (selectionColor isTransparent
			 ifTrue: [ self mouseOverColor ]
			 ifFalse: [ self mouseOverColor mixed: 0.5 with: selectionColor ])
]

{ #category : #'event handling' }
ToFTSelectableElement >> mouseLeave: evt [
	self color: colorBeforeOver
]

{ #category : #accessing }
ToFTSelectableElement >> mouseOverColor [
	^ self theme mouseOverColor
]

{ #category : #initialization }
ToFTSelectableElement >> selectionColor [
	^ selectionColor
]

{ #category : #accessing }
ToFTSelectableElement >> selectionColor: aColor [
	selectionColor := aColor.
	self color: selectionColor
]

{ #category : #accessing }
ToFTSelectableElement >> table [
	^ self owner ifNotNil: #table
]
