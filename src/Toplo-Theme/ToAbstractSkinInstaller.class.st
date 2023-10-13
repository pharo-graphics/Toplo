Class {
	#name : #ToAbstractSkinInstaller,
	#superclass : #Object,
	#category : #'Toplo-Theme-Core'
}

{ #category : #hook }
ToAbstractSkinInstaller >> applyOn: anElement [

	(self defaultSkinIn: anElement) ifNotNil: [ :found |
		anElement privateSkin: found.
		anElement addEventHandler: found.
		anElement skinInstaller: nil.
		anElement dispatchSkinChangedEvent ]
]

{ #category : #accessing }
ToAbstractSkinInstaller >> defaultSkinIn: anElement [

	^ self subclassResponsibility 
]
