Class {
	#name : #ToLabeledNodeDresser,
	#superclass : #ToNodeDresser,
	#instVars : [
		'selected',
		'textBackup',
		'deselectedBackground'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #'events handling' }
ToLabeledNodeDresser >> addedToSelection: anElement [

	selected := true.
	super addedToSelection: anElement.

]

{ #category : #'api - styles' }
ToLabeledNodeDresser >> deselected: anElement [
	" recover initial background "

	deselectedBackground ifNotNil: [
		self background: deselectedBackground in: anElement.
		deselectedBackground := nil ].
	textBackup ifNotNil: [
		anElement label text rope: textBackup.
		anElement label requestLayout.
		textBackup := nil ]
]

{ #category : #'events handling' }
ToLabeledNodeDresser >> hover: anElement event: anEvent [

	self border: self hoveredBorder in: anElement.
	" do not change the background if selected "
	selected ifFalse: [
		"self background: self hoveredBackground in: anElement" ]
]

{ #category : #initialization }
ToLabeledNodeDresser >> initialize [ 

	super initialize.
	selected := false
]

{ #category : #'events handling' }
ToLabeledNodeDresser >> leaved: anElement event: anEvent [

	self border: self defaultBorder in: anElement.
	selected ifFalse: [
		"self background: self defaultBackground in: anElement" ]


]

{ #category : #'events handling' }
ToLabeledNodeDresser >> leftClicked: anElement [ 
	
	selected ifTrue: [ ^ self ].
	" do not change the background and the border if selected "
	self border: self hoveredBorder in: anElement.
	"self background: self hoveredBackground in: anElement"


]

{ #category : #'events handling' }
ToLabeledNodeDresser >> leftPressed: anElement event: anEvent [

	selected ifTrue: [ ^ self ].
	super leftPressed: anElement event: anEvent
]

{ #category : #'events handling' }
ToLabeledNodeDresser >> removedFromSelection: anElement [

	selected := false.
	super removedFromSelection: anElement.

]

{ #category : #accessing }
ToLabeledNodeDresser >> selected: anElement [

	super selected: anElement.
	deselectedBackground := anElement background.
	self background: self selectionBackground  in: anElement.
	textBackup := anElement label text rope copy.
	anElement label text foreground: self selectionBackground contrastingBlackAndWhiteColor.
	anElement label requestLayout.
	

]

{ #category : #accessing }
ToLabeledNodeDresser >> selectionBackground [

	^ self colorProvider selectedColor
]
