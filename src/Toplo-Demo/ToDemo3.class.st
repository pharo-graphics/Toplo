Class {
	#name : #ToDemo3,
	#superclass : #BlElement,
	#category : #'Toplo-Demo-1 - Basic'
}

{ #category : #examples }
ToDemo3 class >> example0 [

	| dem |
	dem := ToDemo3 new.
	dem toTheme: ToRawTheme new.
"	dem requestNewSkin."
	dem openInSpace
]

{ #category : #skin }
ToDemo3 >> newRawSkin [ 

	^ ToDemoSkin2 new
]
