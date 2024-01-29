Class {
	#name : #ToDemo2,
	#superclass : #BlElement,
	#category : #'Toplo-Demo-1 - Basic'
}

{ #category : #examples }
ToDemo2 class >> example0 [

	| dem |
	dem := ToDemo2 new.
	dem ensuredSkinManager requestInstallSkinIn: self.
	dem openInSpace
]

{ #category : #skin }
ToDemo2 >> installRawStyle [

	super installRawStyle.
	self background: Color red.
	self border: Color black
]

{ #category : #skin }
ToDemo2 >> newRawSkin [ 

	^ ToDemoSkin1 new
]
