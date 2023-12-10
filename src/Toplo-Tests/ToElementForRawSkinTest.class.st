Class {
	#name : 'ToElementForRawSkinTest',
	#superclass : 'BlElement',
	#instVars : [
		'styleInstalled',
		'styleUninstalled'
	],
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'skin' }
ToElementForRawSkinTest >> installRawStyle [

	super installRawStyle.
	styleInstalled := true
]

{ #category : 'accessing' }
ToElementForRawSkinTest >> styleInstalled [

	^ styleInstalled ifNil: [ styleInstalled := false ]
]

{ #category : 'accessing' }
ToElementForRawSkinTest >> styleUninstalled [

	^ styleUninstalled ifNil: [ styleUninstalled := false ]
]

{ #category : 'skin' }
ToElementForRawSkinTest >> uninstallRawStyle [

	super uninstallRawStyle.
	styleUninstalled := true
]
