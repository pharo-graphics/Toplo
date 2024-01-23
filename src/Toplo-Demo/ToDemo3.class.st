Class {
	#name : #ToDemo3,
	#superclass : #BlElement,
	#category : #'Toplo-Demo-1-Basic'
}

{ #category : #examples }
ToDemo3 class >> example0 [

	| dem |
	dem := ToDemo3 new.
	dem requestInstallSkin.
	dem addEventHandler: ToSkinStateGenerator new.
	dem openInSpace
]

{ #category : #skin }
ToDemo3 >> newRawSkin [ 

	^ ToDemo3Skin new
]
