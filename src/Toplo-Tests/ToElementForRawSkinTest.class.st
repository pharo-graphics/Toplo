Class {
	#name : #ToElementForRawSkinTest,
	#superclass : #ToElement,
	#instVars : [
		'styleInstalled',
		'styleUninstalled'
	],
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #skin }
ToElementForRawSkinTest >> installRawStyle [

	super installRawStyle.
	styleInstalled := true
]

{ #category : #skin }
ToElementForRawSkinTest >> newRawSkin [ 

	^ ToRawSkin new
]

{ #category : #accessing }
ToElementForRawSkinTest >> styleInstalled [

	^ styleInstalled ifNil: [ styleInstalled := false ]
]

{ #category : #accessing }
ToElementForRawSkinTest >> styleUninstalled [

	^ styleUninstalled ifNil: [ styleUninstalled := false ]
]

{ #category : #skin }
ToElementForRawSkinTest >> uninstallRawStyle [

	super uninstallRawStyle.
	styleUninstalled := true
]
