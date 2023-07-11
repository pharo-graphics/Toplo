Class {
	#name : #ToButtonPrimarySkin,
	#superclass : #ToButtonSkin,
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #testing }
ToButtonPrimarySkin >> hasBackground [ 

	^ true
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimarySkin >> mainLookIn: anElement [

	^ ToButtonPrimaryLook new
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimarySkin >> onInstalledIconIn: anElement [

	super onInstalledIconIn: anElement.
	anElement icon ifNil: [ ^ self ].
	anElement icon withSkin: ToWidgetSkin new.
	anElement icon addLook: ToImagePrimaryLook new
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimarySkin >> onInstalledLabelIn: anElement [

	super onInstalledLabelIn: anElement.
	anElement label ifNil: [ ^ self ].
	anElement label withSkin: ToWidgetSkin new.
	anElement label addLook: ToLabelPrimaryLook new
]
