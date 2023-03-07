"
Description
--------------------

I am a morph that can be selected by a user in a FastTable.

I manage the color changes when the user is doing a mouse over or a selection.
"
Class {
	#name : #ToFTSelectableMorph,
	#superclass : #Morph,
	#instVars : [
		'selectionColor',
		'colorBeforeOver'
	],
	#category : #'Toplo-FastTable-Base'
}

{ #category : #initialization }
ToFTSelectableMorph >> defaultColor [
	^ Color transparent
]

{ #category : #initialization }
ToFTSelectableMorph >> initialize [
	super initialize.
	selectionColor := self defaultColor
]

{ #category : #'event handling' }
ToFTSelectableMorph >> mouseEnter: evt [

	colorBeforeOver := self color.
	self color: (selectionColor isTransparent
			 ifTrue: [ self mouseOverColor ]
			 ifFalse: [ self mouseOverColor mixed: 0.5 with: selectionColor ])
]

{ #category : #'event handling' }
ToFTSelectableMorph >> mouseLeave: evt [
	self color: colorBeforeOver
]

{ #category : #accessing }
ToFTSelectableMorph >> mouseOverColor [
	^ self theme mouseOverColor
]

{ #category : #initialization }
ToFTSelectableMorph >> selectionColor [
	^ selectionColor
]

{ #category : #accessing }
ToFTSelectableMorph >> selectionColor: aColor [
	selectionColor := aColor.
	self color: selectionColor
]

{ #category : #accessing }
ToFTSelectableMorph >> table [
	^ self owner ifNotNil: #table
]
