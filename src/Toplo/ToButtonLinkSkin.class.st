Class {
	#name : #ToButtonLinkSkin,
	#superclass : #ToButtonUnborderedSkin,
	#classTraits : 'TObservable classTrait',
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkSkin >> onInstalledIconIn: anElement [

	super onInstalledIconIn: anElement.
	anElement icon ifNil: [ ^ self ].
	self danger ifFalse: [ anElement icon addLook: ToImageLinkLook new ]
]

{ #category : #'api - install/uninstall  hook' }
ToButtonLinkSkin >> onInstalledLabelIn: anElement [

	super onInstalledLabelIn: anElement.
	anElement label ifNil: [ ^ self ].
	self danger ifFalse: [ anElement label addLook: ToLabelLinkLook new ]
]
