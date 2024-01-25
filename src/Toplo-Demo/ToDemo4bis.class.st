Class {
	#name : #ToDemo4bis,
	#superclass : #ToElement,
	#category : #'Toplo-Demo-1 - Basic'
}

{ #category : #examples }
ToDemo4bis class >> example0 [

	| dem |
	dem := ToDemo4bis new.
	dem openInSpace
]

{ #category : #skin }
ToDemo4bis >> newRawSkin [ 

	^ ToDemoSkin2 new
]
