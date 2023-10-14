Class {
	#name : 'ToExplicitSkinInstaller',
	#superclass : 'ToAbstractSkinInstaller',
	#instVars : [
		'skin'
	],
	#category : 'Toplo-Theme-Core',
	#package : 'Toplo-Theme',
	#tag : 'Core'
}

{ #category : 'hook' }
ToExplicitSkinInstaller >> defaultSkinIn: anElement [

	^ self skin
]

{ #category : 'accessing' }
ToExplicitSkinInstaller >> skin [

	^ skin
]

{ #category : 'accessing' }
ToExplicitSkinInstaller >> skin: aSkin [

	skin := aSkin
]
