Class {
	#name : #ToNullSkin,
	#superclass : #ToSkin,
	#category : 'Toplo-Core-Skin'
}

{ #category : #'event dispatch' }
ToNullSkin >> dispatchSkinChangedEventTo: anObject [

	
]

{ #category : #'event dispatch' }
ToNullSkin >> dispatchSkinRequestedEventTo: anObject [

	
]

{ #category : #'api - accessing' }
ToNullSkin >> eventsToHandle [

	^ { }
]

{ #category : #testing }
ToNullSkin >> isNullSkin [ 

	^ true
]

{ #category : #'api - event managing' }
ToNullSkin >> wantsEvent: anEvent [

	^ false
]
