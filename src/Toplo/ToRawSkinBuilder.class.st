Class {
	#name : 'ToRawSkinBuilder',
	#superclass : 'ToAbstractSkinBuilder',
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'skin building' }
ToRawSkinBuilder >> skinFor: anElement [

	^ anElement rawSkin
]
