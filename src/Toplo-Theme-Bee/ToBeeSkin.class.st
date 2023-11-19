Class {
	#name : #ToBeeSkin,
	#superclass : #ToStyleSheetSkin,
	#category : 'Toplo-Theme-Bee'
}

{ #category : #'event dispatch' }
ToBeeSkin >> dispatchSkinInitialStateRequestTo: anObject [

	super dispatchSkinInitialStateRequestTo: anObject.
	anObject initialBeeStyle
	
]

{ #category : #'event dispatch' }
ToBeeSkin >> dispatchSkinInstallStateRequestTo: anObject [

	super dispatchSkinInstallStateRequestTo: anObject.
	anObject installBeeStyle
	
]

{ #category : #'event dispatch' }
ToBeeSkin >> dispatchSkinUninstallStateRequestTo: anObject [

	super dispatchSkinUninstallStateRequestTo: anObject.
	anObject uninstallBeeStyle
	
]
