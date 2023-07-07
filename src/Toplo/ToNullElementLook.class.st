Class {
	#name : #ToNullElementLook,
	#superclass : #ToAbstractElementLook,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #'private event handling' }
ToNullElementLook >> elementLookEvent: anEvent [
]

{ #category : #'event handling' }
ToNullElementLook >> installLookEvent: anEvent [
]

{ #category : #testing }
ToNullElementLook >> isMain [

	^ false
]

{ #category : #testing }
ToNullElementLook >> isNull [

	^ true
]

{ #category : #accessing }
ToNullElementLook >> next: aLook [
]

{ #category : #initialization }
ToNullElementLook >> setMainLook: aLook [

	Error signal: 'Should not be sent to me'.
]

{ #category : #'event handling' }
ToNullElementLook >> uninstallLookEvent: anEvent [
]
