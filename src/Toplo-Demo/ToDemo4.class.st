Class {
	#name : #ToDemo4,
	#superclass : #BlElement,
	#category : #'Toplo-Demo-1 - Basic'
}

{ #category : #examples }
ToDemo4 class >> example0 [

	| dem |
	dem := ToDemo4 new.
	dem openInSpace
]

{ #category : #skin }
ToDemo4 >> newRawSkin [ 

	^ ToDemoSkin2 new
]

{ #category : #'hooks - children' }
ToDemo4 >> onAddedToSceneGraph [

	super onAddedToSceneGraph.
	self ensuredSkinManager requestInstallSkinIn: self.
	self addEventHandler: ToSkinStateGenerator new
]
