Class {
	#name : 'ToSkinInstaller',
	#superclass : 'Object',
	#category : 'Toplo-Theme-Core',
	#package : 'Toplo-Theme',
	#tag : 'Core'
}

{ #category : 'hook' }
ToSkinInstaller >> applyOn: anElement [

	anElement installedSkin ifNotNil: [ :s |
		anElement removeEventHandler: s ].
	(self defaultSkinIn: anElement) ifNotNil: [ :found |
		anElement installedSkin: found.
		anElement addEventHandler: found.
		anElement skinInstaller: nil.
		anElement dispatchSkinChangedEvent ]
]

{ #category : 'accessing' }
ToSkinInstaller >> defaultSkinIn: anElement [

	^ anElement defaultSkin
]
