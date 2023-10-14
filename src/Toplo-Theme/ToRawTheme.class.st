Class {
	#name : 'ToRawTheme',
	#superclass : 'ToTheme',
	#category : 'Toplo-Theme-Core',
	#package : 'Toplo-Theme',
	#tag : 'Core'
}

{ #category : 'accessing' }
ToRawTheme >> name [

	^ #'RawTheme'
]

{ #category : 'accessing' }
ToRawTheme >> skinBuilder [

	^ ToRawSkinBuilder new
]
