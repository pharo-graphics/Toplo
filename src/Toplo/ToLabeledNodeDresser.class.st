Class {
	#name : #ToLabeledNodeDresser,
	#superclass : #ToNodeDresser,
	#instVars : [
		'selected',
		'textBackup',
		'backgroundBackup'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #'events handling' }
ToLabeledNodeDresser >> element: anElement addedInInfiniteDecoration: aDecoration [

	super element: anElement addedInInfiniteDecoration: aDecoration.

	selected ifTrue: [ 
		anElement label text foreground: aDecoration actualBackgroundColor contrastingBlackAndWhiteColor.
		anElement label requestLayout.
		^ self ].
	
	selected := true.
	
	backgroundBackup := anElement background.
	anElement background: Color transparent.

	textBackup := anElement label text rope copy.
	anElement label text foreground: aDecoration actualBackgroundColor contrastingBlackAndWhiteColor.
	anElement label requestLayout

]

{ #category : #'events handling' }
ToLabeledNodeDresser >> element: anElement removedFromInfiniteDecoration: aSelectionDecoration [

	super element: anElement removedFromInfiniteDecoration: aSelectionDecoration.

	selected ifFalse: [ ^ self ].
	selected := false.

	backgroundBackup ifNotNil: [ 
		anElement background: backgroundBackup.
		backgroundBackup := nil].

	textBackup ifNotNil: [
		anElement label text rope: textBackup.
		anElement label requestLayout.
		textBackup := nil ]
]

{ #category : #'events handling' }
ToLabeledNodeDresser >> hover: anElement event: anEvent [

	"self border: self hoveredBorder in: anElement."
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

	"self border: self defaultBorder in: anElement."
	selected ifFalse: [
		"self background: self defaultBackground in: anElement" ]


]

{ #category : #'events handling' }
ToLabeledNodeDresser >> leftClicked: anElement [ 
	
	selected ifTrue: [ ^ self ].
	" do not change the background and the border if selected "
	"self border: self hoveredBorder in: anElement."
	"self background: self hoveredBackground in: anElement"


]

{ #category : #'events handling' }
ToLabeledNodeDresser >> leftPressed: anElement event: anEvent [

	selected ifTrue: [ ^ self ].
	super leftPressed: anElement event: anEvent
]

{ #category : #accessing }
ToLabeledNodeDresser >> selectionBackground [

	^ self colorProvider selectedColor
]
