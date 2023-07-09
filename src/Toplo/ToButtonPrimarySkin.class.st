Class {
	#name : #ToButtonPrimarySkin,
	#superclass : #ToButtonSkin,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimarySkin >> iconChanged: aToButtonIconChangedEvent [

	aToButtonIconChangedEvent current addLook: ToImagePrimaryLook new
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimarySkin >> labelChanged: aToButtonLabelChangedEvent [

	aToButtonLabelChangedEvent current addLook: ToLabelPrimaryLook new
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimarySkin >> mainLookIn: anElement [

	^ ToButtonPrimaryLook new
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimarySkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonPrimarySkin >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]
