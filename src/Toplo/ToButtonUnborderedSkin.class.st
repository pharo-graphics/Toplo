Class {
	#name : #ToButtonUnborderedSkin,
	#superclass : #ToButtonSkin,
	#classTraits : 'TObservable classTrait',
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonUnborderedSkin >> onInstalledIconIn: anElement [

	super onInstalledIconIn: anElement.
	anElement icon ifNil: [ ^ self ].
	anElement icon withSkin: ToWidgetSkin new.
	anElement icon addLook: ToButtonImageLook new.
	self danger ifTrue: [ anElement icon addLook: ToImageDangerLook new ]
]

{ #category : #'api - install/uninstall  hook' }
ToButtonUnborderedSkin >> onInstalledLabelIn: anElement [

	super onInstalledLabelIn: anElement.
	anElement label ifNil: [ ^ self ].
	anElement label withSkin: ToWidgetSkin new.
	anElement label addLook: ToButtonLabelLook new.
	self danger ifTrue: [ anElement label addLook: ToLabelDangerLook new ]
]

{ #category : #'api - install/uninstall  hook' }
ToButtonUnborderedSkin >> whenAddedToSpace: anEvent in: anElement [

	super whenAddedToSpace: anEvent in: anElement.
	self addLook: ToButtonUnborderedLook new
]
