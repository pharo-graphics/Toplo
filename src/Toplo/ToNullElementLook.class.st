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

{ #category : #'event handling' }
ToNullElementLook >> uninstallLookEvent: anEvent [
]
