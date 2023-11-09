Class {
	#name : 'ToNullSkin',
	#superclass : 'ToSkin',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'event dispatch' }
ToNullSkin >> dispatchSkinInitialStateRequestTo: anObject [

	
]

{ #category : 'event dispatch' }
ToNullSkin >> dispatchSkinInstallStateRequestTo: anObject [

	
]

{ #category : 'event dispatch' }
ToNullSkin >> dispatchSkinUninstallStateRequestTo: anObject [

	
]

{ #category : 'api - accessing' }
ToNullSkin >> eventsToHandle [

	^ { }
]

{ #category : 'testing' }
ToNullSkin >> isNullSkin [ 

	^ true
]

{ #category : 'style updating' }
ToNullSkin >> updateStylesIn: anElement [
]

{ #category : 'api - event managing' }
ToNullSkin >> wantsEvent: anEvent [

	^ false
]
