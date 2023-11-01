Class {
	#name : 'ToRawTheme',
	#superclass : 'ToTheme',
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'accessing' }
ToRawTheme >> name [

	^ #'RawTheme'
]

{ #category : 'accessing' }
ToRawTheme >> newSkinInstaller [

	^ ToRawSkinInstaller new
]

{ #category : 'accessing' }
ToRawTheme >> skinFor: anElement [

	^ anElement rawSkin
]
