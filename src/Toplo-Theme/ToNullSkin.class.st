Class {
	#name : 'ToNullSkin',
	#superclass : 'ToSkin',
	#category : 'Toplo-Theme-Core',
	#package : 'Toplo-Theme',
	#tag : 'Core'
}

{ #category : 'testing' }
ToNullSkin >> isNullSkin [ 

	^ true
]

{ #category : 'api - event managing' }
ToNullSkin >> wantsEvent: anEvent [

	^ false
]
