Class {
	#name : 'ToNullSkin',
	#superclass : 'ToSkin',
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'event dispatch' }
ToNullSkin >> dispatchSkinInitialStateRequestTo: anObject [

	
]

{ #category : 'event dispatch' }
ToNullSkin >> dispatchSkinInstallStateRequestTo: anObject [

	
]

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
