Class {
	#name : 'ToNullSkin',
	#superclass : 'ToSkin',
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'api - accessing' }
ToNullSkin >> eventsToHandle [

	^ { }
]

{ #category : 'testing' }
ToNullSkin >> isNullSkin [ 

	^ true
]

{ #category : 'api - event managing' }
ToNullSkin >> wantsEvent: anEvent [

	^ false
]
