Class {
	#name : 'ToAbstractSkinInstaller',
	#superclass : 'Object',
	#category : 'Toplo-Theme-Core',
	#package : 'Toplo-Theme',
	#tag : 'Core'
}

{ #category : 'hook' }
ToAbstractSkinInstaller >> applyOn: anElement [

	anElement privateSkin ifNotNil: [ :s |
		anElement removeEventHandler: s ].
	(self defaultSkinIn: anElement) ifNotNil: [ :found |
		anElement privateSkin: found.
		anElement addEventHandler: found.
		anElement skinInstaller: nil.
		anElement dispatchSkinChangedEvent ]
]

{ #category : 'accessing' }
ToAbstractSkinInstaller >> defaultSkinIn: anElement [

	^ self subclassResponsibility 
]
