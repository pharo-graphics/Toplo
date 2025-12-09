"
A toplo element is basically a BlElement.

"
Class {
	#name : #ToDemo0,
	#superclass : #BlElement,
	#category : #'Toplo-Demo-1 - Basic'
}

{ #category : #examples }
ToDemo0 class >> example [

	| dem |
	dem := ToDemo0 new.
	dem background: Color red.
	dem border: Color black.
	dem openInSpace
]

{ #category : #examples }
ToDemo0 class >> example2 [

	| dem pane |
	pane := ToPane vertical.
	dem := ToDemo0 new.
	dem background: Color red.
	dem border: Color black.
	pane addChild: dem.
	pane openInSpace
]
