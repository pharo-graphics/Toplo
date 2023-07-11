Class {
	#name : #ToButtonTextSkin,
	#superclass : #ToButtonUnborderedSkin,
	#classTraits : 'TObservable classTrait',
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonTextSkin >> hasBackground [ 

	^ true
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextSkin >> onInstalledIconIn: anElement [

	super onInstalledIconIn: anElement.
	anElement icon ifNil: [ ^ self ].
	self danger ifFalse: [ anElement icon addLook: ToImageTextLook new ]
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextSkin >> onInstalledLabelIn: anElement [

	super onInstalledLabelIn: anElement.
	anElement label ifNil: [ ^ self ].
	self danger ifFalse: [ anElement label addLook: ToLabelTextLook new ]
]

{ #category : #'api - install/uninstall  hook' }
ToButtonTextSkin >> whenAddedToSpace: anEvent in: anElement [

	super whenAddedToSpace: anEvent in: anElement.
	self danger
		ifTrue: [ self addLook: ToButtonTextDangerLook new ]
		ifFalse: [ self addLook: ToButtonTextLook new ]
]
