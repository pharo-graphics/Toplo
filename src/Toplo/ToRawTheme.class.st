Class {
	#name : 'ToRawTheme',
	#superclass : 'ToTheme',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'accessing' }
ToRawTheme >> name [

	^ #'RawTheme'
]

{ #category : 'accessing' }
ToRawTheme >> newSkinFor: anElement [

	^ anElement newRawSkin
]
