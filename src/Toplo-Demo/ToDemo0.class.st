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
