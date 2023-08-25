Class {
	#name : #ToDefaultElementLook,
	#superclass : #ToElementLook,
	#category : #'Toplo-Core-Theme-Looks'
}

{ #category : #accessing }
ToDefaultElementLook class >> next: aLook [

	^ self new next: aLook
]

{ #category : #'event handling' }
ToDefaultElementLook >> clickLookEvent: anEvent [


]

{ #category : #'event handling' }
ToDefaultElementLook >> disabledLookEvent: anEvent [


]

{ #category : #'event handling' }
ToDefaultElementLook >> focusedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToDefaultElementLook >> hoveredLookEvent: anEvent [


]

{ #category : #'event handling' }
ToDefaultElementLook >> initialLookEvent: anEvent [


]

{ #category : #'event handling' }
ToDefaultElementLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent
]

{ #category : #'event handling' }
ToDefaultElementLook >> leavedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToDefaultElementLook >> pressedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToDefaultElementLook >> selectedLookEvent: anEvent [

]

{ #category : #'event handling' }
ToDefaultElementLook >> uninstallLookEvent: anEvent [

	super uninstallLookEvent: anEvent
]
